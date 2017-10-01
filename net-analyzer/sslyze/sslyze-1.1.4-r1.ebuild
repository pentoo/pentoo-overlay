# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1 versionator

DESCRIPTION="Fast and full-featured SSL scanner"
HOMEPAGE="https://github.com/nabla-c0d3/sslyze"
SRC_URI="https://github.com/nabla-c0d3/sslyze/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
#RDEPEND="=dev-python/nassl-$(get_version_component_range 1-2)*"
RDEPEND="=dev-python/nassl-0.17*
	dev-python/typing
	dev-python/enum34
	>=dev-python/cryptography-1.9 <=dev-python/cryptography-2.0.3
	=dev-python/tls_parser-1.1.0
"

#typing; python_version < '3.5'
#enum34; python_version < '3.4'
