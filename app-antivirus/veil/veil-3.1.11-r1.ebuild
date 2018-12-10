# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_5 python3_6 )
inherit eutils python-single-r1

DESCRIPTION="A tool for payloads generation that bypass common anti-virus solutions"
HOMEPAGE="https://github.com/Veil-Framework/Veil"
SRC_URI="https://github.com/Veil-Framework/Veil/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="tools"

DEPEND=""
RDEPEND="dev-python/pycryptodome
	dev-python/pefile
	tools? (
		dev-lang/go
		net-analyzer/metasploit )
	"

#mingw-w64 monodevelop mono-mcs ruby
#   ca-certificates winbind

#	dev-python/symmetricjsonrpc
#	dev-python/capstone-python
#	windows? (
#		dev-python/pyinstaller
#		app-emulation/wine
#	)

S="${WORKDIR}/Veil-${PV}"

src_prepare() {
	epatch "${FILESDIR}"/veil-3-nodeps.patch
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
	dobin "${FILESDIR}"/veil
}

pkg_postinst(){
	einfo "you need to setup wine env for pyinstaller"
	einfo "wine msiexec /i python-2.7.12.msi"
	#https://github.com/Veil-Framework/Veil/issues/259
	einfo "Please also create the follow directories:"
	einfo "mkdir -p ~/.veil/output/{compiled,handlers,source}/"
}
