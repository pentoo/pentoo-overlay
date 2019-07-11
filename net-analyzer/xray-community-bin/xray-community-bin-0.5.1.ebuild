# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A Vulnerability Scanner for All Environments"
HOMEPAGE="https://www.chaitin.cn/en/xray https://github.com/chaitin/xray"
SRC_URI="https://github.com/chaitin/xray/releases/download/${PV}/xray_linux_amd64.zip -> xray_community_amd64-${PV}.zip"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="strip"

DEPEND="app-arch/unzip"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	mkdir -p "${D}/usr/bin/"
	cp "${S}/xray_linux_amd64" "${D}/usr/bin/xray"
}
