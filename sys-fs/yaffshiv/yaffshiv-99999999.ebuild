# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit git-r3 distutils-r1

DESCRIPTION="YAFFS filesystem extraction tool"
HOMEPAGE="https://github.com/devttys0/yaffshiv"

EGIT_REPO_URI="https://github.com/devttys0/yaffshiv"
if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="8a7c99e2ea4cb968f2cede1b9782160c0fe6cb87"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}"
