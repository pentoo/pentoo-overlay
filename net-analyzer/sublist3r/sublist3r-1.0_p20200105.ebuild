# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
inherit python-r1

HASH_COMMIT="3f5fc6da0142540c56e97c98f9925bb7d0855fb5"

DESCRIPTION="Enumerate subdomains of websites using OSINT"
HOMEPAGE="https://github.com/aboul3la/Sublist3r"
SRC_URI="https://github.com/aboul3la/Sublist3r/archive/${HASH_COMMIT}.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/Sublist3r-${HASH_COMMIT}"

src_prepare() {
	#make it a module
	sed -e 's|from subbrute|from sublist3r.subbrute|' -i sublist3r.py || die "sed failed"
	touch __init__.py
	#https://github.com/aboul3la/Sublist3r/issues/215
	sed -e '/argparse/d' -i requirements.txt || die "sed failed"
	default
}

src_install() {
	python_moduleinto ${PN}
	python_foreach_impl python_domodule subbrute __init__.py
	newbin sublist3r.py sublist3r
	dodoc README.md
}
