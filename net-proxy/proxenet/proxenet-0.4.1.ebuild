# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils

DESCRIPTION="A hacker friendly proxy for web application penetration tests."
HOMEPAGE="https://github.com/hugsy/proxenet"
SRC_URI="https://github.com/hugsy/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-libs/mbedtls"
RDEPEND="${DEPEND}
	net-proxy/proxenet-plugins"

CMAKE_IN_SOURCE_BUILD=1

src_prepare() {
	sed -i -e "s|/opt/proxenet/misc/openssl.cnf|./openssl.cnf|" keys/proxenet-setup-ca.sh
}

src_configure() {
#		-DCMAKE_SKIP_INSTALL_RPATH:BOOL=YES
#		-DCMAKE_SKIP_RPATH:BOOL=YES

	#https://github.com/hugsy/proxenet/issues/41
	local mycmakeargs=(
		-DUSE_JAVA_PLUGIN:BOOL=NO
	)
	cmake-utils_src_configure
	cd ./keys
	emake keys
}

src_install() {
	insinto /usr/share/${PN}
	cp {proxenet,proxenet-control-cli.py,proxenet-control-web.py} "${D}/usr/share/${PN}/"
	doins -r keys
	dodir /usr/share/${PN}/proxenet-plugins/autoload
	dobin "${FILESDIR}/${PN}"
}
