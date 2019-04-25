# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="fake pop3 server which returns the same messages to all users"
HOMEPAGE="https://packages.debian.org/jessie/fakepop"
SRC_URI="http://deb.debian.org/debian/pool/main/f/fakepop/fakepop_11.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/glib:="
RDEPEND="${DEPEND}"
BDEPEND=""
PDEPEND="sys-apps/xinetd"

S="${WORKDIR}/${PN}-10"

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
