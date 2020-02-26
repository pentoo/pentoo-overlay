# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Six Degrees of Domain Admin"
HOMEPAGE="https://github.com/BloodHoundAD/BloodHound"
SRC_URI="https://github.com/BloodHoundAD/BloodHound/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://dev.pentoo.ch/~blshkv/distfiles/${P}-node_modules.tar.gz"
#create modules using "npm install"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

DEPEND=">=net-libs/nodejs-12.10.0[npm]
	dev-util/electron-packager"
RDEPEND="${DEPEND}
	gnome-base/gconf"

BLOODHOUND_BINDIR="FAIL_TO_DETECT_ARCH"
QA_FLAGS_IGNORED="usr/lib.*/BloodHound/.*\.so"

src_prepare() {
	epatch "${FILESDIR}/${PV}-singlearch.patch"
	mv ${WORKDIR}/node_modules ${S}
	eapply_user
}

src_compile() {
	#npm shrinkwrap
	#we  provide node_modules, there is no need to install
	#npm install \
	if use amd64; then
		npm run linuxbuild_64 || die "Failed to compile"
		BLOODHOUND_BINDIR="BloodHound-linux-x64"
	elif use x86; then
		npm run linuxbuild_32 || die "Failed to compile"
		BLOODHOUND_BINDIR="BloodHound-linux-ia32"
	elif use arm; then
		npm run linuxbuild_arm || die "Failed to compile"
		BLOODHOUND_BINDIR="BloodHound-linux-armv7l"
	elif use arm64; then
		npm run linuxbuild_arm64 || die "Failed to compile"
		BLOODHOUND_BINDIR="BloodHound-linux-arm64"
	fi
}

src_install() {
	dodir /usr/$(get_libdir)/${PN}
	cp -R ${BLOODHOUND_BINDIR}/* "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"

	newbin - ${PN} <<-EOF
	#!/bin/sh
	cd /usr/$(get_libdir)/${PN}
	LD_LIBRARY_PATH=. exec ./${PN} "\${@}"
	EOF
}
