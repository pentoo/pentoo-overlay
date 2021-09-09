# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

DESCRIPTION="OWASP Maryam is a modular open source OSINT and data gathering framework"
HOMEPAGE="https://owasp.org/www-project-maryam/"
SRC_URI="https://github.com/saeeddhqan/Maryam/archive/refs/tags/v.${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

S="${WORKDIR}/Maryam-v.${PV}"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
	dev-python/cloudscraper[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
"
