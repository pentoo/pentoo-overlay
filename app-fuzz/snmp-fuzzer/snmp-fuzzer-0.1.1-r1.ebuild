# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A very complete snmp fuzzer"
HOMEPAGE="http://www.arhont.com/"
SRC_URI="http://arhont.beta.indev-group.eu/media/filer_public/63/95/6395a38c-4cf2-44e0-9b64-81ff61d97b4c/snmp-fuzzer-011tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

src_compile () {
	einfo "Nothing to compile"
}

src_install () {
	dodoc README.txt TODO CHANGELOG.txt
	rm README.txt TODO CHANGELOG.txt LICENSE.TXT
	insinto /opt/snmp-fuzzer/
	doins -r *
	dosbin "${FILESDIR}"/snmp-fuzzer
}
