# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit autotools python-single-r1

DESCRIPTION="A simple C language RPC framework"
HOMEPAGE="https://github.com/haiwen/libsearpc/ http://seafile.com/"

HASH_COMMIT="c161cb90a5cb494947b1bda63f8664619dd3ca94" # 20190712
SRC_URI="https://github.com/haiwen/libsearpc/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
	dev-libs/jansson"

RDEPEND="${DEPEND}
	dev-python/simplejson[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

src_prepare() {
	sed -e "s/(DESTDIR)//" \
		-i ${PN}.pc.in || die

	python_fix_shebang "${S}"

	eautoreconf
	default
}

src_install() {
	default

	# Remove unnecessary .la files, as recommended by ltprune.eclass
	find "${ED}" -name '*.la' -delete || die
}
