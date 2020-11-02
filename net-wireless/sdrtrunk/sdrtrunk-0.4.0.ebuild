# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="decoding, monitoring, recording and streaming trunked mobile and related radio protocols"
HOMEPAGE="https://github.com/DSheirer/sdrtrunk"
SRC_URI="https://github.com/DSheirer/sdrtrunk/archive/v${PV}.tar.gz -> ${P}.tar.gz"

#WIP
#KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"

#java-pkg-2 sets java based on RDEPEND so the java slot in rdepend is used to build
RDEPEND="|| ( dev-java/openjdk-bin:15 )"
DEPEND="${RDEPEND}
	dev-java/gradle-bin:6.3"

#src_prepare() {
#	eapply "${FILESDIR}"/1.5.2-build.patch

#	mkdir -p ".gradle/init.d"
#	cp "${FILESDIR}"/1.5.2-repos.gradle .gradle/init.d/repos.gradle    || die "cp failed"
#	sed -i "s|WORK_DIR|${WORKDIR}|g" .gradle/init.d/repos.gradle || die "sed failed"

#	sed -i "s|WORK_DIR|${WORKDIR}|g" build.gradle || die "sed failed"
#	eapply_user
#}

#src_compile() {

#./gradlew clean build

#	GRADLE="gradle-5.2.1 --gradle-user-home .gradle --console rich --no-daemon"
#	GRADLE="${GRADLE} --offline"
#	unset TERM
#	${GRADLE} jar -x check -x test || die
#}

#src_install() {
#	insinto /usr/share/"${PN}"
#	doins "build/libs/${P}.jar"

#	doicon ./src/linux/resources/jd_icon_128.png
#	domenu ./src/linux/resources/jd-gui.desktop

#	echo -e "#!/bin/sh\njava -jar /usr/share/${PN}/${P}.jar >/dev/null 2>&1 &\n" > "${PN}"
#	dobin "${PN}"
#}
