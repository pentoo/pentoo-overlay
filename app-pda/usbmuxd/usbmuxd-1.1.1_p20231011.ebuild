# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd udev autotools

HASH_COMMIT="360619c5f721f93f0b9d8af1a2df0b926fbcf281"

DESCRIPTION="USB multiplex daemon for use with Apple iPhone/iPod Touch devices"
HOMEPAGE="https://libimobiledevice.org/"
SRC_URI="https://github.com/libimobiledevice/usbmuxd/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

# src/utils.h is LGPL-2.1+, rest is found in COPYING*
LICENSE="|| ( GPL-2 GPL-3 ) LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
IUSE="selinux systemd"

#REQUIRED_USE="!systemd ( openrc )"

DEPEND="
	acct-user/usbmux
	>=app-pda/libimobiledevice-1.3.0:=
	>=app-pda/libplist-2.3:=
	virtual/libusb:1=
"

RDEPEND="
	${DEPEND}
	virtual/udev
	selinux? ( sec-policy/selinux-usbmuxd )
	systemd? ( sys-apps/systemd )
"

BDEPEND="
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}/227_openrc.patch"
)

S=${WORKDIR}/${PN}-${HASH_COMMIT}

src_prepare() {
	default
	#define git-version-gen $RELEASE_VERSION
	echo ${PV} > .tarball-version
	eautoreconf
}

src_configure() {
	initsystem="--with-openrc --without-systemd"
	use systemd && initsystem="--with-systemd --without-openrc"
	echo "init: " + $initsystem

	econf \
		$initsystem \
		--with-udevrulesdir="$(get_udevdir)"/rules.d \
		$(use_with systemd systemdsystemunitdir $(systemd_get_systemunitdir))
#		--with-systemdsystemunitdir="$(systemd_get_systemunitdir)"
}

pkg_postrm() {
	udev_reload
}

pkg_postinst() {
	udev_reload
}
