# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6} )

inherit distutils-r1

DESCRIPTION="A tool for identifying files embedded inside firmware images"
HOMEPAGE="https://github.com/ReFirmLabs/binwalk"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/ReFirmLabs/binwalk"
	inherit git-r3
else
	SRC_URI="https://github.com/ReFirmLabs/binwalk/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="graph squashfs test ubifs yaffs"

DOCS=( API.md INSTALL.md README.md )

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/backports-lzma[${PYTHON_USEDEP}]' python2_7)
	dev-libs/capstone[python,${PYTHON_USEDEP}]
	!!dev-libs/capstone-bindings
	graph? ( dev-python/pyqtgraph[opengl,${PYTHON_USEDEP}] )
	sys-apps/file[${PYTHON_USEDEP}]
	squashfs? (
		sys-fs/squashfs-tools:0
		sys-fs/sasquatch
	)
	ubifs? ( sys-fs/ubi_reader )
	yaffs? ( sys-fs/yaffshiv )"

DEPEND="test? ( dev-python/nose[coverage,${PYTHON_USEDEP}] )"

pkg_setup() {
	python_setup
}

python_install_all() {
	distutils-r1_python_install_all
}

pkg_postinst() {
	einfo "\nbinwalk has many optional dependencies to automatically"
	einfo "extract/decompress data, see INSTALL.md for more details.\n"
}

src_test() {
	find testing/tests/input-vectors -type f | while read x; do
		${PYTHON} testing/test_generator.py $x || die
	done
}
