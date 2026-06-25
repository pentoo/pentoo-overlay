# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: github-archive.eclass
# @MAINTAINER: blshkv@pentoo.ch
# @SUPPORTED_EAPIS: 8
# @BLURB: Simplify ebuilds that fetch GitHub commit snapshots or tagged releases
# @DESCRIPTION:
# Handles SRC_URI, S, and HOMEPAGE for packages fetched from GitHub.
# Supports three modes, selected by which variables are set before inheriting:
#
#   Commit snapshot  -- set GITHUB_COMMIT to a full 40-char SHA
#   Explicit tag     -- set GITHUB_TAG to the exact tag name (e.g. "v1.2.3")
#   Auto tag from PV -- set neither; tag is derived as
#                       "${GITHUB_TAG_PREFIX}${PV//_/-}" (prefix defaults to "v")
#
# GITHUB_REPOSITORY is always required.
# GITHUB_COMMIT and GITHUB_TAG are mutually exclusive.
#
# SRC_URI is appended to (so the ebuild may add distfiles before inheriting).
# HOMEPAGE defaults to "https://github.com/${GITHUB_REPOSITORY}" if unset.
# S is set automatically and need not be repeated in the ebuild.
#
# @EXAMPLE: Commit snapshot
# @CODE
#   GITHUB_REPOSITORY="rizinorg/cutter"
#   GITHUB_COMMIT="12c119fa857ba62ad3d4c23e6a413a8100961a69"
#   inherit cmake github-archive
# @CODE
#
# @EXAMPLE: Tagged release (explicit tag)
# @CODE
#   GITHUB_REPOSITORY="owner/repo"
#   GITHUB_TAG="v4.0.0-beta1"
#   inherit cmake github-archive
# @CODE
#
# @EXAMPLE: Tagged release (auto-derived from PV)
# @CODE
#   # For PV="4.0.0_beta1", derives GITHUB_TAG="v4.0.0-beta1"
#   GITHUB_REPOSITORY="redasm-dev/commands"
#   inherit cmake github-archive
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
# @DEFAULT_UNSET
# @DESCRIPTION:
# Full 40-character commit SHA to fetch from GitHub.
# Mutually exclusive with GITHUB_TAG.

# @ECLASS_VARIABLE: GITHUB_TAG
# @DEFAULT_UNSET
# @DESCRIPTION:
# Exact tag name to fetch, e.g. "v1.2.3" or "release-1.2.3".
# Mutually exclusive with GITHUB_COMMIT.
# When unset and GITHUB_COMMIT is also unset, the tag is auto-derived from PV.

# @ECLASS_VARIABLE: GITHUB_TAG_PREFIX
# @DEFAULT_UNSET
# @DESCRIPTION:
# Prefix prepended to PV when auto-deriving GITHUB_TAG (default: "v").
# Only used when neither GITHUB_COMMIT nor GITHUB_TAG is set.
# Example: with GITHUB_TAG_PREFIX="release-" and PV="1.2.3",
# the derived tag is "release-1.2.3".

[[ -n ${GITHUB_COMMIT} && -n ${GITHUB_TAG} ]] &&
	die "${ECLASS}: GITHUB_COMMIT and GITHUB_TAG are mutually exclusive"

# @ECLASS_VARIABLE: GITHUB_USER
# @OUTPUT_VARIABLE
# @DESCRIPTION:
# Repository owner derived from GITHUB_REPOSITORY (part before the slash).
GITHUB_USER="${GITHUB_REPOSITORY%%/*}"

# @ECLASS_VARIABLE: GITHUB_PN
# @OUTPUT_VARIABLE
# @DESCRIPTION:
# Repository name derived from GITHUB_REPOSITORY (part after the slash).
GITHUB_PN="${GITHUB_REPOSITORY##*/}"

: "${HOMEPAGE:=https://github.com/${GITHUB_REPOSITORY}}"

if [[ -n ${GITHUB_COMMIT} ]]; then
	# Commit snapshot: .../archive/<sha>.tar.gz → extracts to <repo>-<sha>/
	SRC_URI+="https://github.com/${GITHUB_REPOSITORY}/archive/${GITHUB_COMMIT}.tar.gz"
	SRC_URI+=" -> ${P}.gh.tar.gz"
	S="${WORKDIR}/${GITHUB_PN}-${GITHUB_COMMIT}"
else
	# Tagged release (explicit tag or auto-derived from PV)
	if [[ -z ${GITHUB_TAG} ]]; then
		: "${GITHUB_TAG_PREFIX:=v}"
		GITHUB_TAG="${GITHUB_TAG_PREFIX}${PV//_/-}"
	fi
	# GitHub strips a leading "v" from the tag when naming the extracted dir,
	# e.g. tag "v4.0.0-beta1" extracts as "commands-4.0.0-beta1".
	SRC_URI+="https://github.com/${GITHUB_REPOSITORY}/archive/refs/tags/${GITHUB_TAG}.tar.gz"
	SRC_URI+=" -> ${P}.gh.tar.gz"
	S="${WORKDIR}/${GITHUB_PN}-${GITHUB_TAG#v}"
fi
