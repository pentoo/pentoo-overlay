# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit java-pkg-2 desktop

GRADLE_DEP_VER="20240509"
RELEASE_VERSION=${PV}

DESCRIPTION="A software reverse engineering framework"
HOMEPAGE="https://ghidra-sre.org/"

FIDB_FILES="vs2012_x86.fidb vs2012_x64.fidb vs2015_x86.fidb vs2015_x64.fidb \
vs2017_x86.fidb vs2017_x64.fidb vs2019_x86.fidb vs2019_x64.fidb vsOlder_x86.fidb vsOlder_x64.fidb"

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

	SRC_URI+=" https://files.pythonhosted.org/packages/8d/14/619e24a4c70df2901e1f4dbc50a6291eb63a759172558df326347dce1f0d/protobuf-3.20.3-py2.py3-none-any.whl
	https://files.pythonhosted.org/packages/90/c7/6dc0a455d111f68ee43f27793971cf03fe29b6ef972042549db29eec39a2/psutil-5.9.8.tar.gz
	https://files.pythonhosted.org/packages/c7/42/be1c7bbdd83e1bfb160c94b9cafd8e25efc7400346cf7ccdbdb452c467fa/setuptools-68.0.0-py3-none-any.whl
	https://files.pythonhosted.org/packages/27/d6/003e593296a85fd6ed616ed962795b2f87709c3eee2bca4f6d0fe55c6d00/wheel-0.37.1-py2.py3-none-any.whl
	https://files.pythonhosted.org/packages/2d/e0/f877c91e036fcaed2a827f80d6cbdf1d26cffc3333c9ebda31c55c45f050/Pybag-2.2.10-py3-none-any.whl
	https://files.pythonhosted.org/packages/d0/dd/b28df50316ca193dd1275a4c47115a720796d9e1501c1888c4bfa5dc2260/capstone-5.0.1-py3-none-win_amd64.whl
	https://files.pythonhosted.org/packages/50/8f/518a37381e55a8857a638afa86143efa5508434613541402d20611a1b322/comtypes-1.4.1-py3-none-any.whl
	https://files.pythonhosted.org/packages/83/1c/25b79fc3ec99b19b0a0730cc47356f7e2959863bf9f3cd314332bddb4f68/pywin32-306-cp312-cp312-win_amd64.whl"

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
	app-arch/unzip
	dev-python/pip"
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

	#copy whl
	mkdir -p ./dependencies/{Debugger-rmi-trace,Debugger-agent-dbgeng} || die "failed to create Debugger dir"
	cp "${DISTDIR}"/protobuf-3.20.3-py2.py3-none-any.whl ./dependencies/Debugger-rmi-trace/
	cp "${DISTDIR}"/psutil-5.9.8.tar.gz ./dependencies/Debugger-rmi-trace/
	cp "${DISTDIR}"/setuptools-68.0.0-py3-none-any.whl ./dependencies/Debugger-rmi-trace/
	cp "${DISTDIR}"/wheel-0.37.1-py2.py3-none-any.whl ./dependencies/Debugger-rmi-trace/

	cp "${DISTDIR}"/Pybag-2.2.10-py3-none-any.whl ./dependencies/Debugger-agent-dbgeng/
	cp "${DISTDIR}"/capstone-5.0.1-py3-none-win_amd64.whl ./dependencies/Debugger-agent-dbgeng/
	cp "${DISTDIR}"/comtypes-1.4.1-py3-none-any.whl ./dependencies/Debugger-agent-dbgeng/
	cp "${DISTDIR}"/pywin32-306-cp312-cp312-win_amd64.whl ./dependencies/Debugger-agent-dbgeng/

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
	${GRADLE} assembleAll -x check -x test --parallel || die

#build without eclipse plugin
#	${GRADLE} yajswDevUnpack -x check -x test || die
#	${GRADLE} buildNatives_linux64 -x check -x test || die
#	${GRADLE} sleighCompile -x check -x test || die
}

src_install() {
	# remove zip files which aren't needed at runtime
	find build/dist/ghidra_${PV}_DEV/ -type f -name '*.zip' -exec rm -f {} +
	#FIXME: add doc flag
	rm -r  build/dist/ghidra_${PV}_DEV/docs/ || die "rm failed"

	insinto /usr/share/ghidra
	doins -r build/dist/ghidra_${PV}_DEV/*
	fperms +x /usr/share/ghidra/ghidraRun
	fperms +x /usr/share/ghidra/support/launch.sh
	fperms +x /usr/share/ghidra/GPL/DemanglerGnu/os/linux_x86_64/demangler_gnu_v2_41
	fperms +x /usr/share/ghidra/Ghidra/Features/Decompiler/os/linux_x86_64/decompile

	dosym -r /usr/share/ghidra/ghidraRun /usr/bin/ghidra

	# icon
	doicon GhidraDocs/GhidraClass/Beginner/Images/GhidraLogo64.png
	# desktop entry
	make_desktop_entry ${PN} "Ghidra" /usr/share/pixmaps/GhidraLogo64.png "Utility"
}
