# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu-softmmu/qemu-softmmu-0.9.1-r3.ebuild,v 1.4 2008/05/14 20:25:37 maekke Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Multi-platform & multi-targets cpu emulator and dynamic translator"
HOMEPAGE="http://fabrice.bellard.free.fr/qemu/"
SRC_URI="http://dev.pentoo.ch/~grimmlin/qemu/qemu-20080205.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="-alpha amd64 ppc -sparc x86"
IUSE="sdl kqemu gnutls alsa"
RESTRICT="binchecks test"

DEPEND="virtual/libc
	sys-libs/zlib
	sdl? ( media-libs/libsdl )
	!<=app-emulation/qemu-0.7.0
	kqemu? ( >=app-emulation/kqemu-1.3.0_pre10 )
	gnutls? (
		dev-util/pkgconfig
		net-libs/gnutls
	)
	app-text/texi2html"
RDEPEND="sys-libs/zlib
	sdl? ( media-libs/libsdl )
	gnutls? ( net-libs/gnutls )
	alsa? ( media-libs/alsa-lib )"

S=${WORKDIR}/qemu-20080205

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/qemu-cvs20080205-brb_02-olive.patch
	epatch "${FILESDIR}"/qemu-e1000.patch
	cd "${S}"
	# Alter target makefiles to accept CFLAGS set via flag-o.
	sed -i 's/^\(C\|OP_C\|HELPER_C\)FLAGS=/\1FLAGS+=/' \
		Makefile Makefile.target tests/Makefile
	# Ensure mprotect restrictions are relaxed for emulator binaries
	[[ -x /sbin/paxctl ]] && \
		sed -i 's/^VL_LDFLAGS=$/VL_LDFLAGS=-Wl,-z,execheap/' \
			Makefile.target
	# Prevent install of kernel module by qemu's makefile
	sed -i 's/\(.\/install.sh\)/#\1/' Makefile
	# avoid strip
	sed -i 's:$(INSTALL) -m 755 -s:$(INSTALL) -m 755:' Makefile Makefile.target
}

src_compile() {
	if use x86 ; then
		# Force -march=pentium-mmx or lower. Fixes bug #212351.
		local march
		march=$(echo "${CFLAGS}" | sed 's:^.*-march=\([[:alnum:]-]\+\)\([[:blank:]].*\)\?$:\1:p;d')
		case ${march} in
			i386|i486|i586|pentium) ;;
			*) # Either march is not enough low or not exists at all
			case ${CHOST} in
				i486-*-*)	march=i486 ;;
				i586-*-*)	march=i586 ;;
				*)			march=pentium-mmx ;;
			esac ;;
		esac
		#Let the application set its cflags
		unset CFLAGS
		append-flags -march=${march}
	else
		#Let the application set its cflags
		unset CFLAGS
	fi

	# Switch off hardened tech
	filter-flags -fpie -fstack-protector

	myconf="--enable-net-pcap --enable-net-lcap --enable-net-udp --enable-pemu-i82559"
	if use alsa; then
		myconf="$myconf --enable-alsa"
	fi
	if ! use gnutls; then
		myconf="$myconf --disable-vnc-tls"
	fi
	if ! use kqemu; then
		myconf="$myconf --disable-kqemu"
	fi
	if ! use sdl ; then
		myconf="$myconf --disable-sdl --disable-gfx-check"
	fi
	# econf does not work
	./configure \
		--prefix=/usr \
		--enable-adlib \
		--cc=$(tc-getCC) \
		--host-cc=$(tc-getCC) \
		--disable-linux-user \
		--enable-system \
		${myconf} \
		|| die "could not configure"

	emake OS_CFLAGS="${CFLAGS}" || die "make failed"
}

src_install() {
	emake install \
		prefix="${D}/usr" \
		bindir="${D}/usr/bin" \
		datadir="${D}/usr/share/qemu" \
		docdir="${D}/usr/share/doc/${P}" \
		mandir="${D}/usr/share/man" || die

	chmod -x "${D}/usr/share/man/*/*"
}

pkg_postinst() {
	einfo "You will need the Universal TUN/TAP driver compiled into"
	einfo "kernel or as a module to use the virtual network device."
}
