# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_14 )
PYPI_VERIFY_REPO=https://github.com/doronz88/pymobiledevice3

inherit distutils-r1 pypi

DESCRIPTION="python3 implementation for working with iDevices"
HOMEPAGE="https://github.com/doronz88/pymobiledevice3"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

# need asn1 >= 2 < 3 due to pyimg4
RDEPEND="
	>=dev-python/apple-symbols-0.0.2[${PYTHON_USEDEP}]
	<dev-python/asn1-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/asn1-2.0.0[${PYTHON_USEDEP}]
	dev-python/ipython[${PYTHON_USEDEP}]
	>=dev-python/bpylist2-4.0.1[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/daemonize[${PYTHON_USEDEP}]
	>=dev-python/pykdebugparser-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/rich-13.0.0[${PYTHON_USEDEP}]
	>=dev-python/ansilogs-1.2.0[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.1.0[${PYTHON_USEDEP}]
	>=dev-python/pygnuutils-0.0.7[${PYTHON_USEDEP}]
	>=dev-python/cryptography-43.0.0[${PYTHON_USEDEP}]
	>=dev-python/pycrashreport-2.5.0[${PYTHON_USEDEP}]
	>=dev-python/fastapi-0.93.0[${PYTHON_USEDEP}]
	>=dev-python/uvicorn-0.15.0[${PYTHON_USEDEP}]
	dev-python/wsproto[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	>=dev-python/questionary-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/ipsw-parser-1.9.2[${PYTHON_USEDEP}]
	dev-python/ifaddr[${PYTHON_USEDEP}]
	dev-python/hyperframe[${PYTHON_USEDEP}]
	>=dev-python/qh3-1.0.0[${PYTHON_USEDEP}]
	<dev-python/qh3-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/developer-disk-image-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/opack2-0.2.0[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	>=dev-python/pytun-pmd3-3.0.3[${PYTHON_USEDEP}]
	dev-python/prompt-toolkit[${PYTHON_USEDEP}]
	>=dev-python/python-pcapng-2.1.1[${PYTHON_USEDEP}]
	>=dev-python/pyimg4-0.8.8[${PYTHON_USEDEP}]
	>=dev-python/pyiosbackup-0.2.4[${PYTHON_USEDEP}]
	>=dev-python/typer-0.25.0[${PYTHON_USEDEP}]
	>=dev-python/typer-injector-0.3.0[${PYTHON_USEDEP}]
	dev-python/defusedxml[${PYTHON_USEDEP}]
	>=dev-python/bytestruct-0.1.0[${PYTHON_USEDEP}]
	>=dev-python/av-14.0.0[${PYTHON_USEDEP}]
	>=dev-python/pmd-pytcp-0.3.9[${PYTHON_USEDEP}]
	dev-python/pmd-net-addr[${PYTHON_USEDEP}]
	>=dev-python/asgi-webdav-2.0.1[${PYTHON_USEDEP}]
"

BDEPEND="
	${RDEPEND}
	test? (
		dev-python/httpx[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-asyncio )
EPYTEST_DESELECT=(
	# need an usb connection
	'tests/services/test_afc_shell.py::test_create_runs_a_shell_until_exit'
	# to be investigated
	'tests/test_socket_hygiene.py::test_a_leak_is_reported_once_by_whoever_opened_it'
)
distutils_enable_tests pytest
