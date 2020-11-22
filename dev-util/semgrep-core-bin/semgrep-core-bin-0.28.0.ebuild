# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Lightweight static analysis for many languages"
HOMEPAGE="https://github.com/returntocorp/semgrep"

#SRC_URI="https://files.pythonhosted.org/packages/3.7/s/semgrep/semgrep-0.28.0-cp36.cp37.cp38.py36.py37.py38-none-any.whl"
#         https://files.pythonhosted.org/packages/3.6/f/frida/frida-12.0.3-py3.6-linux-x86_64.egg

SRC_URI="https://files.pythonhosted.org/packages/fd/34/7910a69abf7ed0638061f402d74ddb71aeeac0b56352814f100f9646632d/semgrep-0.28.0-cp36.cp37.cp38.py36.py37.py38-none-any.whl -> ${P}.zip"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/semgrep-${PV}.data"

src_install(){
	dobin scripts/{semgrep-core,spacegrep}
}
