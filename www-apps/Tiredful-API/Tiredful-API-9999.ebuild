# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )
inherit python-single-r1 git-r3

DESCRIPTION="An intentionally designed broken web application based on REST API"
HOMEPAGE="https://github.com/payatu/Tiredful-API"
EGIT_REPO_URI="https://github.com/payatu/Tiredful-API.git"

LICENSE="GPL-3"
SLOT="0"
#https://github.com/payatu/Tiredful-API/issues/9
#KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-python/django[${PYTHON_SINGLE_USEDEP}]
	dev-python/django-oauth-toolkit[${PYTHON_SINGLE_USEDEP}]
	dev-python/djangorestframework[${PYTHON_SINGLE_USEDEP}]
	dev-python/oauthlib[${PYTHON_SINGLE_USEDEP}]
	dev-python/python-oauth2[${PYTHON_SINGLE_USEDEP}]"
#	dev-python/oauth[${PYTHON_SINGLE_USEDEP}]

src_install() {
	dodir /opt/Tiredful-API
	cp -R "${S}"/Tiredful-API "${D}"/opt/
}
