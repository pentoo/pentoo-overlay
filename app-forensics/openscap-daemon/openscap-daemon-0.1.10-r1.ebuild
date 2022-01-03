# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )
PYTHON_REQ_USE="xml"

inherit distutils-r1

DESCRIPTION="Manages continuous scans of your infrastructure"
HOMEPAGE="https://www.open-scap.org/tools/openscap-daemon"
SRC_URI="https://github.com/OpenSCAP/openscap-daemon/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT=0
KEYWORDS="~amd64"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="!test? ( test )"

RDEPEND="${PYTHON_DEPS}
	app-forensics/openscap
	app-forensics/scap-security-guide
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}"/${P}_gentoo.patch )

src_test() {
	tests/unit/make_check || die
	tests/integration/make_check || die
}

src_install() {
	distutils-r1_src_install

	newinitd "${FILESDIR}"/oscapd.initd oscapd
	keepdir "/var/lib/oscapd" "/etc/oscapd"

	dodoc container/config.ini
}
