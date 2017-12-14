# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 git-r3

DESCRIPTION="An intentionally designed broken web application based on REST API"
HOMEPAGE="https://github.com/payatu/Tiredful-API"
EGIT_REPO_URI="https://github.com/payatu/Tiredful-API.git"

LICENSE="none"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/django-oauth-toolkit[${PYTHON_USEDEP}]
	dev-python/django-rest-framework[${PYTHON_USEDEP}]
	dev-python/oauth[${PYTHON_USEDEP}]
	dev-python/oauthlib[${PYTHON_USEDEP}]
	dev-python/python-oauth2[${PYTHON_USEDEP}]"

src_install() {
	dodir "${D}"/opt/Tiredful-API
#	cp -R "${S}"/Tiredful-API "${D}"/opt/
}
