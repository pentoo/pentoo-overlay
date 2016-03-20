# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils

DESCRIPTION="Advanced command line hexadecimal editor and more"
HOMEPAGE="http://www.radare.org"
SRC_URI="https://github.com/radare/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+capstone ssl"

RDEPEND="capstone? ( dev-util/capstone:= )
	ssl? ( dev-libs/openssl:= )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.9.9-nogit.patch
}

src_configure() {
	econf \
		$(use_with ssl openssl) \
		$(use_with capstone syscapstone)
}

src_install() {
	# a workaround for unstable $(INSTALL) call, bug #574866
	local d
	for d in doc/*; do
		if [[ -d $d ]]; then
			rm -rfv "$d" || die "failed to delete '$d'"
		fi
	done

	default
}
