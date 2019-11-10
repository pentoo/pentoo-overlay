# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic

DESCRIPTION="A distributed password cracker"
HOMEPAGE="https://download.openwall.net/pub/projects/john/contrib/parallel/btb/"
SRC_URI="https://download.openwall.net/pub/projects/john/contrib/parallel/btb/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="cpu_flags_x86_sse2"
SLOT="0"

RDEPEND="dev-libs/libevent"
DEPEND="${RDEPEND}"

src_prepare() {
	eapply "${FILESDIR}/minor-changes.patch"

	sed -i \
		-e "s/^CFLAGS=/CFLAGS?=/" \
		configure.ac || die

	sed -i \
		-e "s/top_srcdir = @top_srcdir@/top_srcdir = @srcdir@/" \
		Makefile.in || die

	eautoreconf
	default
}

src_configure() {
	local myconf

	if use cpu_flags_x86_sse2; then
		myconf="--enable-sse2"
	else
		myconf="--disable-sse2"
	fi

	append-flags -std=gnu99
	econf ${myconf}
}

src_install() {
	DESTDIR="${D}" emake install
	dodoc README NEWS TODO
}
