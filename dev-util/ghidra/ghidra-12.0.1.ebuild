# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
inherit java-pkg-2 desktop python-single-r1

GRADLE_DEP_VER="20260118"
# Ghidra/application.properties
GRADLE_VER="8.5"

RELEASE_VERSION="11.4"   #${PV}

DESCRIPTION="A software reverse engineering framework"
HOMEPAGE="https://ghidra-sre.org/"

# ./gradle/support/fetchDependencies.gradle
FIDB_FILES="vs2012_x86.fidb vs2012_x64.fidb vs2015_x86.fidb vs2015_x64.fidb \
vs2017_x86.fidb vs2017_x64.fidb vs2019_x86.fidb vs2019_x64.fidb vsOlder_x86.fidb vsOlder_x64.fidb"

Z3_VER="4.13.0"
#Z3_ARM64_OSX_VER = "11.0"
#Z3_X64_OSX_VER = "11.7.10"
Z3_X64_GLIBC_VER="2.31"
Z3_NAME="z3-${Z3_VER}-x64-glibc-${Z3_X64_GLIBC_VER}"
# ./gradle/support/fetchDependencies.gradle
#        https://github.com/NationalSecurityAgency/ghidra/archive/refs/tags/Ghidra_11.4_build.tar.gz
SRC_URI="https://github.com/NationalSecurityAgency/${PN}/archive/refs/tags/Ghidra_${PV}_build.tar.gz
	https://dev.pentoo.ch/~blshkv/distfiles/${PN}-dependencies-${GRADLE_DEP_VER}.tar.gz
	https://github.com/pxb1988/dex2jar/releases/download/v2.4/dex-tools-v2.4.zip
	https://github.com/NationalSecurityAgency/ghidra-data/raw/Ghidra_${RELEASE_VERSION}/Debugger/dbgmodel.tlb
	https://github.com/digitalsleuth/AXMLPrinter2/raw/691036a3caf84950fbb0df6f1fa98d7eaa92f2a0/AXMLPrinter2.jar
	https://github.com/unsound/hfsexplorer/releases/download/hfsexplorer-0.21/hfsexplorer-0_21-bin.zip
	https://downloads.sourceforge.net/yajsw/yajsw/yajsw-stable-13.12.zip
	https://ftp.postgresql.org/pub/source/v15.10/postgresql-15.10.tar.gz
	https://archive.eclipse.org/tools/cdt/releases/8.6/cdt-8.6.0.zip
	https://sourceforge.net/projects/pydev/files/pydev/PyDev%209.3.0/PyDev%209.3.0.zip -> PyDev-9.3.0.zip
	https://github.com/NationalSecurityAgency/ghidra-data/raw/Ghidra_${RELEASE_VERSION}/lib/java-sarif-2.1-modified.jar
	https://github.com/Z3Prover/z3/releases/download/z3-${Z3_VER}/${Z3_NAME}.zip
"
for FIDB in ${FIDB_FILES}; do
	SRC_URI+=" https://github.com/NationalSecurityAgency/ghidra-data/raw/Ghidra_${RELEASE_VERSION}/FunctionID/${FIDB}"
done

	SRC_URI+=" https://files.pythonhosted.org/packages/8d/14/619e24a4c70df2901e1f4dbc50a6291eb63a759172558df326347dce1f0d/protobuf-3.20.3-py2.py3-none-any.whl
	https://files.pythonhosted.org/packages/90/c7/6dc0a455d111f68ee43f27793971cf03fe29b6ef972042549db29eec39a2/psutil-5.9.8.tar.gz
	https://files.pythonhosted.org/packages/c7/42/be1c7bbdd83e1bfb160c94b9cafd8e25efc7400346cf7ccdbdb452c467fa/setuptools-68.0.0-py3-none-any.whl
	https://files.pythonhosted.org/packages/27/d6/003e593296a85fd6ed616ed962795b2f87709c3eee2bca4f6d0fe55c6d00/wheel-0.37.1-py2.py3-none-any.whl
	https://files.pythonhosted.org/packages/ce/78/91db67e7fe1546dc8b02c38591b7732980373d2d252372f7358054031dd4/Pybag-2.2.12-py3-none-any.whl
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
# * /usr/share/ghidra/GPL/DemanglerGnu/os/linux_x86_64/demangler_gnu_v2_41
# * /usr/share/ghidra/Ghidra/Features/Decompiler/os/linux_x86_64/decompile
# * /usr/share/ghidra/Ghidra/Features/Decompiler/os/linux_x86_64/sleigh
# * /usr/share/ghidra/Ghidra/Features/FileFormats/data/sevenzipnativelibs/Linux-amd64/lib7-Zip-JBinding.so
# * /usr/share/ghidra/Ghidra/Features/FileFormats/os/linux_x86_64/lzfse

