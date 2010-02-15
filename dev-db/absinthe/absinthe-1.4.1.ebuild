# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/net-analyzer/absinthe/absinthe-1.4.1.ebuild,v 1.1.1.1 2006/03/02 00:53:51 grimmlin Exp $

inherit mono

MY_P=Absinthe-${PV}-Linux
DESCRIPTION="a gui-based tool for aiding in Blind SQL Injection"
HOMEPAGE="http://www.0x90.org/releases/absinthe/"
SRC_URI="http://www.0x90.org/releases/absinthe/${MY_P}.tar.gz"

LICENSE="|| ( GPL-2 BSD )"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-lang/mono-1
	=dev-dotnet/wxnet-0.7.2"

S=${WORKDIR}/${MY_P}

src_compile() {
	einfo "Nothing to compile"
	ewarn "We are using the binary dist of absinthe,"
	ewarn "You can expect breakage..."
}

src_install() {
	dodir /usr/lib/"${PN}"
	rm "${S}"/bin/Absinthe.ico "${S}"/bin/wxNET.tar "${S}"/bin/runabsinthe.sh
	cp -R "${S}"/bin/* "${D}"/usr/lib/"${PN}"
	dobin "${FILESDIR}"/absinthe
	dodoc README
}
