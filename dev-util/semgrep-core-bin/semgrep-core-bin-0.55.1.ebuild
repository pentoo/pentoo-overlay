# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Lightweight static analysis for many languages"
HOMEPAGE="https://github.com/returntocorp/semgrep"

#SRC_URI="https://files.pythonhosted.org/packages/3.6/f/frida/frida-12.0.3-py3.6-linux-x86_64.egg"
SRC_URI="https://files.pythonhosted.org/packages/3c/32/ab2945f7d4122f8204e199aacdb3bf685096d5c93d61e709c1db9d8a65de/semgrep-0.55.1-cp36.cp37.cp38.cp39.py36.py37.py38.py39-none-any.whl -> ${P}.zip"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/semgrep-${PV}.data"

src_install(){
	dobin purelib/semgrep/bin/{semgrep-core,spacegrep}
}
