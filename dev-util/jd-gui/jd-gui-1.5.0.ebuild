# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop

DESCRIPTION="A standalone Java Decompiler GUI"
HOMEPAGE="http://jd.benow.ca/"
SRC_URI="https://github.com/java-decompiler/jd-gui/archive/v${PV}.zip
	https://dev.pentoo.ch/~blshkv/distfiles/jd-gui-${PV}-gradle-dependencies.tar.gz"

# run: pentoo/scripts/gradle_dependencies.py from "${S}" directory to generate dependencies
# tar cvzf ./${P}-gradle-dependencies.tar.gz -C /var/tmp/portage/dev-util/${P}/work ${P}/dependencies/
#FIXME: gradle convert to publishToMavenLocal and mavenLocal()

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="virtual/jre"
DEPEND="${RDEPEND}
	>=virtual/jdk-11
	dev-java/gradle-bin:5.2.1
	!dev-util/jd-gui-bin"

src_prepare() {
	mkdir -p ".gradle/init.d"
	cp "${FILESDIR}"/repos.gradle .gradle/init.d    || die "cp failed"
	sed -i "s|S_DIR|${S}|g" .gradle/init.d/repos.gradle || die "sed failed"

	cp "${FILESDIR}"/build.gradle .
	sed -i "s|S_DIR|${S}|g" build.gradle || die "sed failed"
	eapply_user
}

src_compile() {
	GRADLE="gradle-5.2.1 --gradle-user-home .gradle --console rich --no-daemon"
	GRADLE="${GRADLE} --offline"
	${GRADLE} jar -x check -x test || die
}

src_install() {
	insinto /usr/share/"${PN}"
	doins "build/libs/${P}.jar"

	doicon ./src/linux/resources/jd_icon_128.png
	domenu ./src/linux/resources/jd-gui.desktop

	echo -e "#!/bin/sh\njava -jar /usr/share/${PN}/${P}.jar >/dev/null 2>&1 &\n" > "${PN}"
	dobin "${PN}"
}
