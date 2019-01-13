# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4,5,6}} )
inherit distutils-r1 readme.gentoo-r1

DESCRIPTION="A Python interactive packet manipulation program for mastering the network"
HOMEPAGE="http://www.secdev.org/projects/scapy/ https://github.com/secdev/scapy"
SRC_URI="https://github.com/secdev/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="3d gnuplot pyx crypt graphviz imagemagick tcpreplay"

RDEPEND="net-analyzer/tcpdump
	3d? ( dev-python/vpython )
	gnuplot? ( dev-python/gnuplot-py )
	pyx? ( dev-python/pyx )
	crypt? ( dev-python/cryptography )
	graphviz? ( media-gfx/graphviz )
	imagemagick? ( virtual/imagemagick-tools )
	tcpreplay? ( net-analyzer/tcpreplay )
	!<net-analyzer/scapy-2.3.3-r1"

S="${WORKDIR}/${P}"
DOC_CONTENTS="
Scapy has optional support for the following packages:
	dev-python/cryptography
	dev-python/gnuplot-py
	dev-python/ipython
	dev-python/pyx
	media-gfx/graphviz
	net-analyzer/tcpreplay
	virtual/imagemagick-tools

	See also \"${EPREFIX}\"/usr/share/doc/${PF}/installation.rst
"
#UML diagram
#dev-python/pylint

src_prepare() {
	echo ${PV} > ${PN}/VERSION
	distutils-r1_src_prepare
}

src_install() {
	distutils-r1_src_install
	dodoc -r doc/${PN}/*
	DISABLE_AUTOFORMATTING=plz readme.gentoo_create_doc
}
