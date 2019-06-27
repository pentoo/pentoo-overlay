# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/joswr1ght/killerzee.git"
else
	# snapshot: 20190218
	#COMMIT_HASH="cdee75784e0d44f225c6d1bc07fdae6044e73bb7"

	#SRC_URI="https://github.com/riverloopsec/killerbee/archive/${COMMIT_HASH}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	#S="${WORKDIR}/${PN}-${COMMIT_HASH}"
fi

DESCRIPTION="Tools for Attacking and Evaluating Z-Wave Networks"
HOMEPAGE="https://github.com/joswr1ght/killerzee"

LICENSE="BSD"
SLOT="0"
IUSE=""

#FIXME: https://bitbucket.org/secdev/scapy-com
DEPEND="net-wireless/rfcat[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
