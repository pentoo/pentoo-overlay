# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
#PYTHON_REQ_USE="xml"

inherit desktop distutils-r1 xdg-utils

DESCRIPTION="A handy tool to trash your metadata"
HOMEPAGE="https://0xacab.org/jvoisin/mat2"
SRC_URI="https://0xacab.org/jvoisin/mat2/-/archive/${PV}/${P}.tar.gz"

KEYWORDS="amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"

IUSE="dolphin ffmpeg +exif nautilus test"
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
	nautilus? ( dev-python/nautilus-python )
	x11-libs/gdk-pixbuf[introspection,jpeg,tiff]"

distutils_enable_tests unittest

src_prepare() {
	eapply "${FILESDIR}/pyproject.patch"
	sed -i "s|CURRENT_VERSION|${PV}|" pyproject.toml || die

	distutils-r1_src_prepare
}

python_install_all() {
	distutils-r1_python_install_all

	if use nautilus; then
		insinto /usr/share/nautilus-python/extensions/
		doins nautilus/mat2.py
	fi

	if use dolphin; then
		insinto /usr/share/kservices5/ServiceMenus/
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