# FIXME:
# build fails with system-vm jdk-25, see:
# https://github.com/gradle/gradle/issues/35111
# java-pkg-2 does not set it for some reason
JAVA_PKG_WANT_SOURCE="21"
JAVA_PKG_WANT_TARGET="21"

REQUIRED_USE=${PYTHON_REQUIRED_USE}
#java-pkg-2 sets java based on RDEPEND so the java slot in rdepend is used to build
#>=virtual/jdk-21:*
RDEPEND="virtual/jre:21
		${PYTHON_DEPS}"
DEPEND="${RDEPEND}
	virtual/jdk:21
	sys-devel/bison
	dev-java/jflex
	app-arch/unzip"
BDEPEND=">=dev-java/gradle-bin-${GRADLE_VER}:* <dev-java/gradle-bin-9.0.0
		dev-python/pip"

check_gradle_binary() {
	gradle_link_target=$(readlink -n /usr/bin/gradle)
	currentver="${gradle_link_target/gradle-bin-/}"
	requiredver="${GRADLE_VER}"
	einfo "Gradle version ${currentver} currently set."
	if [ "$(echo ${currentver} | cut -d. -f1)" -ge "9" ]; then
		eerror "Selected gradle version ${currentver} is too high. It must be eselected before building ${PN}."
		die "Please run 'eselect gradle set gradle-bin-XX' when XX is a version of gradle lower than 9."
	elif [ "$(printf '%s\n' "$requiredver" "$currentver" | sort -V | head -n1)" = "$requiredver" ]; then
		einfo "Gradle version ${currentver} is >= ${requiredver}, proceeding with build..."
	else
		eerror "Gradle version ${requiredver} or higher must be eselected before building ${PN}."
		die "Please run 'eselect gradle set gradle-bin-XX' when XX is a version of gradle higher than ${requiredver}"
	fi
}

