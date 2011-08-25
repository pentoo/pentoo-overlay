# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

ETYPE="sources"
#K_WANT_GENPATCHES="base extras"
#K_GENPATCHES_VER="5"
#PENPATCHES_VER="3"
inherit kernel-2
detect_version
detect_arch
K_SECURITY_UNSUPPORTED="1"

KEYWORDS="arm"
HOMEPAGE="http://dev.pentoo.ch/~grimmlin/n900"
IUSE=""
DESCRIPTION="Full sources from meego for the ${KV_MAJOR}.${KV_MINOR} kernel tree"

SRC_URI="http://dev.pentoo.ch/~grimmlin/n900/linux-2.6.37.tar.gz"

src_unpack() {
	cd "${WORKDIR}"
	unpack "${A}"
	if [[ -d "linux" ]]; then
		mv linux linux-${KV_FULL} \
			|| die "Unable to move source tree to ${KV_FULL}."
	elif [[ "${OKV}" != "${KV_FULL}" ]]; then
		mv linux-${OKV} linux-${KV_FULL} \
			|| die "Unable to move source tree to ${KV_FULL}."
	fi
	cd "${S}"

	# remove all backup files
	find . -iname "*~" -exec rm {} \; 2> /dev/null

	unpack_set_extraversion
}
