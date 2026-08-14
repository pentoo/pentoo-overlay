# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
PYPI_VERIFY_REPO=https://github.com/log2timeline/dfvfs

inherit distutils-r1 pypi

DESCRIPTION="Digital Forensics Virtual File System (dfVFS)"
HOMEPAGE="https://github.com/log2timeline/dfvfs"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=app-forensics/libbde-20220121[python]
	>=app-forensics/libewf-20131210
	>=app-forensics/libfsapfs-20220709[python]
	>=app-forensics/libfsext-20220829[python]
	>=app-forensics/libfsfat-20260717[python]
	>=app-forensics/libfshfs-20220831[python]
	>=app-forensics/libfsntfs-20211229[python]
	>=app-forensics/libfsxfs-20260702[python]
	>=app-forensics/libfvde-20220121[python]
	>=app-forensics/libluksde-20220121[python]
	>=app-forensics/libmodi-20210405[python]
	>=app-forensics/libphdi-20220228[python]
	>=app-forensics/libqcow-20201213[python]
	>=app-forensics/libsmraw-20140612[python]
	>=app-forensics/libvsgpt-20211115[python]
	>=app-forensics/libvshadow-20160109[python]
	>=app-forensics/libvslvm-20160109[python]
	>=app-forensics/pytsk-20260715
	>=dev-libs/libcaes-20240114[python]
	>=dev-libs/libfcrypto-20240114[python]
	>=dev-libs/libfwnt-20210717[python]
	>=dev-libs/libsigscan-20230109[python]
	>=dev-libs/libsmdev-20140529[python]
	>=dev-libs/libvhdi-20201014[python]
	>=dev-libs/libvmdk-20140421[python]
	>=dev-libs/libvsapm-20260713[python]
	>=dev-python/dfdatetime-20260730
	>=dev-python/dtfabric-20230518
	>=dev-python/pyxattr-0.7.2[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.10[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests unittest

python_test() {
	"${EPYTHON}" run_tests.py -v || die
}
