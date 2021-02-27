# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{7..9} )
DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1 readme.gentoo-r1

DESCRIPTION="A Python interactive packet manipulation program for mastering the network"
HOMEPAGE="https://scapy.net/ https://github.com/secdev/scapy"
HASH_COMMIT="f0e3e4452ec63618b09bad30b459b7eba09ebd6b"
SRC_URI="https://github.com/secdev/${PN}/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 x86"
DOC_CONTENTS="
Scapy has optional support for the following packages:

	dev-python/cryptography
	dev-python/ipython
	dev-python/matplotlib
	dev-python/pyx
	media-gfx/graphviz
	net-analyzer/tcpdump
	net-analyzer/tcpreplay
	net-libs/libpcap
	virtual/imagemagick-tools

	See also ""${EPREFIX}/usr/share/doc/${PF}/installation.rst""
"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

src_prepare() {
	if ! [[ -f ${PN}/VERSION ]]; then
		echo ${PV} > ${PN}/VERSION || die
	else
		die
	fi

	distutils-r1_src_prepare
}

src_install() {
	distutils-r1_src_install
	dodoc -r doc/${PN}/*
	DISABLE_AUTOFORMATTING=plz readme.gentoo_create_doc
}
