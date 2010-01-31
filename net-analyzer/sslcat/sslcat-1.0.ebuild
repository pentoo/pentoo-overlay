# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="netcat like application with ssl support"
HOMEPAGE="http://www.bindshell.net/tools/sslcat"
SRC_URI="http://www.bindshell.net/tools/sslcat/sslcat.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-libs/openssl"

S="${WORKDIR}"/$PN

src_install() {
	dobin sslcat || die "failed to install sslcat"
	doman sslcat.1 || die "failed to install manpage"
}
