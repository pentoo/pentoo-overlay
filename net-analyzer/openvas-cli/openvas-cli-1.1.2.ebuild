# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit cmake-utils

DESCRIPTION="A remote security scanner for Linux"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/851/${P}.tar.gz"

SLOT="4"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.0
	>=app-crypt/gpgme-1.1.2
	net-libs/gnutls
	net-analyzer/openvas-libraries:4"
DEPEND="${RDEPEND}
	dev-util/cmake"
