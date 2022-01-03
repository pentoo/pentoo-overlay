# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/andreif/codegen.git"
else
	HASH_COMMIT="${PV}"
	SRC_URI="https://github.com/andreif/codegen/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Extension to ast that allow ast -> python code generation"
HOMEPAGE="https://github.com/andreif/codegen"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
