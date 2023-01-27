# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Digital Forensics Virtual File System (dfVFS)"
HOMEPAGE="https://github.com/log2timeline/dfvfs"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

DEPEND="
	>=dev-python/pip-7.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.10[${PYTHON_USEDEP}]
	>=dev-python/cffi-1.9.1
	>=dev-python/cryptography-2.0.2
	>=dev-python/dfdatetime-20220816
	>=dev-python/dtfabric-20220219
	>=app-forensics/libbde-20220121[python]
	>=app-forensics/libewf-20131210
	>=app-forensics/libfsapfs-20220709[python]
	>=app-forensics/libfsext-20220829[python]
	>=app-forensics/libfsfat-20220925[python]
	>=app-forensics/libfshfs-20220831[python]
	>=app-forensics/libfsntfs-20211229[python]
	>=app-forensics/libfsxfs-20220829[python]
	>=app-forensics/libfvde-20220121[python]
	>=dev-libs/libfwnt-20210717[python]
	>=app-forensics/libluksde-20220121[python]
	>=app-forensics/libmodi-20210405[python]
	>=app-forensics/libphdi-20220228[python]
	>=app-forensics/libqcow-20201213[python]
	>=dev-libs/libsigscan-20191221[python]
	>=dev-libs/libsmdev-20140529[python]
	>=app-forensics/libsmraw-20140612[python]
	>=dev-libs/libvhdi-20201014[python]
	>=dev-libs/libvmdk-20140421[python]
	>=app-forensics/libvsgpt-20211115[python]
	>=app-forensics/libvshadow-20160109[python]
	>=app-forensics/libvslvm-20160109[python]
	>=app-forensics/pytsk-20210419
	>=dev-python/pyxattr-0.7.2[${PYTHON_USEDEP}]
	${PYTHON_DEPS}
	test? (
		>=dev-python/mock-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/pbr-4.2.0[${PYTHON_USEDEP}]
		>=dev-python/six-1.1.0[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"

python_test() {
	"${EPYTHON}" run_tests.py -v || die
}

python_install_all() {
	distutils-r1_python_install_all

	# move some documentation files to the canonical target path	
	mv "${ED}"/usr/share/doc/"${PN}"/* "${ED}"/usr/share/doc/"${PF}"/ || die
	rmdir "${ED}"/usr/share/doc/"${PN}" || die
}
