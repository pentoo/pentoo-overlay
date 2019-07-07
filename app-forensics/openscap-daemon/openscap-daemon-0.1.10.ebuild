# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )
PYTHON_REQ_USE="xml"

inherit distutils-r1

DESCRIPTION="Manages continuous scans of your infrastructure"
HOMEPAGE="https://www.open-scap.org/tools/openscap-daemon"
SRC_URI="https://github.com/OpenSCAP/openscap-daemon/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT=0
KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
PATCHES=( "${FILESDIR}"/${P}_gentoo.patch )

RDEPEND="${PYTHON_DEPS}
	app-forensics/scap-security-guide
	dev-python/dbus-python[${PYTHON_USEDEP}]"

src_install() {
	distutils-r1_src_install

	newinitd "${FILESDIR}"/oscapd.initd oscapd
	keepdir "/var/lib/oscapd" "/etc/oscapd"

	dodoc container/config.ini
}
