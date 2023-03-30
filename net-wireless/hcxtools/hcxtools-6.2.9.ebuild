# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Portable solution for capturing wlan traffic and conversion to hashcat formats"
HOMEPAGE="https://github.com/ZerBea/hcxtools"
SRC_URI="https://github.com/ZerBea/hcxtools/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE=""

DEPEND="
	>=dev-libs/openssl-3.0.8:=
	sys-libs/zlib
	net-misc/curl
	net-libs/libpcap:="

RDEPEND="${DEPEND}"

src_install(){
	emake DESTDIR="${ED}" PREFIX="${EPREFIX}/usr" install
}
