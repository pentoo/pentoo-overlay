# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion eutils

DESCRIPTION="A remote security scanner for Linux (openvas-libraries)"
HOMEPAGE="http://www.openvas.org/"
EAPI="2"
#SRC_URI="http://wald.intevation.org/frs/download.php/737/${MY_P}.tar.gz"
ESVN_REPO_URI="https://svn.wald.intevation.org/svn/openvas/trunk/openvas-libraries/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-*"
IUSE=""

DEPEND=">=net-libs/gnutls-2.0
	net-libs/libpcap
	>=app-crypt/gpgme-1.1.2
	>=dev-libs/glib-2.12
	!net-analyzer/openvas-libnasl"
RDEPEND="${DEPEND}"

#src_prepare() {
#	#remove this patch after they learn how to include things properly
#        epatch "${FILESDIR}"/gpgme-include.patch
#}

src_install() {
	einstall || die "failed to install"
	find "${D}" -name '*.la' -delete
	dodoc ChangeLog CHANGES TODO || die
}
