# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

GRADLE_DEP_VER="20201103"

DESCRIPTION="Decode, monitor, record and stream trunked mobile and related radio protocols"
HOMEPAGE="https://github.com/DSheirer/sdrtrunk"
SRC_URI="https://github.com/DSheirer/sdrtrunk/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://dev.pentoo.ch/~blshkv/distfiles/${PN}-dependencies-${GRADLE_DEP_VER}.tar.gz"

KEYWORDS="~amd64"
LICENSE="GPL-3"
SLOT="0"

#TODO: migratge to virtual/jdk:15 so java-pkg-2 below would work
#java-pkg-2 sets java based on RDEPEND so the java slot in rdepend is used to build
#requires >= jdk-13
RDEPEND="dev-java/openjdk-bin:15"
DEPEND="${RDEPEND}
	!net-wireless/sdrtrunk-bin
	dev-java/gradle-bin:6.3"

src_prepare() {
	eapply "${FILESDIR}"/1.5.2-build.patch

	mkdir -p ".gradle/init.d"
	cp "${FILESDIR}"/1.5.2-repos.gradle .gradle/init.d/repos.gradle    || die "cp failed"
	sed -i "s|WORK_DIR|${WORKDIR}|g" .gradle/init.d/repos.gradle || die "sed failed"

	sed -i "s|WORK_DIR|${WORKDIR}|g" build.gradle || die "sed failed"
	sed -i "s|WORK_DIR|${WORKDIR}|g" settings.gradle || die "sed failed"

	eapply_user
}

src_compile() {
	GRADLE="gradle-6.3 --gradle-user-home .gradle --console rich --no-daemon"
	GRADLE="${GRADLE} --offline"
	unset TERM
	${GRADLE} runtime -x check -x test || die
}

src_install() {
	dodir /opt/sdrtrunk/
	cp -R ./build/image/* "${ED}"/opt/sdrtrunk/
	dosym "${EPREFIX}"/opt/sdrtrunk/bin/sdr-trunk /usr/bin/sdr-trunk
}
