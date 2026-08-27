# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
PYTHON_REQ_USE="sqlite"

inherit python-single-r1

DESCRIPTION="LLMNR, NBT-NS and MDNS poisoner, HTTP/SMB/MSSQL/FTP/LDAP rogue authentication"
HOMEPAGE="https://github.com/lgandx/Responder"
SRC_URI="https://github.com/lgandx/Responder/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/Responder-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/aioquic[${PYTHON_USEDEP}]
		>=dev-python/netifaces-0.10.4[${PYTHON_USEDEP}]
	')"
RDEPEND="${DEPEND}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	default
	python_fix_shebang "${S}"
}

src_install() {
	dodir /usr/$(get_libdir)/${PN}
	cp -R * "${ED}"/usr/$(get_libdir)/${PN} || die "Copy files failed"

#	dosym "${EPREFIX}"/usr/$(get_libdir)/${PN}/Responder.py /usr/sbin/responder
	dosym -r "${EPREFIX}"/usr/$(get_libdir)/${PN}/Report.py /usr/bin/responder_report
	dosym -r "${EPREFIX}"/usr/$(get_libdir)/${PN}/DumpHash.py /usr/bin/responder_dumphash

	newsbin - responder <<-EOF
	#!/bin/sh
	cd /usr/$(get_libdir)/responder
	${EPYTHON} ./Responder.py \${@}
	EOF

	python_optimize "${ED}/usr/$(get_libdir)/${PN}"
}
