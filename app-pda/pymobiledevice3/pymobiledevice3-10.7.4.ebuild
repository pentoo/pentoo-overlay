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

# need asn1 >= 2 < 3 due to pyimg4
RDEPEND="
	>=dev-python/construct-2.9.29[${PYTHON_USEDEP}]
	>=dev-python/construct-typing-0.8.0[${PYTHON_USEDEP}]
	<dev-python/asn1-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/asn1-2.0.0[${PYTHON_USEDEP}]
	dev-python/coloredlogs[${PYTHON_USEDEP}]
	dev-python/ipython[${PYTHON_USEDEP}]
	>=dev-python/bpylist2-4.0.1[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/hexdump[${PYTHON_USEDEP}]
	dev-python/daemonize[${PYTHON_USEDEP}]
	<dev-python/gpxpy-1.7.0[${PYTHON_USEDEP}]
	>=dev-python/pykdebugparser-1.2.7[${PYTHON_USEDEP}]
	>=dev-python/pyusb-1.2.1[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/xonsh[${PYTHON_USEDEP}]
	dev-python/parameter-decorators[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.1.0[${PYTHON_USEDEP}]
	>=dev-python/pygnuutils-0.0.7[${PYTHON_USEDEP}]
	>=dev-python/cryptography-41.0.1[${PYTHON_USEDEP}]
	>=dev-python/pycrashreport-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/fastapi-0.93.0[${PYTHON_USEDEP}]
	>=dev-python/uvicorn-0.15.0[${PYTHON_USEDEP}]
	dev-python/wsproto[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	>=dev-python/questionary-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/ipsw-parser-1.6.0[${PYTHON_USEDEP}]
	dev-python/ifaddr[${PYTHON_USEDEP}]
	dev-python/hyperframe[${PYTHON_USEDEP}]
	dev-python/srptools[${PYTHON_USEDEP}]
	>=dev-python/qh3-1.0.0[${PYTHON_USEDEP}]
	<dev-python/qh3-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/developer-disk-image-0.3.0[${PYTHON_USEDEP}]
	dev-python/opack2[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	>=dev-python/pytun-pmd3-3.0.3[${PYTHON_USEDEP}]
	dev-python/prompt-toolkit[${PYTHON_USEDEP}]
	>=dev-python/python-pcapng-2.1.1[${PYTHON_USEDEP}]
	dev-python/plumbum[${PYTHON_USEDEP}]
	>=dev-python/pyimg4-0.8.8[${PYTHON_USEDEP}]
	>=dev-python/pyiosbackup-0.2.4[${PYTHON_USEDEP}]
	>=dev-python/typer-0.25.0[${PYTHON_USEDEP}]
	>=dev-python/typer-injector-0.2.0[${PYTHON_USEDEP}]
	dev-python/defusedxml[${PYTHON_USEDEP}]
	>=dev-python/av-14.0.0[${PYTHON_USEDEP}]
	>=dev-python/pmd-pytcp-0.3.7[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=(
	pytest-asyncio
)
distutils_enable_tests pytest
