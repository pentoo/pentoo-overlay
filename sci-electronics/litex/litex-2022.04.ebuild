# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )
inherit distutils-r1


DESCRIPTION="Information gathering tool designed for extracting metadata of public documents"
HOMEPAGE="https://github.com/enjoy-digital/litex"
SRC_URI="https://github.com/enjoy-digital/litex/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
#FIXME, bump all deps
#KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

RESTRICT="test"

RDEPEND="dev-python/pyserial[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

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
#litex
#litex-boards
#migen
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
