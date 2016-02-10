# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit kde4-base

DESCRIPTION="Okular is a universal document viewer based on KPDF for KDE 4"
HOMEPAGE="https://github.com/xylosper/okular-backend-mupdf"
SRC_URI="https://github.com/xylosper/okular-backend-mupdf/archive/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="kde-apps/okular
	~app-text/mupdf-1.6
	dev-lang/mujs
	!app-text/mujs"

RDEPEND="${DEPEND}"

#patch is for KDE <4.13
PATCHES=( "${FILESDIR}/okular_412.patch" )