pkg_setup() {
	java-pkg-2_pkg_setup
	python-single-r1_pkg_setup
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

	unpack dex-tools-v2.4.zip
	cp dex-tools-v2.4/lib/dex-*.jar ./flatRepo || die "(2) cp failed"

	cp "${DISTDIR}/AXMLPrinter2.jar" ./flatRepo  || die "(3) cp failed"
	cp "${DISTDIR}/java-sarif-2.1-modified.jar" ./flatRepo  || die "(4) cp failed"

	unpack hfsexplorer-0_21-bin.zip
	cp lib/*.jar ./flatRepo            || die "(5) cp failed"

	mkdir -p "${WORKDIR}"/ghidra.bin/Ghidra/Features/GhidraServer/ || die "(6) mkdir failed"
	cp "${DISTDIR}"/yajsw-stable-13.12.zip "${WORKDIR}"/ghidra.bin/Ghidra/Features/GhidraServer/ || die "(7) cp failed"

	PLUGIN_DEP_PATH="ghidra.bin/GhidraBuild/EclipsePlugins/GhidraDev/buildDependencies"
	mkdir -p "${WORKDIR}/${PLUGIN_DEP_PATH}/" || die "(8) mkdir failed"
	cp "${DISTDIR}"/PyDev-9.3.0.zip "${WORKDIR}/${PLUGIN_DEP_PATH}/PyDev 9.3.0.zip" || die "(9) cp failed"
	cp "${DISTDIR}"/cdt-8.6.0.zip   "${WORKDIR}/${PLUGIN_DEP_PATH}/" || die "(10) cp failed"
	cp "${DISTDIR}"/postgresql-15.10.tar.gz   "${WORKDIR}/${PLUGIN_DEP_PATH}/" || die "(10) cp failed"

	unpack ${Z3_NAME}.zip
	mkdir -p ./dependencies/SymbolicSummaryZ3/os/linux_x86_64
	cp ${Z3_NAME}/bin/libz3*.so ./dependencies/SymbolicSummaryZ3/os/linux_x86_64 || die "(11) cp failed"
	cp ${Z3_NAME}/bin/*.jar ./flatRepo || die "(12) cp failed"

	cd "${S}"
	mv ../dependencies .

	mkdir ./dependencies/fidb || die "failed to create fidb dir"
	for FIDB in ${FIDB_FILES}; do
		cp "${DISTDIR}/${FIDB}" ./dependencies/fidb/ || die
	done

	#copy whl
	mkdir -p ./dependencies/{Debugger-rmi-trace,Debugger-agent-dbgeng} || die "failed to create Debugger dir"
	cp "${DISTDIR}"/protobuf-3.20.3-py2.py3-none-any.whl ./dependencies/Debugger-rmi-trace/ || die
	cp "${DISTDIR}"/psutil-5.9.8.tar.gz ./dependencies/Debugger-rmi-trace/ || die
	cp "${DISTDIR}"/setuptools-68.0.0-py3-none-any.whl ./dependencies/Debugger-rmi-trace/ || die
	cp "${DISTDIR}"/wheel-0.37.1-py2.py3-none-any.whl ./dependencies/Debugger-rmi-trace/ || die

	cp "${DISTDIR}"/Pybag-2.2.12-py3-none-any.whl ./dependencies/Debugger-agent-dbgeng/ || die
	cp "${DISTDIR}"/capstone-5.0.1-py3-none-win_amd64.whl ./dependencies/Debugger-agent-dbgeng/ || die
	cp "${DISTDIR}"/comtypes-1.4.1-py3-none-any.whl ./dependencies/Debugger-agent-dbgeng/ || die
	cp "${DISTDIR}"/pywin32-306-cp312-cp312-win_amd64.whl ./dependencies/Debugger-agent-dbgeng/ || die

	cp "${DISTDIR}"/dbgmodel.tlb ./dependencies/Debugger-agent-dbgeng/ || die

}

src_prepare() {
	mkdir -p ".gradle/init.d"                       || die "(10) mkdir failed"
	cp "${FILESDIR}"/repos.gradle .gradle/init.d    || die "(11) cp failed"
	sed -i "s|S_DIR|${S}|g" .gradle/init.d/repos.gradle || die "(12) sed failed"
	#remove build date so we can unpack dist.zip later
	sed -i "s|_\${rootProject.BUILD_DATE_SHORT}||g" gradle/root/distribution.gradle || die "(13) sed failed"
	#10.0 workaround
	ln -s ../.gradle/flatRepo ./dependencies/flatRepo

	# First attempt at disabling pip
	#sed -i 's#pip#echo#' Ghidra/Features/PyGhidra/build.gradle || die

	# Use the correct python version
	# https://github.com/pentoo/pentoo-overlay/issues/2243
	#sed -i "s/findPython3\(true\)/\"${EPYTHON}\"/" build.gradle || die
	sed -i "s/findPython3(true)/\"${EPYTHON}\"/" build.gradle || die

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
	shopt -s nullglob
	# cd to install dir so the globbing works even when Ghidra isn't installed already
	pushd "${ED}"
	fperms +x usr/share/ghidra/Ghidra/Debug/Debugger-*/data/{debugger-launchers,support}/*.sh
	popd
	shopt -u nullglob

	dosym -r /usr/share/ghidra/ghidraRun /usr/bin/ghidra

	# icon
	doicon GhidraDocs/GhidraClass/Beginner/Images/GhidraLogo64.png
	# desktop entry
	make_desktop_entry ${PN} "Ghidra" /usr/share/pixmaps/GhidraLogo64.png "Utility"
}
