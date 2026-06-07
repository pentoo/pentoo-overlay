# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: github-snapshot.eclass
# @MAINTAINER: blshkv@pentoo.ch
# @SUPPORTED_EAPIS: 8
# @BLURB: Simplify ebuilds that fetch a specific GitHub commit snapshot as a tarball
# @DESCRIPTION:
# Handles SRC_URI, S, and HOMEPAGE for packages fetched from a GitHub
# commit snapshot (archive tarball) rather than a tagged release.
#
# Set the following variables before inheriting:
#   GITHUB_REPOSITORY  - "owner/repo"  (required)
#   GITHUB_COMMIT      - full 40-char commit SHA  (required)
#
# SRC_URI is appended to (so the ebuild may add distfiles before inheriting).
# S is always set to "${WORKDIR}/${GITHUB_PN}-${GITHUB_COMMIT}".
# HOMEPAGE defaults to "https://github.com/${GITHUB_REPOSITORY}" if unset.
#
# @EXAMPLE:
# @CODE
#   GITHUB_REPOSITORY="fortra/impacket"
#   GITHUB_COMMIT="a63c6522d694a73195e15958734df7de53b43c11"
#   inherit github-snapshot
# @CODE

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI} is not supported" ;;
esac

# @ECLASS_VARIABLE: GITHUB_REPOSITORY
# @REQUIRED
# @DESCRIPTION:
# GitHub repository in "owner/repo" format, e.g. "fortra/impacket".
# Must be set before inheriting.
[[ -z ${GITHUB_REPOSITORY} ]] &&
	die "${ECLASS}: GITHUB_REPOSITORY must be set before inheriting"

# @ECLASS_VARIABLE: GITHUB_COMMIT
# @REQUIRED
# @DESCRIPTION:
# Full 40-character commit SHA to fetch from GitHub.
# Must be set before inheriting.
[[ -z ${GITHUB_COMMIT} ]] &&
	die "${ECLASS}: GITHUB_COMMIT must be set before inheriting"

# @ECLASS_VARIABLE: GITHUB_USER
# @OUTPUT_VARIABLE
# @DESCRIPTION:
# Repository owner derived from GITHUB_REPOSITORY (part before the slash).
GITHUB_USER="${GITHUB_REPOSITORY%%/*}"

# @ECLASS_VARIABLE: GITHUB_PN
# @OUTPUT_VARIABLE
# @DESCRIPTION:
# Repository name derived from GITHUB_REPOSITORY (part after the slash).
# GitHub tarballs extract to "${GITHUB_PN}-${GITHUB_COMMIT}".
GITHUB_PN="${GITHUB_REPOSITORY##*/}"

# Set HOMEPAGE only when the ebuild has not provided one.
: "${HOMEPAGE:=https://github.com/${GITHUB_REPOSITORY}}"

# Append the commit tarball to SRC_URI so the ebuild can pre-populate it
# with additional distfiles (e.g. verify-sig signatures).
SRC_URI+="https://github.com/${GITHUB_REPOSITORY}/archive/${GITHUB_COMMIT}.tar.gz"
SRC_URI+=" -> ${P}.gh.tar.gz"

# GitHub always extracts as <repo>-<sha>, regardless of PN.
S="${WORKDIR}/${GITHUB_PN}-${GITHUB_COMMIT}"
