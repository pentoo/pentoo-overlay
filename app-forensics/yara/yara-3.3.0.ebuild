# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools

DESCRIPTION="A malware identification and classification tool"
HOMEPAGE="http://plusvic.github.io/yara/"
SRC_URI="https://github.com/plusvic/yara/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python"

PDEPEND="python? ( ~dev-python/yara-python-${PV} )"

src_prepare() {
	eautoreconf
}
