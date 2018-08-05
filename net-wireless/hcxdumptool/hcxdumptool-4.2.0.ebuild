# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="https://foo.example.org/"
MY_COMMIT="ebfcdf0243604d36dfac2757d4373bd9331b8a9a"
SRC_URI="https://github.com/ZerBea/hcxdumptool/archive/${MY_COMMIT}.zip -> ${P}.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_COMMIT}"

src_prepare(){
	epatch "${FILESDIR}/makefile.patch"
	eapply_user
}

src_install(){
	emake DESTDIR="${ED}" PREFIX="${EPREFIX}/usr" install
}
