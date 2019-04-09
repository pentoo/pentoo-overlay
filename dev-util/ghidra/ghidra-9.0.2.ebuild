# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A software reverse engineering framework"
HOMEPAGE="https://www.nsa.gov/ghidra"
SRC_URI="https://github.com/NationalSecurityAgency/ghidra/archive/Ghidra_${PV}_build.tar.gz
	https://github.com/pxb1988/dex2jar/releases/download/2.0/dex-tools-2.0.zip
	https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/android4me/AXMLPrinter2.jar
	https://sourceforge.net/projects/catacombae/files/HFSExplorer/0.21/hfsexplorer-0_21-bin.zip
	http://repo1.maven.org/maven2/org/python/jython-standalone/2.7.1/jython-standalone-2.7.1.jar
	mirror://sourceforge/yajsw/yajsw/yajsw-stable-12.12.zip
	https://dev.pentoo.ch/~blshkv/distfiles/ghidra-${PV}-gradle-cache.tar.gz"
#generate cache file by disabling --offline, ebuild clean test and
#tar cvzf ./ghidra-9.0.2-gradle-cache.tar.gz -C /var/tmp/portage/dev-util/ghidra-9.0.2/work ghidra-Ghidra_9.0.2_build/.gradle/caches/modules-2/

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=virtual/jre-1.8"
DEPEND="${DEPEND}
	>=virtual/jdk-1.8
	dev-java/gradle-bin:5.2.1
	sys-devel/bison
	dev-java/jflex
	dev-java/oracle-jdk-bin:11
	app-arch/unzip"

S="${WORKDIR}/ghidra-Ghidra_${PV}_build"

src_unpack() {
	unpack ${A}
	mkdir -p "${S}/.gradle/flatRepo"
	cd "${S}/.gradle"

	unpack dex-tools-2.0.zip
	cp dex2jar-2.0/lib/dex-*.jar ./flatRepo

	cp "${DISTDIR}/AXMLPrinter2.jar" ./flatRepo

	unpack hfsexplorer-0_21-bin.zip
	cp lib/*.jar ./flatRepo

	cp "${DISTDIR}"/jython-standalone-2.7.1.jar ./flatRepo

	#/var/tmp/portage/dev-util/ghidra-9.0.2/work/ghidra.bin/Ghidra/Features/GhidraServer/yajsw-stable-12.12.zip'
	mkdir -p "${WORKDIR}"/ghidra.bin/Ghidra/Features/GhidraServer/
	cp "${DISTDIR}"/yajsw-stable-12.12.zip "${WORKDIR}"/ghidra.bin/Ghidra/Features/GhidraServer/

	cd "${S}"
}

src_prepare() {
	sed -i 's|gradle.gradleVersion != "5.0"|gradle.gradleVersion <= "5.0"|g' build.gradle || die 'sed failed'
	mkdir -p ".gradle/init.d"
	cp "${FILESDIR}"/repos.gradle .gradle/init.d
	sed -i "s|S_DIR|${S}|g" .gradle/init.d/repos.gradle
	eapply_user
}

src_compile() {
	export JAVA_HOME="/opt/oracle-jdk-bin-11.0.2"
	export JAVAC="/opt/oracle-jdk-bin-11.0.2/bin/javac"
	export _JAVA_OPTIONS="$_JAVA_OPTIONS -Duser.home=$HOME"

	GRADLE="gradle-5.2.1 --gradle-user-home .gradle --console rich --no-daemon"
	GRADLE="${GRADLE} --offline"

	${GRADLE} yajswDevUnpack -x check -x test || die
	${GRADLE} buildGhidra -x check -x test || die
}

src_install() {
	#it is easier to unpack existing archive
	dodir /usr/share
	unzip build/dist/ghidra_9.0.2_PUBLIC_20190406_linux64.zip -d "${ED}"/usr/share/
	mv "${ED}"/usr/share/ghidra_9.0.2 "${ED}"/usr/share/ghidra
	#fixme: add doc flag
	rm -r  "${ED}"/usr/share/ghidra/docs/
	dosym "${EPREFIX}"/usr/share/ghidra/ghidraRun /usr/bin/ghidra
}
