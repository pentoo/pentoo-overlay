# Copyright 1999-2010 Gentoo Foundation
 # Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu/qemu-0.11.1.ebuild,v 1.2 2010/01/05 23:58:40 flameeyes Exp $

EAPI="2"

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="QEMU arm user-land emulation for CHroot ARM setup on x86*"
HOMEPAGE="http://www.gentoo.org/proj/en/base/embedded/handbook/?part=1&chap=5"
SRC_URI="http://wiki.qemu.org/download/${P/-charm/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"
IUSE="+static +cortex-a8 -cortex-a9"
S=${WORKDIR}/${P/-charm/}
# See the content of the configure script of QEmu
# Those in IUSE_USER_TARGETS are Linux specific

COMMON_TARGETS="arm"
IUSE_SOFTMMU_TARGETS=""
IUSE_USER_TARGETS="${COMMON_TARGETS}"

for target in ${IUSE_SOFTMMU_TARGETS}; do
	IUSE="${IUSE} +qemu_softmmu_targets_${target}"
done

for target in ${IUSE_USER_TARGETS}; do
	IUSE="${IUSE} +qemu_user_targets_${target}"
done

RDEPEND="!app-emulation/qemu-kvm[qemu_user_targets_arm]"
DEPEND="${RDEPEND}
	sys-libs/zlib
	app-text/texi2html"

src_prepare() {
	cp "${FILESDIR}/qemu-wrapper.c" "${S}"
	if use cortex-a8; then
		if use cortex-a9; then
			die "You must chose either cortex-a8 or a9 implementation"
		fi
		sed -e 's/ARMCPU/cortex-a8/' -i "${S}/qemu-wrapper.c"
	elif use cortex-a9; then
		sed -e 's/ARMCPU/cortex-a9/' -i "${S}/qemu-wrapper.c"
	else
		die "You must chose either cortex-a8 or a9 implementation"
	fi

	# avoid fdt till an updated release appears
	sed -i -e 's:fdt="yes":fdt="no":' configure
	# prevent docs to get automatically installed
	sed -i '/$(DESTDIR)$(docdir)/d' Makefile
	# Alter target makefiles to accept CFLAGS set via flag-o
	sed -i 's/^\(C\|OP_C\|HELPER_C\)FLAGS=/\1FLAGS+=/' \
		Makefile Makefile.target tests/Makefile
	[[ -x /sbin/paxctl ]] && \
		sed -i 's/^VL_LDFLAGS=$/VL_LDFLAGS=-Wl,-z,execheap/' \
			Makefile.target
	# Append CFLAGS while linking
	sed -i 's/$(LDFLAGS)/$(QEMU_CFLAGS) $(CFLAGS) $(LDFLAGS)/' rules.mak
}

src_configure() {
	local mycc conf_opts audio_opts softmmu_targets user_targets target_list

	for target in ${IUSE_SOFTMMU_TARGETS} ; do
		use "qemu_softmmu_targets_${target}" && \
			softmmu_targets="${softmmu_targets} ${target}-softmmu"
	done

	for target in ${IUSE_USER_TARGETS} ; do
		use "qemu_user_targets_${target}" && \
			user_targets="${user_targets} ${target}-linux-user"
	done

	conf_opts="--disable-darwin-user --disable-bsd-user --disable-strip"

	if test ! -z "${softmmu_targets}" ; then
		einfo "Building following softmmu targets: ${softmmu_targets}"
		use gnutls || conf_opts="$conf_opts --disable-vnc-tls"
		use ncurses || conf_opts="$conf_opts --disable-curses"
		use sasl || conf_opts="$conf_opts --disable-vnc-sasl"
		use sdl || conf_opts="$conf_opts --disable-sdl"
		use vde || conf_opts="$conf_opts --disable-vde"
		use bluetooth || conf_opts="$conf_opts --disable-bluez"
		use kvm || conf_opts="$conf_opts --disable-kvm"

		audio_opts="oss"
		use alsa && audio_opts="alsa $audio_opts"
		use esd && audio_opts="esd $audio_opts"
		use pulseaudio && audio_opts="pa $audio_opts"
		use sdl && audio_opts="sdl $audio_opts"
	else
		einfo "Disabling softmmu emulation (no softmmu targets specified)"
		conf_opts="$conf_opts --disable-system --disable-vnc-tls \
		--disable-curses --disable-sdl --disable-vde \
		--disable-kvm"
	fi

	if test ! -z "${user_targets}" ; then
		einfo "Building following user targets: ${user_targets}"
		conf_opts="$conf_opts --enable-linux-user"
	else
		einfo "Disabling usermode emulation (no usermode targets specified)"
		conf_opts="$conf_opts --disable-linux-user"
	fi


	conf_opts="$conf_opts --prefix=/usr"

	target_list="${softmmu_targets} ${user_targets}"

	use static && conf_opts="${conf_opts} --static"

	filter-flags -fPIE

	./configure ${conf_opts} \
		--audio-drv-list="$audio_opts" \
		--cc=$(tc-getCC) --host-cc=$(tc-getCC) \
		--target-list="${target_list}" \
		|| die "configure failed"
	gcc -static qemu-wrapper.c -o qemu-wrapper
}

src_install() {
	cd "${S}"
	dobin arm-linux-user/qemu-arm
	insinto /
	insopts -m755
	doins qemu-wrapper
#	dodoc Changelog MAINTAINERS TODO pci-ids.txt || die
}

pkg_postinst() {
	elog "It is strongly encouraged to read"
	elog "http://www.gentoo.org/proj/en/base/embedded/handbook/?part=1&chap=5"
	elog "This package takes care of section 1.1 and 1.4"
	elog ""
	elog "Now you can download an arm stage3 and uncompress it somewhere."
	elog "Build a binpkg from this one: quickpkg ${P}"
	elog "And emerg eit to the unpacked arm stage3:"
	elog "ROOT=path_to_arm_stage3/ emerge -K ${P}"
	elog "There is a chroot script in ${FILESDIR}/charm to help chroot everytime"
	elog "The chroot script takes care of 1.2 and part of 1.3"
	echo
}
