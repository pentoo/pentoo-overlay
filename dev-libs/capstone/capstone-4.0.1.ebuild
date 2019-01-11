# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="disassembly/disassembler framework + bindings"
HOMEPAGE="http://www.capstone-engine.org/"
SRC_URI="https://github.com/aquynh/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/4" # libcapstone.so.4
KEYWORDS="~amd64 ~arm ~x86"
IUSE="python"

PDEPEND="python? ( >=dev-python/capstone-python-${PV} )"
RDEPEND=""
DEPEND="${RDEPEND}"
#TODO: add java and ocaml bindings
