# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit pypi

DESCRIPTION="Lightweight static analysis for many languages"
HOMEPAGE="https://github.com/returntocorp/semgrep"

PY_TAG="cp37.cp38.cp39.py37.py38.py39"
#SRC_URI="$(pypi_wheel_url semgrep ${PV} ${PY_TAG})"
SRC_URI="https://files.pythonhosted.org/packages/${PY_TAG}/${P:0:1}/semgrep/semgrep-${PV}-${PY_TAG}-none-any.whl -> ${P}.zip"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64"

BDEPEND="app-arch/unzip"

S="${WORKDIR}/semgrep-${PV}.data"

src_install(){
	dobin purelib/semgrep/bin/semgrep-core
}
