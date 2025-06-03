# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

#pypi: use github for now, as it switched from Cryptodome (pycryptodomex) -> Crypto (pycryptodome)
DESCRIPTION="A collection of Python classes focused on providing access to network packets"
HOMEPAGE="https://github.com/fortra/impacket"

#if [[ ${PV} == *9999 ]]; then
#	inherit git-r3
#	EGIT_REPO_URI="https://github.com/fortra/impacket"
#else
#SRC_URI="https://github.com/fortra/impacket/archive/impacket_${PV//./_}.tar.gz -> ${P}.tar.gz"

HASH_COMMIT="a63c6522d694a73195e15958734df7de53b43c11"
SRC_URI="https://github.com/fortra/impacket/archive/${HASH_COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${HASH_COMMIT}"

#fi

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="examples"

RDEPEND="
	>dev-python/ldap3-2.6.0[${PYTHON_USEDEP}]
	>=dev-python/flask-1.0[${PYTHON_USEDEP}]
	>=dev-python/ldapdomaindump-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.2.3[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-0.16.2[${PYTHON_USEDEP}]
	dev-python/charset-normalizer[${PYTHON_USEDEP}]
	dev-python/pyasn1-modules[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
"

# use a local server
EPYTEST_DESELECT=(
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServerFuncTests::test_smbserver_connect_disconnect_tree'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServerFuncTests::test_smbserver_create_directory'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServerFuncTests::test_smbserver_delete_file'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServerFuncTests::test_smbserver_get_file'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServerFuncTests::test_smbserver_get_unicode_file'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServerFuncTests::test_smbserver_list_path'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServerFuncTests::test_smbserver_list_shares'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServerFuncTests::test_smbserver_login_invalid'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServerFuncTests::test_smbserver_login_valid'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServerFuncTests::test_smbserver_open_close_file'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServerFuncTests::test_smbserver_put'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServerFuncTests::test_smbserver_query_info_file'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServerFuncTests::test_smbserver_rename_file'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServerFuncTests::test_smbserver_unicode_login'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTestsClientFallBack::test_smbserver_connect_disconnect_tree'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTestsClientFallBack::test_smbserver_create_directory'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTestsClientFallBack::test_smbserver_delete_file'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTestsClientFallBack::test_smbserver_get_file'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTestsClientFallBack::test_smbserver_get_unicode_file'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTestsClientFallBack::test_smbserver_list_path'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTestsClientFallBack::test_smbserver_list_shares'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTestsClientFallBack::test_smbserver_login_invalid'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTestsClientFallBack::test_smbserver_login_valid'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTestsClientFallBack::test_smbserver_open_close_file'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTestsClientFallBack::test_smbserver_put'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTestsClientFallBack::test_smbserver_query_info_file'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTestsClientFallBack::test_smbserver_rename_file'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTestsClientFallBack::test_smbserver_unicode_login'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTests::test_smbserver_connect_disconnect_tree'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTests::test_smbserver_create_directory'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTests::test_smbserver_delete_directory'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTests::test_smbserver_delete_file'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTests::test_smbserver_get_file'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTests::test_smbserver_get_unicode_file'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTests::test_smbserver_list_path'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTests::test_smbserver_list_shares'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTests::test_smbserver_login_invalid'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTests::test_smbserver_login_valid'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTests::test_smbserver_open_close_file'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTests::test_smbserver_put'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTests::test_smbserver_query_info_file'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTests::test_smbserver_rename_file'
	'tests/SMB_RPC/test_smbserver.py::SimpleSMBServer2FuncTests::test_smbserver_unicode_login'
)

distutils_enable_tests pytest

python_prepare_all() {
	# do not install data files under Gentoo
	sed -i -e 's|Darwin|Linux|' setup.py || die
	#use pycryptodome instead of pycryptodomex
	#the only thing different appears to be the namespace and gentoo is removing pycryptodomex
	sed -i -e 's#Cryptodome#Crypto#' $(grep -r --color=never 'Cryptodome' | awk -F':' '{print $1}') || die
	distutils-r1_python_prepare_all
}

python_install_all() {
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi

	distutils-r1_python_install_all
}

python_test() {
	epytest -m 'not remote'
}
