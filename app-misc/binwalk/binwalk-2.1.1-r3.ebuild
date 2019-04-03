# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python{2_7,3_5,3_6} )

inherit distutils-r1 git-r3

DESCRIPTION="A tool for identifying files embedded inside firmware images"
HOMEPAGE="https://github.com/ReFirmLabs/binwalk"

EGIT_REPO_URI="https://github.com/ReFirmLabs/binwalk.git"
EGIT_DOCS_URI=( "https://github.com/ReFirmLabs/binwalk.wiki.git" )

if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="v${PV}"
	KEYWORDS="~amd64 ~x86"
fi

RESTRICT="mirror"
LICENSE="MIT"
SLOT="0"
IUSE="doc graph squashfs ubifs yaffs"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/backports-lzma[${PYTHON_USEDEP}]' python2_7)
	dev-libs/capstone[python,${PYTHON_USEDEP}]
	graph? ( dev-python/pyqtgraph[opengl,${PYTHON_USEDEP}] )
	sys-apps/file[${PYTHON_USEDEP}]
	squashfs? (
		sys-fs/squashfs-tools:0
		sys-fs/sasquatch
	)
	ubifs? ( sys-fs/ubi_reader )
	yaffs? ( sys-fs/yaffshiv )"

PATCHES=( "${FILESDIR}"/0001-Added-check-for-backports.lzma-when-importing-lzma-m.patch )

src_unpack() {
	git-r3_src_unpack

	if use doc; then
		unset EGIT_COMMIT
		for docs_uri in ${EGIT_DOCS_URI[@]}; do
			git-r3_fetch "${docs_uri}"
			git-r3_checkout "${docs_uri}" "${S}"/docs
		done
	fi
}

python_install_all() {
	distutils-r1_python_install_all
	dodoc \
		$(use doc && echo docs/*) \
		API.md INSTALL.md README.md
}
