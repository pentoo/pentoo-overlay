# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/www/viewcvs.gentoo.org/raw_cvs/gentoo-x86/net-misc/rdesktop/Attic/rdesktop-1.5.0-r3.ebuild,v 1.10 2008/05/21 14:13:19 voyageur dead $

inherit eutils

MY_PN=${PN/-brute/}

DESCRIPTION="A Remote Desktop Protocol Client"
HOMEPAGE="http://rdesktop.sourceforge.net/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="ao debug ipv6 oss"

S=${WORKDIR}/${MY_PN}-${PV}

RDEPEND=">=dev-libs/openssl-0.9.6b
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXau
	x11-libs/libXdmcp
	ao? ( >=media-libs/libao-0.8.6 )"
DEPEND="${RDEPEND}
	x11-libs/libXt"

src_unpack() {
	unpack ${A} && cd "${S}"

	epatch "${FILESDIR}/rdesktop-1.5.0-libX11-segfault-fix.patch"
	epatch "${FILESDIR}/rdp-brute-force-r805.diff"
}

src_compile() {
	sed -i -e '/-O2/c\' -e 'cflags="$cflags ${CFLAGS}"' configure
	local strip="$(echo '$(STRIP) $(DESTDIR)$(bindir)/rdesktop')"
	sed -i -e "s:${strip}::" Makefile.in \
		|| die "sed failed in Makefile.in"

	if use oss; then
		extra_conf=`use_with oss sound`
	else
		extra_conf=`use_with ao sound libao`
	fi

	econf \
		--with-openssl=/usr \
		`use_with debug` \
		`use_with ipv6` \
		${extra_conf} \
		|| die

	emake || die
}

src_install() {
	newbin rdesktop rdesktop-brute
}
