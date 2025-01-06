# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="python3 implementation for working with iDevices"
HOMEPAGE="https://github.com/doronz88/pymobiledevice3"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="test"

#	dev-python/fastapi[all][${PYTHON_USEDEP}]
#	dev-python/gnureadline[${PYTHON_USEDEP}]
RDEPEND="
	>=dev-python/construct-2.9.29[${PYTHON_USEDEP}]
	dev-python/asn1[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/coloredlogs[${PYTHON_USEDEP}]
	dev-python/ipython[${PYTHON_USEDEP}]
	>=dev-python/bpylist2-4.0.1[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/hexdump[${PYTHON_USEDEP}]
	dev-python/arrow[${PYTHON_USEDEP}]
	dev-python/daemonize[${PYTHON_USEDEP}]
	dev-python/gpxpy[${PYTHON_USEDEP}]
	>=dev-python/pykdebugparser-1.2.4[${PYTHON_USEDEP}]
	>=dev-python/pyusb-1.2.1[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/xonsh[${PYTHON_USEDEP}]
	dev-python/parameter-decorators[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	>=dev-python/pygnuutils-0.0.7[${PYTHON_USEDEP}]
	>=dev-python/cryptography-41.0.1[${PYTHON_USEDEP}]
	>=dev-python/pycrashreport-1.2.2[${PYTHON_USEDEP}]
	dev-python/fastapi[${PYTHON_USEDEP}]
	>=dev-python/uvicorn-0.15.0[${PYTHON_USEDEP}]
	dev-python/starlette[${PYTHON_USEDEP}]
	dev-python/wsproto[${PYTHON_USEDEP}]
	>=dev-python/nest-asyncio-1.5.5[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	>=dev-python/inquirer3-0.1.0[${PYTHON_USEDEP}]
	>=dev-python/pyimg4-0.8[${PYTHON_USEDEP}]
	>=dev-python/ipsw-parser-1.1.2[${PYTHON_USEDEP}]
	dev-python/remotezip2[${PYTHON_USEDEP}]
	dev-python/zeroconf[${PYTHON_USEDEP}]
	dev-python/ifaddr[${PYTHON_USEDEP}]
	dev-python/hyperframe[${PYTHON_USEDEP}]
	dev-python/srptools[${PYTHON_USEDEP}]
	>=dev-python/qh3-0.11.5[${PYTHON_USEDEP}]
	>=dev-python/developer_disk_image-0.0.2[${PYTHON_USEDEP}]
	dev-python/opack2[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	>=dev-python/pytun-pmd3-1.0.0[${PYTHON_USEDEP}]
	dev-python/aiofiles[${PYTHON_USEDEP}]
	dev-python/prompt-toolkit[${PYTHON_USEDEP}]
	dev-python/sslpsk-pmd3[${PYTHON_USEDEP}]
	dev-python/python-pcapng[${PYTHON_USEDEP}]
"
#	dev-python/sslpsk-pmd3>=1.0.3;python_version<'3.13'[${PYTHON_USEDEP}]

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#distutils_enable_tests pytest
