# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A cheap USB proxy for input devices"
HOMEPAGE="https://github.com/matlo/serialusb"
SRC_URI="https://github.com/matlo/serialusb/archive/v0.7.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
#dev-libs/libdnet
#		net-libs/libpcap
#		dev-libs/libnl"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}/sw

#src_prepare() {
#	sed -e 's|$(DESTDIR)$(bindir)|$(DESTDIR)$(sbindir)|' -i src/Makefile.in || die "sed Makefile failed"
#}

#src_install() {
#	DESTDIR="${D}" emake install || die
#}
