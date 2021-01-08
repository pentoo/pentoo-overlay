# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Lightweight static analysis for many languages"
HOMEPAGE="https://github.com/returntocorp/semgrep"

#SRC_URI="https://files.pythonhosted.org/packages/3.6/f/frida/frida-12.0.3-py3.6-linux-x86_64.egg"

SRC_URI="https://files.pythonhosted.org/packages/51/94/d6ce8e42588aeb3f4cde5e477a5254fa2a9127f2d67652ce2bf45328c1a1/semgrep-0.36.0-cp36.cp37.cp38.py36.py37.py38-none-any.whl -> ${P}.zip"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/semgrep-${PV}.data"

src_install(){
	dobin purelib/semgrep/bin/{semgrep-core,spacegrep}
}
