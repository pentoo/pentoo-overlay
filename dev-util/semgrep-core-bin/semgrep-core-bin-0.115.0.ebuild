# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Lightweight static analysis for many languages"
HOMEPAGE="https://github.com/returntocorp/semgrep"

PY_VER="cp37.cp38.cp39.py37.py38.py39"
SRC_URI="
	https://files.pythonhosted.org/packages/${PY_VER}/${P:0:1}/semgrep/semgrep-${PV}-${PY_VER}-none-any.whl -> ${P}.zip
"
#https://files.pythonhosted.org/packages/5e/6e/9af27d57c76abbfe1fda1ebebd41ddc730092bb1bfaa4b6b42ccc2324207/
#semgrep-0.103.0-cp37.cp38.cp39.py37.py38.py39-none-any.whl
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/semgrep-${PV}.data"

src_install(){
	dobin purelib/semgrep/bin/semgrep-core
}
