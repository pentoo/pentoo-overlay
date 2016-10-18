# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# PyInstaller assumes CPython internals and is hence currently incompatible with
# alternative interpreters (e.g., PyPy).
PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

# "waf" requires a threading-enabled Python interpreter.
PYTHON_REQ_USE='threads(+)'

# Order of operations is significant here. Since we explicitly call "waf-utils"
# but *NOT* "distutils-r1" phase functions, ensure the latter remain the default
# by inheriting the latter *AFTER* the former.
inherit waf-utils distutils-r1

DESCRIPTION="Program converting Python programs into stand-alone executables"
HOMEPAGE="http://www.pyinstaller.org"

LICENSE="pyinstaller"
SLOT="0"

IUSE="clang debug doc leak-detector"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#FIXME: Interestingly, PyInstaller itself has no hard or soft dependencies
#excluding the expected build-time dependency of "setuptools". Its unit tests,
#however, require an elaborate set of pure-Python packages, C-based Python
#extensions, and system-wide shared libraries. It's fairly extreme --
#sufficiently extreme, in fact, that we do *NOT* currently bother. For an
#exhaustive list of such dependencies, see "tests/test-requirements.txt".

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}
	leak-detector? ( dev-libs/boehm-gc )
	 clang? ( sys-devel/clang )
	!clang? ( sys-devel/gcc )
"

# While the typical "waf" project permits "waf" to be run from outside the
# directory containing "waf", PyInstaller requires "waf" to be run from inside
# such directory in a relative manner. Ensure this.
WAF_BINARY="./waf"

# Since the "waf" script bundled with PyInstaller does *NOT* support the
# conventionel "--libdir" option, prevent such option from being passed.
NO_WAF_LIBDIR=1

if [[ ${PV} == 9999 ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/pyinstaller/pyinstaller"
	EGIT_BRANCH="develop"
	SRC_URI=""
	KEYWORDS=""
else
	MY_PN="PyInstaller"
	MY_P="${MY_PN}-${PV}"
	SRC_URI="https://github.com/pyinstaller/pyinstaller/releases/download/v${PV}/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

python_prepare_all() {
	#FIXME: This is almost certainly wrong. We almost certainly want to use
	#actual USE flags instead: e.g.,
	#
	# local arch_word_size
	# if use amd64; then
	# 	  arch_word_size=64
	# elif use x86; then
	#     arch_word_size=32
	# else
	# 	  die "Architecture \"${ARCH}\" unsupported."
	# fi

	# Word size for the current architecture. (There simply *MUST* be a more
	# Gentooish way of determining this. I couldn't find it. While we should
	# arguably test "[[ "$(getconf LONG_BIT)" == 64 ]]" instead, such magic is
	# arguably even kludgier. Your mileage may vary.)
	local arch_word_size
	case "${ARCH}" in
	amd64) arch_word_size=64;;
	*)     arch_word_size=32;;
	esac

	# Install only the Linux bootloader specific to:
	#
	# * The architecture of the current machine.
	# * The release type requested for the current installation. Specifically:
	#   * If the "debug" USE flag is enabled, only install the "run_d" binary.
	#   * Else, only install the "run" binary.
	local bootloader_basename='run'
	use debug && bootloader_basename+='_d'
	sed -i \
		-e '/.*bootloader\/\*\/*.*/s~\*/\*~Linux-'${arch_word_size}'bit/'${bootloader_basename}'~' \
		setup.py || die '"sed" failed.'

	# Prevent badness during compilation. Specifically (in order):
	# 
	# * Avoid stripping bootloader binaries.
	# * Prevent the bootloader from being compiled under:
	#   * Hard-coded ${CFLAGS}.
	#   * gcc option "-Werror", converting compiler warnings to errors and hence
	#     failing on the first (inevitable) warning.
	sed -i \
		-e "s~\\(\\s*\\)features\\s*=\\s*'strip'$~\\1pass~" \
		-e "s~\\(\\s*\\)ctx.env.append_value('CFLAGS', '-O2')$~\\1pass~" \
		-e "/'CFLAGS',\\s*'-Werror'/d" \
		bootloader/wscript || die '"sed" failed.'

	# Continue with the default behaviour.
	distutils-r1_python_prepare_all
}

python_configure() {
	# CLI options to be passed to the "waf configure" command run below.
	local -a waf_configure_options; waf_configure_options=(
		 # Since Gentoo is *NOT* LSB-compliant, a non-LSB-compliant bootloader
		 # must be built. Sadly, doing so could reduce the portability of the
		 # resulting bootloader and hence applications frozen under that
		 # bootloader. Until Gentoo supplies an ebuild for building at least
		 # version 4.0 of the LSB tools, there's little we can do here.
		 --no-lsb
	)
	use debug && waf_configure_options+=( --debug )
	use clang && waf_configure_options+=( --clang )
	use leak-detector && waf_configure_options+=( --leak-detector )

	# Configure the Linux bootloader.
	cd bootloader
	waf-utils_src_configure "${waf_configure_options[@]}"

	# Continue with the default behaviour.
	cd "${S}"
	distutils-r1_python_configure
}

python_compile() {
	# Compile the non-debug Linux bootloader. Ideally, we would simply call
	# waf-utils_src_compile() to do so. Unfortunately, that function attempts to
	# run the "build" WAF task, which for PyInstaller *ALWAYS* fails with the
	# following fatal error:
	#
	#     Call "python waf all" to compile all bootloaders.
	#
	# Since the "waf-utils" eclass does *NOT* support running of alternative
	# tasks, we reimplement waf-utils_src_compile() to do so. (Since this is
	# lame, we should probably file a feature request with the author of the
	# "waf-utils" eclass.)
	cd bootloader
	local _mywafconfig
	[[ "${WAF_VERBOSE}" ]] && _mywafconfig="--verbose"
	local jobs="--jobs=$(makeopts_jobs)"
	echo "\"${WAF_BINARY}\" build_release ${_mywafconfig} ${jobs}"
	"${WAF_BINARY}" build_release ${_mywafconfig} ${jobs} ||
		die "Bootloader compilation failed."

	# Move the binaries for such bootloader to "PyInstaller/bootloader" *BEFORE*
	# compiling the non-bootloader portion of PyInstaller, which requires such
	# binaries. (Note that the "install_release" task does *NOT* install files
	# to ${IMAGE}, despite the "install" in such task name.)
	"${WAF_BINARY}" install_release || die "Bootloader installation failed."

	# Continue with the default behaviour.
	cd "${S}"
	distutils-r1_python_compile
}

python_install_all() {
	distutils-r1_python_install_all

	# Install plaintext documentation.
	dodoc README.rst doc/*.rst

	# If requested, install non-plaintext documentation as well.
	if use doc; then
		# Install HTML documentation.
		dohtml -r doc/*

		# Install PDF documentation.
		docinto pdf
		dodoc doc/*.pdf
	fi
}
