# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop java-pkg-2 xdg-utils

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

#java-pkg-2 sets java based on RDEPEND so the java slot in rdepend is used to build
RDEPEND="virtual/jre:11
	!dev-util/jd-gui-bin"
DEPEND="${RDEPEND}
	virtual/jdk:11
	dev-java/gradle-bin:6.8.3"

check_gradle_binary() {
	gradle_link_target=$(readlink -n /usr/bin/gradle)
	currentver="${gradle_link_target/gradle-bin-/}"
	requiredver="6.8.3"
	einfo "Gradle version ${currentver} currently set."
	if [ "$(printf '%s\n' "$requiredver" "$currentver" | sort -V | head -n1)" = "$requiredver" ]; then
		einfo "Gradle version ${currentver} is >= ${requiredver}, proceeding with build..."
	else
		eerror "Gradle version ${requiredver} or higher must be eselected before building ${PN}."
		die "Please run 'eselect gradle set gradle-bin-XX' when XX is a version of gradle higher than ${requiredver}"
	fi
}

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
	# FIXME: must check for the specific version only (6.8.3)
	#check_gradle_binary

	export _JAVA_OPTIONS="$_JAVA_OPTIONS -Duser.home=$HOME -Djava.io.tmpdir=${T}"
	GRADLE="gradle-bin-6.8.3 --gradle-user-home .gradle --console rich --no-daemon"
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

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
