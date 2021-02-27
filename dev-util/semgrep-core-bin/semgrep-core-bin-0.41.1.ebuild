# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Lightweight static analysis for many languages"
HOMEPAGE="https://github.com/returntocorp/semgrep"

#SRC_URI="https://files.pythonhosted.org/packages/3.6/f/frida/frida-12.0.3-py3.6-linux-x86_64.egg"
SRC_URI="https://files.pythonhosted.org/packages/ba/0d/78af41c81bcd81a5ca70a0ae63f797fdb435a2c5660e7e387aa1ca443e13/semgrep-0.41.1-cp36.cp37.cp38.py36.py37.py38-none-any.whl -> ${P}.zip"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/semgrep-${PV}.data"

src_install(){
	dobin purelib/semgrep/bin/{semgrep-core,spacegrep}
}
