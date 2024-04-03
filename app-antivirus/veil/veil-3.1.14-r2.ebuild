# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
inherit python-single-r1

DESCRIPTION="A tool for payloads generation that bypass common anti-virus solutions"
HOMEPAGE="https://github.com/Veil-Framework/Veil"
SRC_URI="https://github.com/Veil-Framework/Veil/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/Veil-${PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="tools"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="dev-python/pycryptodome
	dev-python/pefile
	${PYTHON_DEPS}
	tools? ( dev-lang/go )
	"

#mingw-w64 monodevelop mono-mcs ruby
#   ca-certificates winbind

#	dev-python/symmetricjsonrpc
#	dev-python/capstone-python
#	windows? (
#		dev-python/pyinstaller
#		app-emulation/wine
#	)

src_prepare() {
	eapply "${FILESDIR}"/veil-3-nodeps.patch
	eapply_user
}

src_install() {
	rm -r config/
#	rm -r setup/

	dodir /usr/$(get_libdir)/${PN}
	cp -R * "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"

	#use our custom settings
	insinto /etc/veil
	newins "${FILESDIR}"/${PN}-3_settings.py settings.py

#	dosym "${EPREFIX}"/usr/$(get_libdir)/veil/Veil.py /usr/bin/veil
	newbin - veil <<-EOF
	#!/bin/sh
	cd /usr/lib/veil
	python ./Veil.py \${@}
	EOF
}

pkg_postinst(){
	einfo "you need to setup wine env for pyinstaller"
	einfo "wine msiexec /i python-2.7.12.msi"
	#https://github.com/Veil-Framework/Veil/issues/259
	einfo "Please also create the follow directories:"
	einfo "mkdir -p ~/.veil/output/{compiled,handlers,source}/"
}
