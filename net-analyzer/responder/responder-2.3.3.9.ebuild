# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
inherit python-single-r1

DESCRIPTION="LLMNR, NBT-NS and MDNS poisoner, HTTP/SMB/MSSQL/FTP/LDAP rogue authentication"
HOMEPAGE="https://github.com/lgandx/Responder"
SRC_URI="https://github.com/lgandx/Responder/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/Responder-${PV}"

src_install() {
	dodir /usr/$(get_libdir)/${PN}
	cp -R * "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"

	python_fix_shebang "${ED}"/usr/$(get_libdir)/${PN}

#	dosym "${EPREFIX}"/usr/$(get_libdir)/${PN}/Responder.py /usr/sbin/responder
	dosym "${EPREFIX}"/usr/$(get_libdir)/${PN}/Report.py /usr/bin/responder_report
	dosym "${EPREFIX}"/usr/$(get_libdir)/${PN}/DumpHash.py /usr/bin/responder_dumphash

	newsbin - responder <<-EOF
	#!/bin/sh
	cd /usr/lib/responder
	python2 ./Responder.py \${@}
	EOF
}
