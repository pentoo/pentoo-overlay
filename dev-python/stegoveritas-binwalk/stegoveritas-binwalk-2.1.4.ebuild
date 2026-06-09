# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Binwalk release specifically for stegoveritas"
HOMEPAGE="https://pypi.org/project/stegoveritas-binwalk/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~amd64 ~x86"

IUSE="graph"

RDEPEND="
	!!app-misc/binwalk
	graph? ( dev-python/pyqtgraph[opengl,${PYTHON_USEDEP}] )"

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog "binwalk has many optional dependencies to automatically"
		elog "extract/decompress data, see INSTALL.md for more details."
	fi
}
