# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit versionator eutils

MY_P=${P/_rc/.rc}

DESCRIPTION="A remote security scanner for Linux (openvas-libraries)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/758/${MY_P}.tar.gz"
SLOT="3"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="net-libs/gnutls
	>=dev-libs/glib-2.0
	net-libs/gnutls
	net-libs/libpcap
	>=app-crypt/gpgme-1.1.2
	net-analyzer/openvas-libraries:3"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	cmake .
}

src_install() {
	DESTDIR="${D}" emake install || die "failed to install"
	dodoc ChangeLog CHANGES || die
}
