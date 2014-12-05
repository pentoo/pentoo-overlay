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

# @ECLASS-VARIABLE: MZA_TARGETS
# @REQUIRED
# @DEFAULT_UNSET
# @DESCRIPTION:
# Space separated list of target packages. Allowed items:
# firefox, thunderbird, seamonkey, firefox-bin, thunderbird-bin, seamonkey-bin
#
# MZA_TARGETS=firefox firefox-bin

# @ECLASS-VARIABLE: MZA_XPI_PATH
# @DESCRIPTION:
# PAth to unpacked xpi content for installation. Default is ${WORKDIR/${P}.
: ${MZA_XPI_PATH:=${WORKDIR}/${P}}

# This eclass supports all EAPIs
EXPORT_FUNCTIONS src_unpack src_install

# @FUNCTION: mozilla-addon_dosym
# @DESCRIPTION:
# creates a symlink to the global installation target
mozilla-addon_dosym() {
	# 2 required arguments
	[[ ${#} -ne 2 ]] && die "$FUNCNAME takes exactly two arguments. Please specify the global-installation-path plus the full symlink to it."
	local installpath="${1}"
	local symlinkpath="${2}"
	# conversion from previous installations without symlink
	# portage does prevent replacing dir with a symlink
	if [[ -e "${symlinkpath}" ]] \
		&& ! [[ -h "${symlinkpath}" ]]; then
		addwrite "${symlinkpath}" || die 'addwrite failed'
		rm -rf "${symlinkpath}" || die 'rm failed'
	fi
	dosym "${installpath}" \
		"${symlinkpath}"
}

# @FUNCTION: mozilla-addon_getemid
# @DESCRIPTION:
# Parses em:id from install.rdf file
# Avoid using awk with this dummy parser function
mozilla-addon_getemid() {
	# no arguments allowed
	[[ ${#} -ne 0 ]] && die "$FUNCNAME takes no arguments."
	[[ ! -r "${MZA_XPI_PATH}/install.rdf" ]] && die "$FUNCNAME cannot read file ${MZA_XPI_PATH}/install.rdf"
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
	done < "${MZA_XPI_PATH}/install.rdf"
	[[ -n "${emid}" ]] || die "$FUNCNAME could not find em:id!"
	echo -n "${emid}"
}

# @FUNCTION: mozilla-addon_verifytarget
# @DESCRIPTION:
# Search for target package id in install.rdf. Warn if it's not found.
mozilla-addon_verifytarget() {
	[[ ${#} -ne 1 ]] && die "$FUNCNAME takes exactly one argument. Please specify the target package"
	[[ ! -r "${MZA_XPI_PATH}/install.rdf" ]] && die "$FUNCNAME cannot read file ${MZA_XPI_PATH}/install.rdf"
	# check target in install.rdf
	case ${1} in
		firefox|firefox-bin)
			grep -q '<em:id>{ec8030f7-c20a-464f-9b0e-13a3a9e97384}</em:id>' \
				"${MZA_XPI_PATH}/install.rdf" \
				 || ewarn 'Firefox not found as target in install.rdf' ;;
		thunderbird|thunderbird-bin)
			grep -q '<em:id>{3550f703-e582-4d05-9a08-453d09bdfdc6}</em:id>' \
				"${MZA_XPI_PATH}/install.rdf" \
				 || ewarn 'Thunderbird not found as target in install.rdf' ;;
		seamonkey|seamonkey-bin)
			grep -q '<em:id>{92650c4d-4b8e-4d2a-b7eb-24ecf4f6b63a}</em:id>' \
				"${MZA_XPI_PATH}/install.rdf" \
				 || ewarn 'Seamonkey not found as target in install.rdf' ;;
		*) die "$FUNCNAME received unexptected target package ${1}" ;;
	esac
	return 0
}

# @FUNCTION: mozilla-addon_src_unpack
# @DESCRIPTION:
# Default src_unpack function for firefox addons
mozilla-addon_src_unpack() {
	xpi_unpack ${A}
}

# @FUNCTION: mozilla-addon_src_install
# @DESCRIPTION:
# Default install function for firefox addons
mozilla-addon_src_install() {
	local emid
	local installpath
	local count=0
	# sanity check, at least one of these targets must be set
	if ! has 'firefox' $MZA_TARGETS \
		&& ! has 'thunderbird' $MZA_TARGETS \
		&& ! has 'seamonkey' $MZA_TARGETS \
		&& ! has 'firefox-bin' $MZA_TARGETS \
		&& ! has 'thunderbird-bin' $MZA_TARGETS \
		&& ! has 'seamonkey-bin' $MZA_TARGETS; then
		die "At least one of these targets (firefox thunderbird seamonkey firefox-bin thunderbird-bin seamonkey-bin) must be set to use this eclass."
	fi
	emid="$(mozilla-addon_getemid)" \
		|| die "failed to determine extension id"
	installpath="/usr/$(get_libdir)/mozilla/extensions/${emid}"
	# install to global installation folder
	insinto "${installpath}" || die "insinto failed"
	doins -r "${MZA_XPI_PATH}"/* || die "failed to copy extension"
	# symlink each target
	# target: firefox
	if has 'firefox' $MZA_TARGETS; then
		mozilla-addon_verifytarget firefox
		mozilla-addon_dosym "${installpath}" \
			"/usr/$(get_libdir)/firefox/browser/extensions/${emid}"
		count=$((count+1))
		mozilla-addon_dosym "${installpath}" \
			"/usr/$(get_libdir)/firefox/extensions/${emid}"
		count=$((count+1))
	fi
	# target: firefox-bin
	if has 'firefox-bin' $MZA_TARGETS; then
		mozilla-addon_dosym "${installpath}" \
			"/opt/firefox/browser/extensions/${emid}"
		count=$((count+1))
		mozilla-addon_dosym "${installpath}" \
			"/opt/firefox/extensions/${emid}"
		count=$((count+1))
	fi
	# target: thunderbird
	if has 'thunderbird' $MZA_TARGETS; then
		mozilla-addon_verifytarget thunderbird
		mozilla-addon_dosym "${installpath}" \
			"/usr/$(get_libdir)/thunderbird/extensions/${emid}"
		count=$((count+1))
	fi
	# target: thunderbird-bin
	if has 'thunderbird-bin' $MZA_TARGETS; then
		mozilla-addon_verifytarget thunderbird
		mozilla-addon_dosym "${installpath}" \
			"/opt/thunderbird/extensions/${emid}"
		count=$((count+1))
	fi
	# target: seamonkey
	if has 'seamonkey' $MZA_TARGETS; then
		mozilla-addon_verifytarget seamonkey
		mozilla-addon_dosym "${installpath}" \
			"/usr/$(get_libdir)/seamonkey/extensions/${emid}"
		count=$((count+1))
	fi
	# target: seamonkey-bin
	if has 'seamonkey-bin' $MZA_TARGETS; then
		mozilla-addon_verifytarget seamonkey
		mozilla-addon_dosym "${installpath}" \
			"/opt/seamonkey/extensions/${emid}"
		count=$((count+1))
	fi
	# sanity check
	[[ "${count}" -gt 0 ]] || die "Error in $FUNCNAME: No target was installed, this seems wrong!"
}
