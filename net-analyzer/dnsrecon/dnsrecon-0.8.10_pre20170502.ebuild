# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4} )
inherit multilib python-r1 git-r3

HOMEPAGE="https://github.com/darkoperator/dnsrecon"
DESCRIPTION="DNS Enumeration Script"
#SRC_URI="https://github.com/darkoperator/dnsrecon/archive/v${PV}.tar.gz -> ${P}.tar.gz"
EGIT_REPO_URI="https://github.com/darkoperator/dnsrecon.git"
EGIT_COMMIT="c96739859cc25177df0a9a3a3b7bdcfe62d87394"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	virtual/python-dnspython[${PYTHON_USEDEP}]
	dev-python/netaddr"
DEPEND="${RDEPEND}"

src_install() {
	# should be as simple as copying everything into the target...
	dodir /usr/$(get_libdir)/${PN}
	cp -R "${S}"/* "${D}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	dosym  /usr/$(get_libdir)/${PN}/${PN}.py /usr/bin/${PN}
}
