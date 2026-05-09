# Copyright 1999-2026 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="Information gathering tool designed for extracting metadata of public documents"
HOMEPAGE="https://github.com/enjoy-digital/litex"
SRC_URI="https://github.com/enjoy-digital/litex/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

IUSE=test
RESTRICT="!test? ( test )"

RDEPEND="
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pyserial[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	sci-electronics/migen[${PYTHON_USEDEP}]
"

BDEPEND="
	test? (
		dev-python/pexpect[${PYTHON_USEDEP}]
	)
"

#FIXME: required packages:
#litedram
#liteeth
#liteiclink
#litejesd204b
#litepcie
#litesata
#litescope
#litesdcard
#litespi
#litex-boards
#pythondata-cpu-lm32
#pythondata-cpu-mor1kx
#pythondata-cpu-naxriscv
#pythondata-cpu-serv
#pythondata-cpu-vexriscv
#pythondata-cpu-vexriscv-smp
#pythondata-misc-tapcfg
#pythondata-misc-usb_ohci
#pythondata-software-compiler_rt
#pythondata-software-picolibc
#valentyusb

distutils_enable_tests pytest

# tests can't be done due to some breaking changes with python 3.14
# https://github.com/enjoy-digital/litex/issues/2399
EPYTEST_DESELECT=(
	test/test_csr.py::TestCSR::test_csr_constant
	test/test_csr.py::TestCSR::test_csr_fields
	test/test_csr.py::TestCSR::test_csr_status
	test/test_csr.py::TestCSR::test_csr_storage
	test/test_i2c.py::TestI2C::test_i2c
	test/test_i2s.py::TestI2S::test_s7i2sslave_syntax
	test/test_icap.py::TestICAP::test_icap_bitstream_syntax
	test/test_spi.py::TestSPI::test_spi_master_syntax
	test/test_spi_mmap.py::TestSPIMMAP::test_spi_mmap_16_lsb
	test/test_spi_mmap.py::TestSPIMMAP::test_spi_mmap_16_lsb_wb32
	test/test_spi_mmap.py::TestSPIMMAP::test_spi_mmap_16_msb
	test/test_spi_mmap.py::TestSPIMMAP::test_spi_mmap_16_msb_wb32
	test/test_spi_mmap.py::TestSPIMMAP::test_spi_mmap_24_lsb
	test/test_spi_mmap.py::TestSPIMMAP::test_spi_mmap_24_msb
	test/test_spi_mmap.py::TestSPIMMAP::test_spi_mmap_24_slot0_1_lsb
	test/test_spi_mmap.py::TestSPIMMAP::test_spi_mmap_24_slot0_1_msb
	test/test_spi_mmap.py::TestSPIMMAP::test_spi_mmap_32_lsb
	test/test_spi_mmap.py::TestSPIMMAP::test_spi_mmap_32_msb
	test/test_spi_mmap.py::TestSPIMMAP::test_spi_mmap_32_slot0_1_lsb
	test/test_spi_mmap.py::TestSPIMMAP::test_spi_mmap_32_slot0_1_msb
	test/test_spi_mmap.py::TestSPIMMAP::test_spi_mmap_8_lsb
	test/test_spi_mmap.py::TestSPIMMAP::test_spi_mmap_8_msb
	test/test_spi_mmap.py::TestSPIMMAP::test_spi_mmap_8_msb_wait1
	test/test_spi_mmap.py::TestSPIMMAP::test_spi_mmap_8_msb_wait8
	test/test_spi_opi.py::TestI2S::test_s7spiopi_syntax
	test/test_timer.py::TestTimer::test_one_shot_software_polling
	test/test_timer.py::TestTimer::test_one_shot_timer_interrupts
	test/test_timer.py::TestTimer::test_periodic_timer_software_polling

	# the following tests are broken due to migen
	# https://git.m-labs.hk/M-Labs/migen/issues/2
	test/test_hyperbus.py::TestHyperRAM::test_hyperram_read_latency_5_2x
	test/test_hyperbus.py::TestHyperRAM::test_hyperram_read_latency_6_2x
	test/test_hyperbus.py::TestHyperRAM::test_hyperram_read_latency_7_1x
	test/test_hyperbus.py::TestHyperRAM::test_hyperram_read_latency_7_2x
	test/test_hyperbus.py::TestHyperRAM::test_hyperram_reg_write
	test/test_hyperbus.py::TestHyperRAM::test_hyperram_syntax
	test/test_hyperbus.py::TestHyperRAM::test_hyperram_write_latency_5_2x
	test/test_hyperbus.py::TestHyperRAM::test_hyperram_write_latency_5_2x_sys2x
	test/test_hyperbus.py::TestHyperRAM::test_hyperram_write_latency_6_2x
	test/test_hyperbus.py::TestHyperRAM::test_hyperram_write_latency_7_1x
	test/test_hyperbus.py::TestHyperRAM::test_hyperram_write_latency_7_2x
	test/test_icap.py::TestICAP::test_icap_command_reload
	test/test_integration.py::test_cpu
	test/test_integration.py::test_buses
)
