# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit java-pkg-2 desktop

GRADLE_DEP_VER="20240407"
RELEASE_VERSION=${PV}

DESCRIPTION="A software reverse engineering framework"
HOMEPAGE="https://ghidra-sre.org/"

FIDB_FILES="vs2012_x64.fidb  vs2015_x64.fidb  vs2017_x64.fidb  vs2019_x64.fidb  vsOlder_x64.fidb \
		vs2012_x86.fidb  vs2015_x86.fidb  vs2017_x86.fidb  vs2019_x86.fidb  vsOlder_x86.fidb"

# ./gradle/support/fetchDependencies.gradle
SRC_URI="https://github.com/NationalSecurityAgency/${PN}/archive/Ghidra_${PV}_build.tar.gz
	https://dev.pentoo.ch/~blshkv/distfiles/${PN}-dependencies-${GRADLE_DEP_VER}.tar.gz
	https://github.com/pxb1988/dex2jar/releases/download/v2.1/dex2jar-2.1.zip
	https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/android4me/AXMLPrinter2.jar
	https://sourceforge.net/projects/catacombae/files/HFSExplorer/0.21/hfsexplorer-0_21-bin.zip
	https://downloads.sourceforge.net/yajsw/yajsw/yajsw-stable-13.09.zip
	https://ftp.postgresql.org/pub/source/v15.3/postgresql-15.3.tar.gz
	https://archive.eclipse.org/tools/cdt/releases/8.6/cdt-8.6.0.zip
	https://downloads.sourceforge.net/pydev/pydev/PyDev%206.3.1/PyDev%206.3.1.zip -> PyDev-6.3.1.zip
	https://github.com/NationalSecurityAgency/ghidra-data/raw/Ghidra_${RELEASE_VERSION}/lib/java-sarif-2.1-modified.jar
"
for FIDB in ${FIDB_FILES}; do
	SRC_URI+=" https://github.com/NationalSecurityAgency/ghidra-data/raw/Ghidra_${RELEASE_VERSION}/FunctionID/${FIDB}"
done

# run: "pentoo/scripts/gradle_dependencies.py buildGhidra" from "${S}" directory to generate dependencies
#	https://www.eclipse.org/downloads/download.php?r=1&protocol=https&file=/tools/cdt/releases/8.6/cdt-8.6.0.zip

#	https://sourceforge.net/projects/yajsw/files/yajsw/yajsw-stable-13.05/yajsw-stable-13.05.zip/download

S="${WORKDIR}/ghidra-Ghidra_${PV}_build"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

#FIXME:
# * QA Notice: Files built without respecting CFLAGS have been detected
# * QA Notice: Files built without respecting LDFLAGS have been detected
# *  Please include the following list of files in your report:
# * /usr/share/ghidra/GPL/DemanglerGnu/os/linux_x86_64/demangler_gnu_v2_24
# * /usr/share/ghidra/GPL/DemanglerGnu/os/linux_x86_64/demangler_gnu_v2_33_1
# * /usr/share/ghidra/Ghidra/Features/Decompiler/os/linux_x86_64/decompile
# * /usr/share/ghidra/Ghidra/Features/Decompiler/os/linux_x86_64/sleigh
# * /usr/share/ghidra/Ghidra/Features/FileFormats/data/sevenzipnativelibs/Linux-amd64/lib7-Zip-JBinding.so

#java-pkg-2 sets java based on RDEPEND so the java slot in rdepend is used to build
RDEPEND="virtual/jre:17"
DEPEND="${RDEPEND}
	virtual/jdk:17
	sys-devel/bison
	dev-java/jflex
	app-arch/unzip"
BDEPEND=">=dev-java/gradle-bin-7.3:*"

check_gradle_binary() {
	gradle_link_target=$(readlink -n /usr/bin/gradle)
	currentver="${gradle_link_target/gradle-bin-/}"
	requiredver="7.3"
	einfo "Gradle version ${currentver} currently set."
	if [ "$(printf '%s\n' "$requiredver" "$currentver" | sort -V | head -n1)" = "$requiredver" ]; then
		einfo "Gradle version ${currentver} is >= ${requiredver}, proceeding with build..."
	else
		eerror "Gradle version ${requiredver} or higher must be eselected before building ${PN}."
		die "Please run 'eselect gradle set gradle-bin-XX' when XX is a version of gradle higher than ${requiredver}"
	fi
}

