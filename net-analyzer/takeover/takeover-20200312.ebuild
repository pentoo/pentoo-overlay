# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/m4ll0k/takeover.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	HASH_COMMIT="29439690e28423cd8da17c4fda93992d2da670eb"
	SRC_URI="https://github.com/m4ll0k/takeover/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Sub-Domain TakeOver Vulnerability Scanner"
HOMEPAGE="https://github.com/m4ll0k/takeover"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}-${HASH_COMMIT}"
