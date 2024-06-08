# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 pypi fcaps

DESCRIPTION="Python interface to Bluetooth LE on Linux"
HOMEPAGE="https://github.com/IanHarvey/bluepy"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

RDEPEND="${PYTHON_DEPS}
	dev-libs/glib:2"
DEPEND="${RDEPEND}"

src_configure() {
	#set EPYTHON variable for python_get_sitedir
	python_setup
}

#FIXME:
#.[31;01mQA Notice: Files built without respecting LDFLAGS have been detected.[0m
# Please include the following list of files in your report:
#/usr/lib/python3.12/site-packages/bluepy/bluepy-helper


#FILECAPS=( cap_net_raw ${python_get_sitedir}/${PN}/bluepy-helper --
#cap_net_admin ${python_get_sitedir}/${PN}/bluepy-helper )
# or
pkg_postinst() {
	#fcaps 'cap_net_raw,cap_net_admin+eip' ${python_get_sitedir}/${PN}/bluepy-helper
	einfo "=========", ${python_get_sitedir}/${PN}/bluepy-helper
	elog "test ===="
	fcaps cap_net_raw ${python_get_sitedir}/${PN}/bluepy-helper
	fcaps cap_net_admin+eip ${python_get_sitedir}/${PN}/bluepy-helper
#	rm ${python_get_sitedir}/${PN}/{bluez-src.tgz,bluepy-helper.c,Makefile,version.h}
}
