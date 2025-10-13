# Copyright 2019-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1

DESCRIPTION="Kismetdb database log helper library"
HOMEPAGE="https://kismetwireless.net/"
if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kismetwireless/python-kismet-db.git"
else
	SRC_URI="https://github.com/kismetwireless/python-kismet-db/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/python-kismet-db-${PV}"
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND="dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/simplekml[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
