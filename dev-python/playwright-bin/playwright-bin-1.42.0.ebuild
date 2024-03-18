# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi


MY_PN=${PN//-bin/}
MY_P=${MY_PN}-${PV}

DESCRIPTION=""
HOMEPAGE=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"

SRC_URI="
	amd64? (
		https://files.pythonhosted.org/packages/py3/${MY_P:0:1}/${MY_PN}/${MY_P}-py3-none-manylinux1_x86_64.whl -> ${MY_P}_x86_64.zip
	)
	arm64? (
		https://files.pythonhosted.org/packages/py3/${MY_P:0:1}/${MY_PN}/${MY_P}-py3-none-manylinux_2_17_aarch64.manylinux2014_aarch64.whl  -> ${MY_P}_aarch64.zip
	)
"

RDEPEND=""
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
#distutils_enable_tests pytest

# * QA Notice: Files built without respecting LDFLAGS have been detected
# *  Please include the following list of files in your report:
# * /usr/lib/python3.11/site-packages/playwright/driver/node
# * /usr/lib/python3.12/site-packages/playwright/driver/node

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
