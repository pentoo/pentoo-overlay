# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1

DESCRIPTION="A tool for payloads generation that bypass common anti-virus solutions"
HOMEPAGE="https://github.com/Veil-Framework/Veil-Evasion"
SRC_URI="https://github.com/Veil-Framework/Veil-Evasion/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="tools"

DEPEND=""
RDEPEND=">=dev-python/pycrypto-2.3
	dev-python/symmetricjsonrpc
	dev-python/pefile
	dev-python/capstone-python
	dev-python/pyinstaller
	tools? (
		dev-lang/go
		app-emulation/wine
		net-analyzer/metasploit )
	"

# FIXME:
#  mingw-w64 monodoc-browser monodevelop mono-mcs unzip ruby wget git \
#  ca-certificates ttf-mscorefonts-installer

S="${WORKDIR}/Veil-Evasion-${PV}"

src_install() {
	rm -r config/
	rm -r setup/

	dodir /usr/$(get_libdir)/${PN}
	cp -R * "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	python_fix_shebang "${ED}"/usr/$(get_libdir)/${PN}/Veil-Evasion.py

	#use our custom settings
	insinto /etc/veil
	newins "${FILESDIR}"/${PN}-2.23-settings.py settings.py

	dosym /usr/$(get_libdir)/veil-evasion/Veil-Evasion.py /usr/bin/veil-evasion
}
