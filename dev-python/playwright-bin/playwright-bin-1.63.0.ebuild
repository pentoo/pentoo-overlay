# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

MY_PN=${PN//-bin/}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Automate Chromium, Firefox and WebKit browsers with a single API"
HOMEPAGE="https://github.com/Microsoft/playwright-python"

SRC_URI="
	amd64? (
		https://files.pythonhosted.org/packages/27/9c/103a5037789062bdab27c7dca53f3ca6b075b572ab2cd96eec825b3aec4e/${MY_P}-py3-none-manylinux1_x86_64.whl -> ${MY_P}_x86_64.zip
	)
	arm64? (
		https://files.pythonhosted.org/packages/f3/82/3d85505284c5a210f2da6c07b8f757524e79d1fba9cfdafe1eafb766ae59/${MY_P}-py3-none-manylinux_2_17_aarch64.manylinux2014_aarch64.whl -> ${MY_P}_aarch64.zip
	)
"
S="${WORKDIR}/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

BDEPEND="app-arch/unzip"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"

QA_PREBUILT="usr/lib/python*/site-packages/playwright/driver/node"

pkg_setup() {
	python_setup
}

src_compile() {
	einfo
}

src_install() {
	do_install() {
		python_domodule "${MY_PN}"
		python_domodule "${MY_PN}-${PV}.dist-info"
	}
	python_foreach_impl do_install
}
