# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="kaleido"

PYTHON_COMPAT=( python3_{9..10} )
inherit python-r1

DESCRIPTION="Static image export for web-based visualization libraries"
HOMEPAGE="https://github.com/plotly/Kaleido"

SRC_URI="
amd64? (
	https://files.pythonhosted.org/packages/py2.py3/${P:0:1}/${MY_PN}/kaleido-${PV}-py2.py3-none-manylinux1_x86_64.whl -> ${P}_x86_64.zip
)
arm64? (
	https://files.pythonhosted.org/packages/py2.py3/${P:0:1}/${MY_PN}/kaleido-0.2.1-py2.py3-none-manylinux2014_aarch64.whl
)

"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64"
IUSE=""

RDEPEND="dev-util/kaleido-bin"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

S="${WORKDIR}/"

src_prepare() {
	#use dev-util/kaleiodo
	rm -r ${MY_PN}/executable
	eapply_user
}

src_install() {
	do_install() {
		python_domodule "${MY_PN}"
		python_domodule "${MY_PN}-${PV}.dist-info"
		#symlink to dev-util/kaleiodo
		dosym  /opt/${MY_PN} "$(python_get_sitedir)/${MY_PN}/executable"
	}
	python_foreach_impl do_install
}
