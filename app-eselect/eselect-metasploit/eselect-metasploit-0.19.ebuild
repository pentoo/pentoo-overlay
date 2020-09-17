# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="eselect module for metasploit"
HOMEPAGE="http://www.pentoo.ch/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE=""

DEPEND="!<net-analyzer/metasploit-4.6"
		#dev-ruby/bundler-audit needed if we uncomment the code in msfloader which uses it
RDEPEND="${DEPEND}
		app-admin/eselect"

S=${WORKDIR}

src_install() {
	#force to use the outdated bundled version of metasm
	doenvd "${FILESDIR}"/91metasploit

	newinitd "${FILESDIR}"/msfrpcd.initd msfrpcd
	newconfd "${FILESDIR}"/msfrpcd.confd msfrpcd

	insinto /usr/share/eselect/modules
	newins "${FILESDIR}/metasploit.eselect-0.14" metasploit.eselect

	newbin "${FILESDIR}"/msfloader-${PV} msfloader
}

pkg_postinst() {
	"${EROOT}"/usr/bin/eselect metasploit set --use-old 1
	elog "To switch between installed slots, execute as root:"
	elog " # eselect metasploit set [slot number]"
}
