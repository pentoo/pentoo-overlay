# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit versionator eutils

MY_P=${P/_rc/.rc}

DESCRIPTION="A remote security scanner for Linux (openvas-libraries)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/751/${MY_P}.tar.gz"
EAPI="2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=net-libs/gnutls-2.0
        net-libs/libpcap
        >=app-crypt/gpgme-1.1.2
        >=dev-libs/glib-2.12
	!net-analyzer/openvas-libnasl"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_install() {
	einstall || die "failed to install"
	find "${D}" -name '*.la' -delete
	dodoc ChangeLog CHANGES TODO || die
}
