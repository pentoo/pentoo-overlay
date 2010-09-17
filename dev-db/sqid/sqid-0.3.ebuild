# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/sqlinject/sqlinject-1.1.ebuild,v 1.1.1.1 2006/03/21 14:30:26 grimmlin Exp $

EAPI=2

DESCRIPTION="A SQL injection digger"
HOMEPAGE="http://sqid.rubyforge.org/"
SRC_URI="http://rubyforge.org/frs/download.php/30716/sqid-0.3.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-lang/ruby"

src_compile () {
	einfo "Nothing to compile"
	sed -i -e 's:sqid.db:/usr/lib/sqid/sqid.db:g' sqid.rb || die
}

src_install () {
	dodoc readme || die
	insinto /usr/lib/"${PN}"/
	doins sqid.db || die
	dobin sqid.rb || die
}
