# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop java-pkg-2

DESCRIPTION="A standalone Java Decompiler GUI"
HOMEPAGE="http://jd.benow.ca/"
SRC_URI="https://github.com/java-decompiler/jd-gui/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://dev.pentoo.ch/~blshkv/distfiles/${PN}-dependencies-20210516.tar.gz"

# run: pentoo/scripts/gradle_dependencies.py from "${S}" directory to generate dependencies
# tar cvzf ./${P}-dependencies.tar.gz ./dependencies/
#FIXME: gradle convert to publishToMavenLocal and mavenLocal()

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#java-pkg-2 sets java based on RDEPEND so the java slot in rdepend is used to build
RDEPEND="virtual/jre:11
	!dev-util/jd-gui-bin"
DEPEND="${RDEPEND}
	virtual/jdk:11
	dev-java/gradle-bin:6.8.3"

src_prepare() {
	eapply "${FILESDIR}"/1.5.2-build.patch
	#https://github.com/java-decompiler/jd-gui/issues/361
	eapply -p0 "${FILESDIR}"/build-gradle.patch

	mkdir -p ".gradle/init.d"
	cp "${FILESDIR}"/1.5.2-repos.gradle .gradle/init.d/repos.gradle    || die "cp failed"
	sed -i "s|WORK_DIR|${WORKDIR}|g" .gradle/init.d/repos.gradle || die "sed failed"

	sed -i "s|WORK_DIR|${WORKDIR}|g" build.gradle || die "sed failed"
	eapply_user
}

src_compile() {
	export _JAVA_OPTIONS="$_JAVA_OPTIONS -Duser.home=$HOME -Djava.io.tmpdir=${T}"
	GRADLE="gradle --gradle-user-home .gradle --console rich --no-daemon"
	GRADLE="${GRADLE} --offline"
	unset TERM
	${GRADLE} jar -x check -x test || die
}

src_install() {
	insinto /usr/share/"${PN}"
	doins "build/libs/${P}.jar"

	doicon ./src/linux/resources/jd_icon_128.png
	domenu ./src/linux/resources/jd-gui.desktop

	newbin - ${PN} <<-EOF
		#!/bin/sh
		export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
		java -jar /usr/share/${PN}/${P}.jar >/dev/null 2>&1 &
	EOF

}
