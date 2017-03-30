# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit autotools linux-info
#FIXME: migrate to new python eclass
# python

DESCRIPTION="Layer3 attacking tool"
HOMEPAGE="https://www.ernw.de/research/loki.html http://c0decafe.de"
SRC_URI="http://c0decafe.de/loki/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
#KEYWORDS="~x86 ~amd64"
IUSE="gnome"

DEPEND="dev-python/pygtk
	dev-python/ipy
	dev-python/dpkt
	dev-python/pylibpcap
	dev-libs/libdnet[python]
	dev-libs/libdnet
	gnome? ( gnome-base/libglade )"
RDEPEND="${DEPEND}"

CONFIG_CHECK="~TCP_MD5SIG ~NETFILTER ~IP_NF_FILTER ~IP_NF_TARGET_REJECT"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup

	linux-info_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dosym "/usr/bin/${PN}.py" "/usr/sbin/${PN}"
}
