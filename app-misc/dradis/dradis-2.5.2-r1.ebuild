# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="A framework for effective information sharing"
HOMEPAGE="http://dradisframework.org/"
SRC_URI="mirror://sourceforge/$PN/$PN-v$PV.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="mysql"

DEPEND="dev-ruby/rake
		 dev-ruby/sqlite3
		 dev-ruby/rubygems
		 mysql? ( dev-ruby/mysql-ruby )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-2.5"

src_install() {
	insinto /usr/share/$PN
	doins -r server/* || die "install failed"
	dodoc readme.txt CHANGELOG
	dosbin "${FILESDIR}"/$PN
	newinitd "${FILESDIR}"/${PN}.initd $PN
	newconfd "${FILESDIR}"/${PN}.confd $PN
}

pkg_postinst() {
	einfo "Setting up sqlite database."
	cd /usr/share/$PN/
	rake db:migrate
	rake dradis:reset
	if use mysql; then
		einfo "If you want to use a MySQL database check the dradis\
		documentation: http://dradisframework.org/configure.html\#configure"
	fi
}
