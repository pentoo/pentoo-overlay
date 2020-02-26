# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A modular framework that takes advantage of poor upgrade implementations by injecting fake updates."
HOMEPAGE="http://www.infobytesec.com/developments.html"
SRC_URI="https://github.com/infobyte/evilgrade/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-perl/Data-Dump
	virtual/perl-Digest-MD5
	virtual/perl-Time-HiRes
	dev-perl/RPC-XML"

src_prepare() {
	#FIXME: these might be required during runtime
	rm -r include/cpan/*.gz
	eapply_user
}

src_install() {
	dodoc docs/*
	rm -r docs

	insinto /usr/share/${PN}
	doins -r *

	dobin "${FILESDIR}"/evilgrade
}
