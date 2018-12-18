# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Six Degrees of Domain Admin"
HOMEPAGE="https://github.com/BloodHoundAD/BloodHound"
SRC_URI="https://github.com/BloodHoundAD/BloodHound/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://dev.pentoo.ch/~blshkv/distfiles/BloodHound-2.0.4-node_modules.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ia32"
IUSE=""

DEPEND="net-libs/nodejs[npm]
	dev-util/electron-packager"
RDEPEND="${DEPEND}
	gnome-base/gconf"

BLOODHOUND_BINDIR="FAIL_TO_DETECT_ARCH"
QA_FLAGS_IGNORED="usr/lib.*/BloodHound/.*\.so"

src_prepare(){
	epatch "${FILESDIR}/singlearch.patch"
	eapply_user
}

src_compile(){
	#npm shrinkwrap
	#we  provide node_modules, there is no need to install
	#npm install \

	if use amd64; then
		npm run linuxbuild_64
		BLOODHOUND_BINDIR="BloodHound-linux-x64"
	elif use ia32; then
		npm run linuxbuild_32
		BLOODHOUND_BINDIR="BloodHound-linux-ia32"
	elif use arm; then
		npm run linuxbuild_arm
		BLOODHOUND_BINDIR="BloodHound-linux-armv7l"
	fi
}

src_install() {
	dodir /usr/$(get_libdir)/${PN}
	cp -R ${BLOODHOUND_BINDIR}/* "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"

	newbin - ${PN} <<-EOF
	#!/bin/sh
	cd /usr/lib/${PN}
	LD_LIBRARY_PATH=. exec ./${PN} "\${@}"
	EOF
}
