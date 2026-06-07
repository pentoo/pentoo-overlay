# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: cpm-cmake.eclass
# @MAINTAINER: blshkv@pentoo.ch
# @SUPPORTED_EAPIS: 8
# @BLURB: Handle CPM (CMake Package Manager) offline dependency setup
# @DESCRIPTION:
# Automates the boilerplate for CMake projects that use CPM.cmake as their
# package manager. The eclass:
#
#   1. Fetches CPM.cmake and any packages listed in CPM_PACKAGES, appending
#      them to SRC_URI.
#   2. In src_prepare, places CPM.cmake into ${WORKDIR}/cpm/.
#   3. In src_configure, prepends the standard CPM cmake args
#      (-DCPM_DOWNLOAD_ALL=OFF, -DCPM_SOURCE_CACHE, per-package
#      -DCPM_<name>_SOURCE) and calls cmake_src_configure.
#
# Set CPM_VERSION and (optionally) CPM_PACKAGES before inheriting.
# Define cpm_configure() in the ebuild for project-specific cmake args;
# the eclass appends CPM args after calling it.
#
# @EXAMPLE:
# @CODE
#   CPM_VERSION="0.42.1"
#   CPM_PACKAGES=(
#       "tomlc17 cktan/tomlc17 R20260501"   # named tag
#       "mylib  owner/mylib   abc123def..."  # 40-char commit → commit URL
#   )
#   inherit cmake github-commit cpm-cmake
#
#   cpm_configure() {
#       mycmakeargs+=(
#           -DCMAKE_INSTALL_INCLUDEDIR="/usr/include"
#       )
#   }
# @CODE

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI} is not supported" ;;
esac

# @ECLASS_VARIABLE: CPM_VERSION
# @REQUIRED
# @DESCRIPTION:
# Version of CPM.cmake to fetch, e.g. "0.42.1".
# Must be set before inheriting.
[[ -z ${CPM_VERSION} ]] &&
	die "${ECLASS}: CPM_VERSION must be set before inheriting"

# @ECLASS_VARIABLE: CPM_PACKAGES
# @DEFAULT_UNSET
# @DESCRIPTION:
# Array of additional CPM-managed GitHub packages to pre-fetch.
# Each entry has the form: "name github_user/repo tag_or_commit"
#
# - name         : the NAME passed to CPMAddPackage()
# - github_user/repo : GitHub repository
# - tag_or_commit: a named tag (e.g. "R20260501") or a 40-char commit SHA
#
# The eclass automatically appends the correct GitHub tarball URL to
# SRC_URI and generates -DCPM_<name>_SOURCE in src_configure.
#
# @EXAMPLE:
# @CODE
#   CPM_PACKAGES=(
#       "tomlc17 cktan/tomlc17 R20260501"
#   )
# @CODE

# Fetch CPM.cmake; rename to avoid version collisions in distfiles.
SRC_URI+=" https://github.com/cpm-cmake/CPM.cmake/releases/download/v${CPM_VERSION}/CPM.cmake"
SRC_URI+=" -> CPM_${CPM_VERSION}.cmake"

# Process CPM_PACKAGES: append each package's tarball to SRC_URI.
# Named tags   → /archive/refs/tags/<tag>.tar.gz
# Commit SHAs  → /archive/<sha>.tar.gz  (detected as 40 hex chars)
for _cpm_pkg in "${CPM_PACKAGES[@]}"; do
	read -r _cpm_name _cpm_repo _cpm_ref <<< "${_cpm_pkg}"
	_cpm_rn="${_cpm_repo##*/}"
	if [[ ${_cpm_ref} =~ ^[0-9a-f]{40}$ ]]; then
		SRC_URI+=" https://github.com/${_cpm_repo}/archive/${_cpm_ref}.tar.gz"
	else
		SRC_URI+=" https://github.com/${_cpm_repo}/archive/refs/tags/${_cpm_ref}.tar.gz"
	fi
	SRC_URI+=" -> ${_cpm_rn}-${_cpm_ref}.gh.tar.gz"
done
unset _cpm_pkg _cpm_name _cpm_repo _cpm_ref _cpm_rn

# @FUNCTION: cpm-cmake_cpm_prepare
# @DESCRIPTION:
# Default CPM preparation step: creates ${WORKDIR}/cpm/ and copies
# CPM.cmake into it so the build system can find it without network access.
# Must be called by cpm_prepare() if the ebuild defines that hook.
cpm-cmake_cpm_prepare() {
	debug-print-function "${FUNCNAME}" "$@"

	mkdir -p "${WORKDIR}/cpm" || die
	cp "${DISTDIR}/CPM_${CPM_VERSION}.cmake" \
		"${WORKDIR}/cpm/CPM_${CPM_VERSION}.cmake" || die

	_CPM_DEFAULT_CALLED=1
}

# @FUNCTION: cpm-cmake_src_prepare
# @DESCRIPTION:
# Exported src_prepare. Calls cpm_prepare() if defined in the ebuild
# (it MUST call cpm-cmake_cpm_prepare), otherwise runs the default.
# Then calls cmake_src_prepare.
cpm-cmake_src_prepare() {
	debug-print-function "${FUNCNAME}" "$@"

	local _CPM_DEFAULT_CALLED

	if declare -f cpm_prepare >/dev/null; then
		cpm_prepare
	else
		cpm-cmake_cpm_prepare
	fi

	[[ ${_CPM_DEFAULT_CALLED} ]] ||
		die "QA: cpm_prepare() must call cpm-cmake_cpm_prepare"

	cmake_src_prepare
}

# @FUNCTION: cpm-cmake_src_configure
# @DESCRIPTION:
# Exported src_configure. Calls cpm_configure() if defined in the ebuild
# (append project-specific cmake args to mycmakeargs there), then appends
# the standard CPM args and per-package -DCPM_<name>_SOURCE entries, and
# finally calls cmake_src_configure.
cpm-cmake_src_configure() {
	debug-print-function "${FUNCNAME}" "$@"

	# Allow ebuild to populate project-specific args first.
	if declare -f cpm_configure >/dev/null; then
		cpm_configure
	fi

	# Standard CPM offline args.
	mycmakeargs+=(
		-DCPM_DOWNLOAD_ALL=OFF
		-DCPM_SOURCE_CACHE:STRING="${WORKDIR}"
	)

	# Per-package source overrides: bypass CPM's git clone.
	local _cpm_name _cpm_repo _cpm_ref _cpm_rn _cpm_pkg
	for _cpm_pkg in "${CPM_PACKAGES[@]}"; do
		read -r _cpm_name _cpm_repo _cpm_ref <<< "${_cpm_pkg}"
		_cpm_rn="${_cpm_repo##*/}"
		mycmakeargs+=( "-DCPM_${_cpm_name}_SOURCE=${WORKDIR}/${_cpm_rn}-${_cpm_ref}" )
	done

	cmake_src_configure
}

EXPORT_FUNCTIONS src_prepare src_configure
