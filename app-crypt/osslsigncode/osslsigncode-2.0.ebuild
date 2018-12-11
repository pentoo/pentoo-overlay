# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

#inherit autotools

DESCRIPTION="Platform-independent tool for Authenticode signing of EXE/CAB files"
HOMEPAGE="https://sourceforge.net/projects/osslsigncode"
SRC_URI="https://github.com/mtrojnar/osslsigncode/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="curl libressl"

RDEPEND="
	!libressl? ( >=dev-libs/openssl-1.1.0:0= )
	libressl? ( >=dev-libs/libressl-2.7.0:0= )
	curl? ( net-misc/curl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	./autogen.sh
#	eautoreconf
	eapply_user
}

src_configure() {
	econf $(use_with curl)
}
