# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Lightweight static analysis for many languages"
HOMEPAGE="https://github.com/returntocorp/semgrep"

#SRC_URI="https://files.pythonhosted.org/packages/3.6/f/frida/frida-12.0.3-py3.6-linux-x86_64.egg"
SRC_URI="https://files.pythonhosted.org/packages/18/1c/adc86207bd0431d1cbbb57ddb2912544c2e1ef8587e8ab5de48dc771b181/semgrep-0.52.0-cp36.cp37.cp38.cp39.py36.py37.py38.py39-none-any.whl -> ${P}.zip"
#https://files.pythonhosted.org/packages/2e/73/6c387511c94d95a1ebcfe5afde2e4830ae236a9076576a5e9d7f65d35be5/semgrep-0.42.0-cp36.cp37.cp38.py36.py37.py38-none-any.whl -> ${P}.zip"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/semgrep-${PV}.data"

src_install(){
	dobin purelib/semgrep/bin/{semgrep-core,spacegrep}
}
