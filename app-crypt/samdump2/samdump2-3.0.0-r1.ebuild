# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Windows NT/2k/XP/Vista sam hash dumper"
HOMEPAGE="https://sourceforge.net/projects/ophcrack/files/"
SRC_URI="https://downloads.sourceforge.net/ophcrack/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

DEPEND="dev-libs/openssl:="
RDEPEND="${DEPEND}"

src_prepare() {
	# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=828537
	eapply "${FILESDIR}"/50_fix-openssl-1.1.0-compat.patch

	sed -i \
		-e "s|CFLAGS    =|CFLAGS    +=|" \
		-e 's|= -lssl|= -lssl -lcrypto|g' \
		Makefile || die

	default
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	dobin samdump2
	doman samdump2.1
}
