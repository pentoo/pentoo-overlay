# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
EGIT_REPO_URI="https://github.com/vkcom/youtokentome"
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Unsupervised text tokenizer focused on computational efficiency"
HOMEPAGE="https://github.com/vkcom/youtokentome"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
RESTRICT="test" # error in package

RDEPEND="dev-python/click[${PYTHON_USEDEP}]"
BDEPEND="
	${RDEPEND}
	dev-python/cython[${PYTHON_USEDEP}]
"

src_prepare() {
	sed -i -e 6i"#include <cstdint>" "youtokentome/cpp/utf8.h" || die
	eapply_user
}
