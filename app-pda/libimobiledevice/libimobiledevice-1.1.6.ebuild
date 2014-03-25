# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libimobiledevice/libimobiledevice-1.1.5.ebuild,v 1.6 2014/03/01 22:19:35 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )
inherit eutils python-r1 multilib

DESCRIPTION="Support library to communicate with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0/4"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86"
IUSE="gnutls python"

RDEPEND=">=app-pda/libplist-1.10[python?,${PYTHON_USEDEP}]
	>=app-pda/libusbmuxd-1.0.9
	gnutls? (
		dev-libs/libgcrypt:0
		>=dev-libs/libtasn1-1.1
		>=net-libs/gnutls-2.2.0
		)
	!gnutls? ( dev-libs/openssl:0 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	python? (
		${PYTHON_DEPS}
		>=dev-python/cython-0.17[${PYTHON_USEDEP}]
		)"

pkg_setup() {
	# Prevent linking to the installed copy
	if has_version "<${CATEGORY}/${P}"; then
		rm -f "${EROOT}"/usr/$(get_libdir)/${PN}$(get_libname)
	fi
}

src_configure() {
	use python && python_export_best

	local myconf
	use gnutls && myconf='--disable-openssl'
	use python || myconf+=' --without-cython'

	econf --disable-static ${myconf}
}

src_install() {
	default
	dohtml docs/html/*
	dodoc AUTHORS NEWS README

	prune_libtool_files --all
}
