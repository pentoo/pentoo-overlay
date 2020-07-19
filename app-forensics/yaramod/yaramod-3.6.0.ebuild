# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Parsing of YARA rules into AST and building new rulesets in C++"
HOMEPAGE="https://github.com/avast/yaramod"
SRC_URI="https://github.com/avast/yaramod/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
#FIXME: python bindings
#IUSE="python"

DEPEND="dev-libs/openssl:0="
RDEPEND="${DEPEND}"

CMAKE_MAKEFILE_GENERATOR="emake"
