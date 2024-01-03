# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10..12} )
inherit python-single-r1

MY_P="seafile-pro-server_${PV}_x86-64_CentOS.tar.gz"

DESCRIPTION="Meta package for Seafile Pro Edition, file sync share solution"
HOMEPAGE="https://www.seafile.com/en/product/private_server/"
SRC_URI="https://download.seafile.com/d/6e5297246c/files/?p=%2Fpro%2F${MY_P}&dl=1 -> ${MY_P}"

LICENSE="seafile"
SLOT="0"
KEYWORDS="amd64"
IUSE="fuse mysql psd saml sqlite"

# https://manual.seafile.com/upgrade/upgrade_notes_for_10.0.x/
# https://manual.seafile.com/changelog/changelog-for-seafile-professional-server/

RDEPEND="${PYTHON_DEPS}
	=app-misc/elasticsearch-8*
	$(python_gen_cond_dep '
	dev-python/future[${PYTHON_USEDEP}]
	>=dev-python/pillow-10.0.0[${PYTHON_USEDEP}]
	dev-python/pylibmc[${PYTHON_USEDEP}]
	dev-python/django-simple-captcha[${PYTHON_USEDEP}]

	dev-python/jinja[${PYTHON_USEDEP}]
	<dev-python/sqlalchemy-2.0.3[sqlite?,${PYTHON_USEDEP}]
	psd? ( dev-python/psd-tools )
	dev-python/django-pylibmc[${PYTHON_USEDEP}]
	dev-python/ldap3[${PYTHON_USEDEP}]

	dev-python/lxml[${PYTHON_USEDEP}]

	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/cffi
	dev-python/requests

	')
	fuse? ( sys-fs/fuse:0 )
	mysql? ( $(python_gen_cond_dep ' dev-python/mysqlclient[${PYTHON_USEDEP}]') )
	saml?  ( $(python_gen_cond_dep ' dev-python/djangosaml2[${PYTHON_USEDEP}]') )
	sys-libs/libselinux
	dev-libs/nss
	virtual/jre:*"
DEPEND="${RDEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare() {
	eapply "${FILESDIR}"/pillow-10.patch
	#match with cffi in RDEPEND section
#	sed -e "s|1.14.0|${CFFI_PV}|" -i seahub/thirdpart/cffi/__init__.py || die "sed failed"
	rm -r seahub/thirdpart/{cffi*,requests*}
	eapply_user
}

pkg_postinst() {
	einfo "follow the official documentation:"
	einfo "https://manual.seafile.com/deploy_pro/download_and_setup_seafile_professional_server/"
}
