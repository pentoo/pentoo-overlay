# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Windows NT/2k/XP/Vista sam hash dumper"
HOMEPAGE="http://sourceforge.net/projects/ophcrack/files/"
SRC_URI="mirror://sourceforge/ophcrack/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin samdump2 || die "install failed"
	doman samdump2.1 || die "install failed"
}
