# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit pypi

DESCRIPTION="Lightweight static analysis for many languages"
HOMEPAGE="https://github.com/returntocorp/semgrep"

PY_TAG="cp38.cp39.cp310.cp311.py37.py38.py39.py310.py311"
#SRC_URI="https://files.pythonhosted.org/packages/${PY_TAG}/${P:0:1}/semgrep/semgrep-${PV}-${PY_TAG}-none-any.whl -> ${P}.zip"

SRC_URI="$(pypi_wheel_url semgrep ${PV} ${PY_TAG})"

S="${WORKDIR}/semgrep-${PV}.data"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64"

BDEPEND="app-arch/unzip"

src_install(){
	dobin purelib/semgrep/bin/semgrep-core
}
