# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv $

EAPI=5

PYTHON_COMPAT=( python2_{6,7} )
inherit git-2 python-r1

DESCRIPTION="Bypass NAC by hijacking non-802.1x configurable hosts"
HOMEPAGE="https://github.com/carmaa/nacker"
EGIT_REPO_URI="https://github.com/carmaa/nacker.git"
EGIT_COMMIT="92704f857e128ff5c548ff664f4106cc91f25426"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/netifaces
	net-analyzer/scapy"

src_install() {
	dodoc README.md
	rm README.md LICENSE
	dodir /usr/$(get_libdir)/${PN}
	cp -R "${S}"/* "${D}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	dosbin "${FILESDIR}"/"${PN}"
}
