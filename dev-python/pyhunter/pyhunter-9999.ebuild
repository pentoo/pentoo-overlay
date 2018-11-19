# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_6} )

inherit distutils-r1

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
DESCRIPTION="PyHunter.io wrappper (often for marketing ), Redteam's use as OSINT wrapper verify harvest/emails."
HOMEPAGE="https://github.com/VonStruddle/PyHunter"

if [[ ${PV} == "9999" ]] ; then
#	MY_P=${P}
	EGIT_REPO_URI="https://github.com/VonStruddle/PyHunter.git"
	inherit git-r3
else
#	MY_P=${PN}-${PV/_/-}
	SRC_URI="https://github.com/VonStruddle/PyHunter/archive/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/PyHunter-${PV}"
fi

DEPEND="dev-python/appdirs[${PYTHON_USEDEP}]
		dev-python/autopep8[${PYTHON_USEDEP}]
		dev-python/packaging[${PYTHON_USEDEP}]
		dev-python/pkginfo[${PYTHON_USEDEP}]
		dev-python/pycodestyle[${PYTHON_USEDEP}]
		dev-python/pyparsing[${PYTHON_USEDEP}]
		dev-python/requests-toolbelt[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
		dev-python/tqdm[${PYTHON_USEDEP}]
		dev-python/twine[${PYTHON_USEDEP}]"

RDEPEND="${DEPEND}"
