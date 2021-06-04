# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Generate plainmasterkeys (rainbowtables) and hashes for hashcat/JTR"
HOMEPAGE="https://github.com/ZerBea/hcxkeys"
SRC_URI="https://github.com/ZerBea/hcxkeys/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-libs/openssl:*
	virtual/opencl"
RDEPEND="${DEPEND}"

src_install(){
	emake DESTDIR="${ED}" PREFIX="${EPREFIX}/usr" install
}
