# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV=${PV//_beta/-beta.}

GRADLE_DEP_VER="20230111"

DESCRIPTION="Decode, monitor, record and stream trunked mobile and related radio protocols"
HOMEPAGE="https://github.com/DSheirer/sdrtrunk"
SRC_URI="https://github.com/DSheirer/sdrtrunk/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz
	https://dev.pentoo.ch/~blshkv/distfiles/${PN}-dependencies-${GRADLE_DEP_VER}.tar.gz"

S="${WORKDIR}/${PN}-${MY_PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

# depend on alsa: https://github.com/pentoo/pentoo-overlay/issues/1417
RDEPEND="virtual/jdk:17
	!net-wireless/sdrtrunk-bin
	|| ( dev-java/openjdk-bin:17[alsa] dev-java/openjdk:17[alsa] )
	media-libs/alsa-lib
	media-libs/freetype
	media-libs/giflib:=
	media-libs/harfbuzz:=
	media-libs/lcms:2
	media-libs/libjpeg-turbo:=
	media-libs/libpng:=
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXrender
	x11-libs/libXtst
"
DEPEND="${RDEPEND}
	dev-java/gradle-bin:*"

src_prepare() {
	eapply "${FILESDIR}"/0.5.0-build.patch
	# https://github.com/DSheirer/sdrtrunk/issues/1274
	eapply "${FILESDIR}"/1182.patch

	mkdir -p ".gradle/init.d"
	cp "${FILESDIR}"/0.5.0-repos.gradle .gradle/init.d/repos.gradle    || die "cp failed"
	sed -i "s|WORK_DIR|${WORKDIR}|g" .gradle/init.d/repos.gradle || die "sed failed"

	sed -i "s|WORK_DIR|${WORKDIR}|g" build.gradle || die "sed failed"
	sed -i "s|WORK_DIR|${WORKDIR}|g" settings.gradle || die "sed failed"

	eapply_user
}

src_compile() {
	GRADLE="gradle --gradle-user-home .gradle --console rich --no-daemon"
	GRADLE="${GRADLE} --offline"
	unset TERM
	${GRADLE} runtime -x check -x test || die
}

src_install() {
	dodir /opt/sdrtrunk/
	cp -R ./build/image/* "${ED}"/opt/sdrtrunk/
	dosym "${EPREFIX}"/opt/sdrtrunk/bin/sdr-trunk /usr/bin/sdr-trunk
}
