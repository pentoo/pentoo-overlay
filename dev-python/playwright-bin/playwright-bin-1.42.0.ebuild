# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

MY_PN=${PN//-bin/}
MY_P=${MY_PN}-${PV}
HOSTED="files.pythonhosted.org/packages/py3/${MY_P:0:1}/${MY_PN}/${MY_P}-py3-none"

DESCRIPTION="Automate Chromium, Firefox and WebKit browsers with a single API"
HOMEPAGE="https://github.com/Microsoft/playwright-python"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

SRC_URI="
	amd64? (
		https://${HOSTED}-manylinux1_x86_64.whl -> ${MY_P}_x86_64.zip
	)
	arm64? (
		https://${HOSTED}-manylinux_2_17_aarch64.manylinux2014_aarch64.whl -> ${MY_P}_aarch64.zip
	)
"

#RDEPEND=""
#DEPEND="${RDEPEND}"
BDEPEND="app-arch/unzip"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"

QA_PREBUILT="usr/lib/python*/site-packages/playwright/driver/node"

S="${WORKDIR}/"

pkg_setup() {
	python_setup
}

src_compile() {
	einfo
}

#python_src_install() {
src_install() {
#	insinto "$(python_get_sitedir)"
#	doins playwright
#	doins playwright-1.42.0.dist-info

	do_install() {
		python_domodule "${MY_PN}"
		python_domodule "${MY_PN}-${PV}.dist-info"
		#FIXME: playwright/driver/node and playwright.sh must be executable?
		#dosym  /opt/${MY_PN} "$(python_get_sitedir)/${MY_PN}/executable"
	}
	python_foreach_impl do_install

}
