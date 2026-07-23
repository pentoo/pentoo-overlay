# Copyright 2024-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="upload firmware via the serial boot loader onto the CC13xx, CC2538 and CC26xx"
HOMEPAGE="https://github.com/JelmerT/cc2538-bsl"
if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/JelmerT/cc2538-bsl.git"
else
	inherit vcs-snapshot
	GIT_COMMIT="28cce9749bfb73c50363ded01bd8001b1639d9fb"
	SRC_URI="https://github.com/JelmerT/cc2538-bsl/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	#S="${PN}-${GIT_COMMIT}"
	KEYWORDS="amd64"
fi

LICENSE="BSD"
SLOT="0"

RDEPEND="
	dev-python/intelhex
	dev-python/python-magic
"
BDEPEND="dev-python/setuptools-scm
		test? ( dev-python/scripttest )"

#https://github.com/JelmerT/cc2538-bsl/issues/200
RESTRICT=test

distutils_enable_tests pytest

src_compile() {
	if [ "${PV}" = "9999" ]; then
		distutils-r1_src_compile
	else
		SETUPTOOLS_SCM_PRETEND_VERSION="2.1.20260708" distutils-r1_src_compile
	fi
}
