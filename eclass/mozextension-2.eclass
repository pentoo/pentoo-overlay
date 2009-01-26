# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/mozextension.eclass,v 1.4 2007/12/20 15:43:14 armin76 Exp $
#
# mozextention.eclass: installing firefox extensions and language packs

inherit eutils

DEPEND="app-arch/unzip"

xpi_unpack() {
	local xpi xpiname srcdir

	# Not gonna use ${A} as we are looking for a specific option being passed to function
	# You must specify which xpi to use
	[[ -z "$*" ]] && die "Nothing passed to the $FUNCNAME command. please pass which xpi to unpack"

	for xpi in "$@"; do
		einfo "Unpacking ${xpi} to ${PWD}"
		xpiname=$(basename ${xpi%.*})

		if   [[ "${xpi:0:2}" != "./" ]] && [[ "${xpi:0:1}" != "/" ]] ; then
			srcdir="${DISTDIR}/"
		fi

		[[ -s "${srcdir}${xpi}" ]] ||  die "${xpi} does not exist"

		case "${xpi##*.}" in
			ZIP|zip|jar|xpi)
				mkdir "${WORKDIR}/${xpiname}" && \
					cd "${WORKDIR}/${xpiname}" && \
					unzip -qo "${srcdir}${xpi}" ||  die "failed to unpack ${xpi}"
				;;
			*)
				einfo "unpack ${xpi}: file format not recognized. Ignoring."
				;;
		esac
	done
}


xpi_install() {
	local emid

	# You must tell xpi_install which xpi to use
	[[ ${#} -ne 1 ]] && die "$FUNCNAME takes exactly one argument, please specify an xpi to unpack"

	x="${1}"
	cd ${x}
	# determine id for extension
	emid=$(sed -n -e '/ec8030f7-c20a-464f-9b0e-13a3a9e97384/d; /<\?em:id>\?/!d; s/.*\([\"{].*[}\"]\).*/\1/; s/\"//g; s/.*<em:id>\(.*\)<\/em:id>/\1/; p; q' ${x}/install.rdf) || die "failed to determine extension id"
	insinto "${MOZILLA_FIVE_HOME}"/extensions/${emid}
	doins -r "${x}"/* || die "failed to copy extension"
}
