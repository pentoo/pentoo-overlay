# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )
DISTUTILS_USE_SETUPTOOLS=rdepend
inherit eutils distutils-r1

DESCRIPTION="A voip pentest tools suite"
HOMEPAGE="https://github.com/EnableSecurity/sipvicious"
SRC_URI="https://github.com/EnableSecurity/sipvicious/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pdf"

RDEPEND="pdf? ( dev-python/reportlab )"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
