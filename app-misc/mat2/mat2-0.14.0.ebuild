# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
#PYTHON_REQ_USE="xml"

inherit desktop distutils-r1 xdg-utils

DESCRIPTION="A handy tool to trash your metadata"
HOMEPAGE="https://github.com/jvoisin/mat2"
SRC_URI="https://github.com/jvoisin/mat2/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"

IUSE="dolphin ffmpeg +exif test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}
	test? ( exif ffmpeg )"

RESTRICT="!test? ( test )"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	media-libs/mutagen[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]

	app-text/poppler[introspection,cairo]
	dev-libs/glib
	exif? ( media-libs/exiftool )
	gnome-base/librsvg:2[introspection]
	ffmpeg? ( media-video/ffmpeg )
	x11-libs/gdk-pixbuf[introspection,jpeg,tiff]"

#	nautilus? ( dev-python/nautilus-python )

distutils_enable_tests unittest

src_prepare() {
#	eapply "${FILESDIR}/pyproject.patch"
	sed -i "s|CURRENT_VERSION|${PV}|" pyproject.toml || die

	distutils-r1_src_prepare
}

python_install_all() {
	distutils-r1_python_install_all

#	if use nautilus; then
#		insinto /usr/share/nautilus-python/extensions/
#		doins nautilus/mat2.py
#	fi

	if use dolphin; then
		insinto /usr/share/kio/servicemenus
		doins dolphin/mat2.desktop
	fi

	doicon -s 512 data/mat2.png
	doicon -s scalable data/mat2.svg

	doman doc/mat2.1
	dodoc *.md doc/*.md
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
