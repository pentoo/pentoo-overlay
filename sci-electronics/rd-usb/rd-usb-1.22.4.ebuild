# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
inherit python-single-r1

DESCRIPTION="Web GUI for RuiDeng/Riden USB testers (UM34C, UM24C, UM25C, TC66C)"
HOMEPAGE="https://github.com/kolinger/rd-usb"
SRC_URI="https://github.com/kolinger/rd-usb/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
WEBAPP_MANUAL_SLOT="yes"
KEYWORDS="amd64 ~arm64 ~x86"

IUSE="gui"

RDEPEND="$(python_gen_cond_dep '
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/pyserial[${PYTHON_USEDEP}]
	dev-python/python-socketio[${PYTHON_USEDEP}]
	dev-python/python-engineio[${PYTHON_USEDEP}]
	dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/bleak[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/pybluez[${PYTHON_USEDEP}]
	<dev-python/pendulum-3.0.0[${PYTHON_USEDEP}]

	gui? ( dev-python/pywebview[${PYTHON_USEDEP}]
	dev-python/pythonnet[${PYTHON_USEDEP}]
	dev-python/screeninfo[${PYTHON_USEDEP}] )
	')
	${PYTHON_DEPS}
"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest

INSTALLDIR="/usr/share/${PN}"

#pkg_setup() {
#	python-single-r1_pkg_setup
#}

src_prepare() {
	rm -r {bin,docker,pyinstaller}

	sed -i -e "1i #!/usr/bin/env python\n" web.py || die
	python_fix_shebang web.py
	default
}

src_install() {
	newbin - ${PN}_web <<-EOF
		#!/bin/sh

		cd ${INSTALLDIR}
		${EPYTHON} ./web.py "\$@"
	EOF

	insinto "${INSTALLDIR}"
	doins -r .
}