src_unpack() {
	# https://github.com/NationalSecurityAgency/ghidra/blob/master/DevGuide.md
	# alternative:
	# gradle -I gradle/support/fetchDependencies.gradle init
	# gradle -g dependencies/gradle prepdev
	# build: gradle -g dependencies/gradle buildGhidra
	unpack ${A}
	mkdir -p "${S}/.gradle/flatRepo" || die "(1) mkdir failed"
	cd "${S}/.gradle"

	unpack dex2jar-2.1.zip
	cp dex-tools-2.1/lib/dex-*.jar ./flatRepo || die "(2) cp failed"

	cp "${DISTDIR}/AXMLPrinter2.jar" ./flatRepo  || die "(3) cp failed"
	cp "${DISTDIR}/java-sarif-2.1-modified.jar" ./flatRepo  || die "(4) cp failed"

	unpack hfsexplorer-0_21-bin.zip
	cp lib/*.jar ./flatRepo            || die "(5) cp failed"

	mkdir -p "${WORKDIR}"/ghidra.bin/Ghidra/Features/GhidraServer/ || die "(6) mkdir failed"
	cp "${DISTDIR}"/yajsw-stable-13.09.zip "${WORKDIR}"/ghidra.bin/Ghidra/Features/GhidraServer/ || die "(7) cp failed"

	PLUGIN_DEP_PATH="ghidra.bin/GhidraBuild/EclipsePlugins/GhidraDev/buildDependencies"
	mkdir -p "${WORKDIR}/${PLUGIN_DEP_PATH}/" || die "(8) mkdir failed"
	cp "${DISTDIR}"/PyDev-6.3.1.zip "${WORKDIR}/${PLUGIN_DEP_PATH}/PyDev 6.3.1.zip" || die "(9) cp failed"
	cp "${DISTDIR}"/cdt-8.6.0.zip   "${WORKDIR}/${PLUGIN_DEP_PATH}/" || die "(10) cp failed"
	cp "${DISTDIR}"/postgresql-15.3.tar.gz   "${WORKDIR}/${PLUGIN_DEP_PATH}/" || die "(10) cp failed"

	cd "${S}"
	mv ../dependencies .

	mkdir ./dependencies/fidb || die "failed to create fidb dir"
	cp "${DISTDIR}/${FIDB_FILES}" ./dependencies/fidb/
}

src_prepare() {
	mkdir -p ".gradle/init.d"                       || die "(10) mkdir failed"
	cp "${FILESDIR}"/repos.gradle .gradle/init.d    || die "(11) cp failed"
	sed -i "s|S_DIR|${S}|g" .gradle/init.d/repos.gradle || die "(12) sed failed"
	#remove build date so we can unpack dist.zip later
	sed -i "s|_\${rootProject.BUILD_DATE_SHORT}||g" gradle/root/distribution.gradle || die "(13) sed failed"

	#10.0 workaround
	ln -s ../.gradle/flatRepo ./dependencies/flatRepo

	eapply_user
}

src_compile() {
	check_gradle_binary
	export _JAVA_OPTIONS="$_JAVA_OPTIONS -Duser.home=$HOME -Djava.io.tmpdir=${T}"

	GRADLE="gradle --gradle-user-home .gradle --console rich --no-daemon"
	GRADLE="${GRADLE} --offline --parallel --max-workers $(nproc)"
	unset TERM
	${GRADLE} prepDev -x check -x test || die
	${GRADLE} buildGhidra -x check -x test --parallel || die

#build without eclipse plugin
#	${GRADLE} yajswDevUnpack -x check -x test || die
#	${GRADLE} buildNatives_linux64 -x check -x test || die
#	${GRADLE} sleighCompile -x check -x test || die
}

src_install() {
	#FIXME: it is easier to unpack existing archive for now
	dodir /usr/share
	unzip build/dist/ghidra_"${PV}"_DEV_linux_x86_64.zip -d "${ED}"/usr/share/ || die "unable to unpack dist zip"
	mv "${ED}"/usr/share/ghidra_"${PV}"_DEV "${ED}"/usr/share/ghidra || die "mv failed"
	# remove zip files which aren't needed at runtime
	find "${ED}"/usr/share/ghidra -type f -name '*.zip' -exec rm -f {} +

	#fixme: add doc flag
	rm -r  "${ED}"/usr/share/ghidra/docs/ || die "rm failed"
	dosym -r /usr/share/ghidra/ghidraRun /usr/bin/ghidra

	# icon
	doicon GhidraDocs/GhidraClass/Beginner/Images/GhidraLogo64.png
	# desktop entry
	make_desktop_entry ${PN} "Ghidra" /usr/share/pixmaps/GhidraLogo64.png "Utility"
}
