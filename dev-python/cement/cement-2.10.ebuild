# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/datafolklabs/cement.git"
else
	HASH_COMMIT="${PV}"
	SRC_URI="https://github.com/datafolklabs/cement/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Application Framework for Python"
HOMEPAGE="https://github.com/datafolklabs/cement"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_prepare() {
	eapply "${FILESDIR}/${P}-no-examples.patch"
	eapply_user
}
