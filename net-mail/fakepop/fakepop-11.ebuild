# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="fake pop3 server which returns the same messages to all users"
HOMEPAGE="https://packages.debian.org/jessie/fakepop"
#SRC_URI="http://deb.debian.org/debian/pool/main/f/fakepop/fakepop_${PV}.tar.gz"
SRC_URI="http://archive.ubuntu.com/ubuntu/pool/universe/f/fakepop/fakepop_${PV}.tar.gz"

S="${WORKDIR}/${PN}-10"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/glib:="
RDEPEND="${DEPEND}"
PDEPEND="sys-apps/xinetd"

src_prepare() {
	default
	sed -i -e "s#doc/${PN}#${P}#" \
		-e "s#-Wall -O2#${CFLAGS}#" \
		-e "s#glib-2.0)#glib-2.0) ${LDFLAGS}#" \
		-e '/zip/d' \
		-e 's#gz#xz#' Makefile || die
}

src_compile() {
	emake clean
	default
}

src_install() {
	emake DESTDIR="${D}" install

	insinto /etc/xinet.d
	doins "${FILESDIR}/fakepop"

	dodir /etc/fakepop
	mv "${ED}"/usr/share/fakepop-11/examples/README.* "${ED}"/etc/fakepop
	rm "${ED}"/etc/fakepop/README
	fowners -R nobody:nobody /etc/fakepop
}
