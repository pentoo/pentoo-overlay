# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$ 

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 git-r3

DESCRIPTION="Python Sorted Container Types: SortedList, SortedDict, and SortedSet"
HOMEPAGE="https://github.com/grantjenks/sorted_containers"
SRC_URI=""
EGIT_REPO_URI="https://github.com/grantjenks/sorted_containers.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/sortedcontainers"
S="${WORKDIR}/${PN}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}"
