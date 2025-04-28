# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

GRADLE_DEP_VER="20250105"

DESCRIPTION="Decode, monitor, record and stream trunked mobile and related radio protocols"
HOMEPAGE="https://github.com/DSheirer/sdrtrunk"
SRC_URI="https://dev.pentoo.ch/~blshkv/distfiles/${PN}-dependencies-${GRADLE_DEP_VER}.tar.gz"

EGIT_REPO_URI="https://github.com/DSheirer/sdrtrunk.git"

LICENSE="GPL-3"
SLOT="0"

# depend on alsa: https://github.com/pentoo/pentoo-overlay/issues/1417
# sdrtrunk-9999/build.gradle  JavaLanguageVersion.of(23)

# FIXME: missing deps:
# JDK/JavaFX 23 or JavaFX 24

RDEPEND="
	!net-wireless/sdrtrunk-bin
	virtual/jdk:21
	dev-java/openjdk:21[alsa]
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

#src_unpack() {
#	einfo "DEBUG S = ${S}"
#	dodir "${WORKDIR}/${P}"
#	dodir "${S}"
#	unpack ${PN}-dependencies-${GRADLE_DEP_VER}.tar.gz
#}

src_prepare() {
	# FIXME: move to src_unpack
	unpack ${PN}-dependencies-${GRADLE_DEP_VER}.tar.gz

	eapply "${FILESDIR}"/0.5.0-build.patch
	# https://github.com/DSheirer/sdrtrunk/issues/1274
	eapply "${FILESDIR}"/1182.patch

	mkdir -p ".gradle/init.d"
	cp "${FILESDIR}"/0.5.0-repos.gradle .gradle/init.d/repos.gradle    || die "cp failed"
	sed -i "s|WORK_DIR|${WORKDIR}/${P}|g" .gradle/init.d/repos.gradle || die "sed failed"

	sed -i "s|WORK_DIR|${WORKDIR}/${P}|g" build.gradle || die "sed failed"
	sed -i "s|WORK_DIR|${WORKDIR}/${P}|g" settings.gradle || die "sed failed"

	# must match JDK
	sed -i "s|JavaLanguageVersion.of(23)|JavaLanguageVersion.of(24)|g" build.gradle || die "sed failed"

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
	dosym ../../"${EPREFIX}"/opt/sdrtrunk/bin/sdr-trunk /usr/bin/sdr-trunk
}
