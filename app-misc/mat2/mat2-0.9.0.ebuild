# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6} )
PYTHON_REQ_USE="xml"

inherit eutils gnome2-utils distutils-r1

DESCRIPTION="A handy tool to trash your metadata"
HOMEPAGE="https://0xacab.org/jvoisin/mat2"
SRC_URI="https://0xacab.org/jvoisin/mat2/-/archive/${PV}/${P}.tar.gz"
LICENSE="GPL-3"
SLOT=0
KEYWORDS="~amd64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
IUSE="+audio +exif +pdf"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	audio? ( media-libs/mutagen[${PYTHON_USEDEP}] )
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	exif? ( media-libs/exiftool )
	media-video/ffmpeg[mp3,opus(+),vorbis(+)]
	pdf? ( app-text/poppler[introspection,jpeg,png] )"
