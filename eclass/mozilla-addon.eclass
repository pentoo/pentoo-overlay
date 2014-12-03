# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: mozilla-addon.eclass
# @MAINTAINER:
# Stefan Kuhn <wuodan@pentoo.ch>
# @BLURB: Eclass for installing firefox addons.
# @DESCRIPTION:
# Install addons for firefox

inherit mozextension multilib

# @ECLASS-VARIABLE: FFP_TARGETS
# @REQUIRED
# @DEFAULT_UNSET
# @DESCRIPTION:
# Space separated list of target packages. Allowed items: firefox, thunderbird. Must be set before the inherit for correct dependencies!
#
# FFP_TARGETS=firefox

# @ECLASS-VARIABLE: FFP_XPI_FILE
# @DESCRIPTION:
# Filename of downloaded .xpi file without the .xpi ending. Default is $P.
: ${FFP_XPI_FILE:=${P}}

# This eclass supports all EAPIs
EXPORT_FUNCTIONS src_unpack src_install

# sanity check, at least one of these targets must be set
if ! has 'firefox' $FFP_TARGETS \
	&& ! has 'thunderbird' $FFP_TARGETS; then
	die "At least one of these targets (firefox thunderbird) must be set before the inherit of this eclass."
fi

# repoman does not like grep in global scope
if has 'firefox' $FFP_TARGETS; then
	RDEPEND+="
		|| (
		www-client/firefox-bin
		www-client/firefox )"
fi
if has 'thunderbird' $FFP_TARGETS; then
	RDEPEND+="
		|| (
		mail-client/thunderbird-bin
		mail-client/thunderbird )"
fi

DEPEND="$DEPEND $RDEPEND"

S="$WORKDIR"

# @FUNCTION: mozilla-addon_src_unpack
# @DESCRIPTION:
# Default src_unpack function for firefox addons
mozilla-addon_src_unpack() {
	xpi_unpack $FFP_XPI_FILE.xpi
}

# @FUNCTION: mozilla-addon_getemid
# @DESCRIPTION:
# Parses em:id from install.rdf file
# Avoid using awk with this dummy parser function
mozilla-addon_getemid() {
	#  path to install.rdf is a required argument
	[[ ${#} -ne 1 ]] && die "$FUNCNAME takes exactly one argument. Please specify the path to the install.rdf file"
	[[ ! -r "${1}" ]] && die "$FUNCNAME cannot read file ${1}"
	local line
	local targetapp=0
	local emid
	while read line; do
		# comment lines
		echo -n "${line}" | grep -q '^[[:space:]]*#' \
			&& continue
		echo -n "${line}" | grep -q '<em:targetApplication>' \
			&& targetapp=1
		if [[ "${targetapp}" -eq 0 ]] \
			&& echo -n "${line}" | grep -Eq '<em:id>[^<]+</em:id>'; then
			emid="$(echo -n "${line}" | sed -r 's#^.*<em:id>([^<]+)</em:id>.*$#\1#')"
			break
		# other format, see install.rdf of www-client/exif_viewer
		elif [[ "${targetapp}" -eq 0 ]] \
			&& echo -n "${line}" | grep -Eq 'em:id="[^"]+"'; then
			emid="$(echo -n "${line}" | sed -r 's#^.*em:id="([^"]+)".*$#\1#')"
			break
		fi
		echo -n "${line}" | grep -q '</em:targetApplication>' \
			&& targetapp=0
	done < "${1}"
	[[ -n "${emid}" ]] || die "$FUNCNAME could not find em:id!"
	echo -n "${emid}"
}

# @FUNCTION: mozilla-addon_getlocation
# @DESCRIPTION:
# Get correct installation location for a target package
mozilla-addon_getlocation() {
	#  target pkg is a required argument, can be ${PN} or firefox|thunderbird
	[[ ${#} -ne 1 ]] && die "$FUNCNAME takes exactly one argument. Please specify the target package"
	case ${1} in
		firefox)
			if has_version '>=www-client/firefox-21'; then
				echo -n "/usr/$(get_libdir)/firefox/browser/extensions"
			else
				echo -n "/usr/$(get_libdir)/firefox/extensions"
			fi ;;
		firefox-bin)
			if has_version '>=www-client/firefox-bin-21'; then
				echo -n "/opt/firefox/browser/extensions"
			else
				echo -n "/opt/firefox/extensions"
			fi ;;
		thunderbird-bin)
			echo -n "/opt/thunderbird/extensions" ;;
		*) die "$FUNCNAME received unexptected target package ${1}" ;;
	esac
	return 0
}

# @FUNCTION: mozilla-addon_verifytarget
# @DESCRIPTION:
# Search for target package id in install.rdf. Warn if it's not found.
mozilla-addon_verifytarget() {
	[[ ${#} -ne 1 ]] && die "$FUNCNAME takes exactly one argument. Please specify the target package"
	# check target in install.rdf
	case ${1} in
		firefox|firefox-bin)
			grep -q '<em:id>{ec8030f7-c20a-464f-9b0e-13a3a9e97384}</em:id>' \
				"${WORKDIR}/${P}/install.rdf" \
				 || ewarn 'Firefox not found as target in install.rdf' ;;
		thunderbird|thunderbird-bin)
			grep -q '<em:id>{3550f703-e582-4d05-9a08-453d09bdfdc6}</em:id>' \
				"${WORKDIR}/${P}/install.rdf" \
				 || ewarn 'Thunderbird not found as target in install.rdf' ;;
		*) die "$FUNCNAME received unexptected target package ${1}" ;;
	esac
	return 0
}

# @FUNCTION: mozilla-addon_src_install
# @DESCRIPTION:
# Default install function for firefox addons
mozilla-addon_src_install() {
	local emid
	local count=0
	emid="$(mozilla-addon_getemid "${FFP_XPI_FILE}"/install.rdf)" \
		|| die "failed to determine extension id"
	# install each target
	# target: firefox
	if has 'firefox' $FFP_TARGETS; then
		mozilla-addon_verifytarget firefox
		# firefox pkg
		if has_version www-client/firefox; then
			insinto $(mozilla-addon_getlocation firefox)/${emid} || die "insinto failed"
			doins -r "${FFP_XPI_FILE}"/* || die "failed to copy extension"
			count=$((count+1))
		fi
		# firefox-bin pkg
		if has_version www-client/firefox-bin; then
			insinto $(mozilla-addon_getlocation firefox-bin)/${emid} || die "insinto failed"
			doins -r "${FFP_XPI_FILE}"/* || die "failed to copy extension"
			count=$((count+1))
		fi
	fi
	# target: thunderbird
	if has 'thunderbird' $FFP_TARGETS; then
		mozilla-addon_verifytarget thunderbird
		# thunderbird pkg
		if has_version mail-client/thunderbird; then
			insinto $(mozilla-addon_getlocation thunderbird)/${emid} || die "insinto failed"
			doins -r "${FFP_XPI_FILE}"/* || die "failed to copy extension"
			count=$((count+1))
		fi
		# thunderbird-bin pkg
		if has_version mail-client/thunderbird-bin; then
			insinto $(mozilla-addon_getlocation thunderbird-bin)/${emid} || die "insinto failed"
			doins -r "${FFP_XPI_FILE}"/* || die "failed to copy extension"
			count=$((count+1))
		fi
	fi
	# sanity check
	[[ "${count}" -lt 1 ]] && die "Error in $FUNCNAME: Nothing was installed, this seems wrong!"
}
