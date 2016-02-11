# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="A tool for identifying files embedded inside firmware images"
HOMEPAGE="https://github.com/devttys0/binwalk"
SRC_URI="https://github.com/devttys0/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="graph squashfs"

#git gcc gcc-c++ make openssl-devel qtwebkit-devel qt-devel gzip bzip2 tar arj p7zip p7zip-plugins
#cabextract squashfs-tools zlib zlib-devel lzo lzo-devel xz xz-compat-libs xz-libs xz-devel
#xz-lzma-compat python-backports-lzma lzip pyliblzma perl-Compress-Raw-Lzma"

RDEPEND="
	dev-python/backports-lzma
	dev-python/pyliblzma
	sys-apps/file[${PYTHON_USEDEP}]
	graph? ( dev-python/pyqtgraph[opengl,${PYTHON_USEDEP}] )
	squashfs? ( sys-fs/squashfs-tools:0
		sys-fs/sasquatch
	)
"
