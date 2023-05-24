# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

#package.json: "electron": "^11.5.0"
ELECTRON_PV="11.5.0"
ELECTRON_P="electron-v${ELECTRON_PV}"
ELECTRON_URL="github.com/electron/electron/releases/download/v${ELECTRON_PV}"

DESCRIPTION="Six Degrees of Domain Admin"
HOMEPAGE="https://github.com/BloodHoundAD/BloodHound"
SRC_URI="https://github.com/BloodHoundAD/BloodHound/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	amd64? ( https://${ELECTRON_URL}/${ELECTRON_P}-linux-x64.zip )
	arm? (   https://${ELECTRON_URL}/${ELECTRON_P}-linux-armv7l.zip )
	arm64? ( https://${ELECTRON_URL}/${ELECTRON_P}-linux-arm64.zip )
	x86? (   https://${ELECTRON_URL}/${ELECTRON_P}-linux-ia32.zip )
	https://dev.pentoo.ch/~blshkv/distfiles/${PN}-4.2.0-node_modules.tar.gz"
#create modules using "npm install"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"
IUSE=""

DEPEND=">=net-libs/nodejs-12.10.0[npm]"
#	dev-util/electron-packager"
RDEPEND="${DEPEND}"
#	gnome-base/gconf"
BDEPEND="app-arch/unzip"

BLOODHOUND_BINDIR="FAILED_TO_DETECT_ARCH"
QA_FLAGS_IGNORED="usr/lib.*/BloodHound/.*\.so"

src_prepare() {
	eapply "${FILESDIR}/4.2.0-singlearch.patch"
	mv "${WORKDIR}/node_modules" "${S}"
	eapply_user
}

src_compile() {
	#npm shrinkwrap
	#we  provide node_modules, there is no need to install
	#npm install \

	addpredict /etc/npm
#	npm run-script webbuild || die "Webbuild failed to compile"
	npm run-script compile || die "Webbuild failed to compile"

	if use amd64; then
		npm run-script package:linux_64 || die "Failed to compile"
		BLOODHOUND_BINDIR="BloodHound-linux-x64"
#	elif use x86; then
#		npm run-script linuxbuild_32 || die "Failed to compile"
#		BLOODHOUND_BINDIR="BloodHound-linux-ia32"
	elif use arm; then
		npm run-script package:linux_arm || die "Failed to compile"
		BLOODHOUND_BINDIR="BloodHound-linux-armv7l"
	elif use arm64; then
		npm run-script package:linux_arm64 || die "Failed to compile"
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

pkg_postinst() {
	einfo "Run with --disable-gpu-sandbox if you see \"GPU process isn't usable\" message"
}
