# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

GITHUB_REPOSITORY="commixproject/commix"
inherit distutils-r1 github-archive

DESCRIPTION="Automated All-in-One OS command injection and exploitation tool"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#FIXME: remove --update option
