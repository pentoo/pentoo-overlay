# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_14 )

inherit distutils-r1 pypi

DESCRIPTION="python3 implementation for working with iDevices"
HOMEPAGE="https://github.com/doronz88/pymobiledevice3"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

# need asn1 >= 2 < 3 due to pyimg4
RDEPEND="
	>=dev-python/construct-2.9.29[${PYTHON_USEDEP}]
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
	>=dev-python/pygnuutils-0.0.7[${PYTHON_USEDEP}]
	>=dev-python/cryptography-41.0.1[${PYTHON_USEDEP}]
	>=dev-python/pycrashreport-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/fastapi-0.93.0[${PYTHON_USEDEP}]
	>=dev-python/uvicorn-0.15.0[${PYTHON_USEDEP}]
	dev-python/wsproto[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	>=dev-python/inquirer3-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/ipsw-parser-1.6.0[${PYTHON_USEDEP}]
	dev-python/ifaddr[${PYTHON_USEDEP}]
	dev-python/hyperframe[${PYTHON_USEDEP}]
	dev-python/srptools[${PYTHON_USEDEP}]
	>=dev-python/qh3-1.0.0[${PYTHON_USEDEP}]
	<dev-python/qh3-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/developer-disk-image-0.0.2[${PYTHON_USEDEP}]
	dev-python/opack2[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	>=dev-python/pytun-pmd3-3.0.3[${PYTHON_USEDEP}]
	dev-python/prompt-toolkit[${PYTHON_USEDEP}]
	>=dev-python/python-pcapng-2.1.1[${PYTHON_USEDEP}]
	dev-python/plumbum[${PYTHON_USEDEP}]
	>=dev-python/pyimg4-0.8.8[${PYTHON_USEDEP}]
	>=dev-python/typer-0.25.0[${PYTHON_USEDEP}]
	dev-python/defusedxml[${PYTHON_USEDEP}]
	>=dev-python/av-14.0.0[${PYTHON_USEDEP}]
	>=dev-python/construct-typing-0.8.0[${PYTHON_USEDEP}]
	>=dev-python/typer-injector-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/pyiosbackup-0.2.4[${PYTHON_USEDEP}]
	<=dev-python/gpxpy-1.7.0[${PYTHON_USEDEP}]
	dev-python/pmd-pytcp[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=(
	pytest-asyncio
)

# need to run a script to generate files
EPYTEST_IGNORE=(
	tests/cli/developer/dvt/sysmon/test_process.py
	tests/services/instruments/test_dtx_open_channel.py
	tests/services/instruments/test_dvt_provider.py
	tests/services/instruments/test_fetch_symbols.py
	tests/services/instruments/test_location.py
	tests/services/instruments/test_screenshot.py
	tests/services/test_accessibility.py
	tests/services/test_afc.py
	tests/services/test_apps.py
	tests/services/test_bonjour.py
	tests/services/test_crash_reports.py
	tests/services/test_house_arrest.py
	tests/services/test_list_devices.py
	tests/services/test_lockdown.py
	tests/services/test_pcapd.py
	tests/services/test_springboard_services_relay.py
	tests/services/test_syslog_relay.py
	tests/services/test_web_protocol/test_driver.py
	tests/services/test_web_protocol/test_element.py
	tests/services/test_webinspector.py
)
EPYTEST_DESELECT=(
	'tests/services/instruments/test_core_profile_session.py::test_stackshot'
	'tests/services/test_backup2.py::test_backup'
	'tests/services/test_backup2.py::test_encrypted_backup'
	'tests/cli/test_backup_cli.py::test_backup_full_help_describes_conditional_default'
	'tests/services/test_tcp_forwarder.py::test_tcp_forwarder_bad_port[3582]'
	'tests/services/test_tcp_forwarder.py::test_tcp_forwarder_bad_port[62078]'
)
distutils_enable_tests pytest
