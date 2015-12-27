# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1 multilib

DESCRIPTION="A swiss army knife for pentesting Windows/Active Directory environments"
HOMEPAGE="https://github.com/byt3bl33d3r/CrackMapExec/releases"
SRC_URI="https://github.com/byt3bl33d3r/CrackMapExec/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
SLOT="0"

RDEPEND=">dev-python/impacket-0.9.13
	dev-python/gevent
	dev-python/netaddr
	dev-python/pycrypto
	dev-python/pyasn1
	dev-python/termcolor
	dev-python/colorama"

S="${WORKDIR}/CrackMapExec-${PV}"

src_install() {
	dodir /usr/$(get_libdir)/${PN}
	cp -pPR "${S}"/* "${ED}"/usr/$(get_libdir)/"${PN}" || die

#	python_fix_shebang "${ED}"/usr/$(get_libdir)/${PN}
	dosym /usr/$(get_libdir)/${PN}/${PN}.py /usr/sbin/${PN}
}
