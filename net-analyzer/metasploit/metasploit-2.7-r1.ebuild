# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/metasploit/metasploit-2.7.ebuild,v 1.8 2008/03/23 16:02:01 pva Exp $

EAPI=3

inherit eutils

MY_P="${P/metasploit/framework}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Advanced open-source framework for developing, testing, and using vulnerability exploit code"
HOMEPAGE="http://www.metasploit.org/"
SRC_URI="http://metasploit.com/tools/${MY_P}.tar.gz"

LICENSE="GPL-2 Artistic"
SLOT="2.7"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

RDEPEND="dev-lang/perl
	 dev-perl/Net-SSLeay
	 dev-perl/Term-ReadLine-Perl
	 dev-perl/TermReadKey"

QA_PREBUILD="
	usr/$(get_libdir)/${PN}${SLOT}/data/.svn/text-base/shelldemo.svn-base
	usr/$(get_libdir)/${PN}${SLOT}/data/shelldemo"

src_install() {
	# should be as simple as copying everything into the target...
	dodir /usr/$(get_libdir)/${PN}${SLOT}
	cp -pPR "${S}" "${ED}"/usr/$(get_libdir)/${PN}${SLOT} || die

	# and creating symlinks in the /usr/bin dir
	dodir /usr/bin/
	cd "${ED}"/usr/bin
	ln -s ../$(get_libdir)/${PN}${SLOT}/msf* ./ || die
	chown -R root:0 "${D}"

	newinitd "${FILESDIR}"/msfweb.initd msfweb || die "newinitd failed"
	newconfd "${FILESDIR}"/msfweb.confd msfweb || die "newconfd failed"
}

pkg_postinst() {
	elog "To update metasploit modules run:"
	elog " # cd /usr/$(get_libdir)/metasploit${SLOT} && svn update"
}

pkg_postrm() {
	if [[ -d /usr/lib/metasploit ]] ; then
		ewarn "If you ever updated modules emerge will keep /var/lib/metasploit${SLOT}"
		ewarn "directory. Thus to remove metasploit completely do not forgive to:"
		ewarn " # rm -r /usr/lib/metasploit{SLOT}"
	fi
}
