# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PV=${PV//_beta/-beta.}

GRADLE_DEP_VER="20221127"

DESCRIPTION="Decode, monitor, record and stream trunked mobile and related radio protocols"
HOMEPAGE="https://github.com/DSheirer/sdrtrunk"
SRC_URI="https://github.com/DSheirer/sdrtrunk/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz
	https://dev.pentoo.ch/~blshkv/distfiles/${PN}-dependencies-${GRADLE_DEP_VER}.tar.gz"

KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"

RDEPEND="virtual/jdk:17"
DEPEND="${RDEPEND}
	!net-wireless/sdrtrunk-bin
	dev-java/gradle-bin:*"

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	eapply "${FILESDIR}"/0.5.0-build.patch
	#https://github.com/DSheirer/sdrtrunk/issues/1274
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
