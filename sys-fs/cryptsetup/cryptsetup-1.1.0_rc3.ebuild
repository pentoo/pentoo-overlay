# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/cryptsetup/cryptsetup-1.0.6-r2.ebuild,v 1.14 2009/08/31 15:05:29 armin76 Exp $

inherit linux-info eutils flag-o-matic multilib autotools
EAPI=2

MY_P=${P/_rc/-rc}
DESCRIPTION="Tool to setup encrypted devices with dm-crypt"
HOMEPAGE="http://code.google.com/p/cryptsetup/"
SRC_URI="http://cryptsetup.googlecode.com/files/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="dynamic nls selinux"

S=${WORKDIR}/${MY_P}

DEPEND="|| (
		>=sys-fs/lvm2-2.02.45
		>=sys-fs/device-mapper-1.00.07-r1
	)
	>=dev-libs/libgcrypt-1.1.42
	>=dev-libs/libgpg-error-1.0-r1
	>=dev-libs/popt-1.7
	>=sys-fs/udev-124
	|| ( >=sys-libs/e2fsprogs-libs-1.41 <sys-fs/e2fsprogs-1.41 )
	selinux? ( sys-libs/libselinux )
	!sys-fs/cryptsetup-luks"

dm-crypt_check() {
	local CONFIG_CHECK="~DM_CRYPT"
	local WARNING_DM_CRYPT="CONFIG_DM_CRYPT:\tis not set (required for cryptsetup)\n"
	check_extra_config
}

crypto_check() {
	local CONFIG_CHECK="~CRYPTO"
	local WARNING_CRYPTO="CONFIG_CRYPTO:\tis not set (required for cryptsetup)\n"
	check_extra_config
}

cbc_check() {
	local CONFIG_CHECK="~CRYPTO_CBC"
	local WARNING_CRYPTO_CBC="CONFIG_CRYPTO_CBC:\tis not set (required for kernel 2.6.19)\n"
	check_extra_config
}

pkg_setup() {
	dm-crypt_check
	crypto_check
	cbc_check

	if use dynamic ; then
		ewarn "If you need cryptsetup for an initrd or initramfs then you"
		ewarn "should NOT use the dynamic USE flag"
		epause 5
	fi
}

src_prepare() {
	epatch ${FILESDIR}/1.1.0_rc3-static-no-selinux.patch
	eautoreconf
}

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	econf \
		--sbindir=/sbin \
		$(use_enable !dynamic static) \
		--libdir=/usr/$(get_libdir) \
		$(use_enable nls) \
		$(use_enable selinux) \
		|| die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	rmdir "${D}"/usr/$(get_libdir)/cryptsetup
	insinto /$(get_libdir)/rcscripts/addons
	newins "${FILESDIR}"/1.0.6-r2-dm-crypt-start.sh dm-crypt-start.sh || die
	newins "${FILESDIR}"/1.0.5-dm-crypt-stop.sh dm-crypt-stop.sh || die
	newconfd "${FILESDIR}"/1.0.6-dmcrypt.confd dmcrypt || die
	newinitd "${FILESDIR}"/1.0.5-dmcrypt.rc dmcrypt || die
}

pkg_postinst() {
	ewarn "This ebuild introduces a new set of scripts and configuration"
	ewarn "than the last version. If you are currently using /etc/conf.d/cryptfs"
	ewarn "then you *MUST* copy your old file to:"
	ewarn "/etc/conf.d/dmcrypt"
	ewarn "Or your encrypted partitions will *NOT* work."
	elog "Please see the example for configuring a LUKS mountpoint"
	elog "in /etc/conf.d/dmcrypt"
	elog
	elog "If you are using baselayout-2 then please do:"
	elog "rc-update add dmcrypt boot"
	elog "This version introduces a command line arguement 'key_timeout'."
	elog "If you want the search for the removable key device to timeout"
	elog "after 10 seconds add the following to your bootloader config:"
	elog "key_timeout=10"
	elog "A timeout of 0 will mean it will wait indefinitely."
}
