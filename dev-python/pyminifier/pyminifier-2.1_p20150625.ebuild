# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

DESCRIPTION="Pyminifier is a Python code minifier, obfuscator, and compressor."
HOMEPAGE="https://github.com/liftoff/pyminifier"

if [[ ${PV} = *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/liftoff/pyminifier.git"
else
	HASH_COMMIT="087ea7b0c8c964f1f907c3f350f5ce281798db86"
	SRC_URI="https://github.com/liftoff/pyminifier/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

pkg_setup() {
	python_setup
}

python_install() {
	distutils-r1_python_install
	python_optimize "${ED}/usr"
}
