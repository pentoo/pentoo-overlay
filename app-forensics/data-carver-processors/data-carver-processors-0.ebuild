# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

MY_P="${PN//-/_}"
DESCRIPTION="Data carving analysis for JPEG, PDF and Videos"
HOMEPAGE="http://www.citadelsystems.net/index.php/forensics-tools/34-data-carver/56-data-carver-processors"
SRC_URI="http://www.citadelsystems.net/downloads/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
S="${WORKDIR}/${MY_P}"

IUSE="mplayer +stego"
RDEPEND="sys-apps/file
	media-gfx/imagemagick
	media-libs/exiftool
	stego? ( app-forensics/stegdetect )
	mplayer? ( media-video/mplayer )"
DEPEND="${RDEPEND}"

src_compile(){
	sed -e '/stegdetectpath=/ s:local/::g' -i data_processor.ini image-processor.pl
}

src_install() {
	insinto "/usr/lib/${PN}/"
	insopts -m755
	doins image-processor.pl
	doins data_processor.ini
	doins -r image-plugins
	dosym "/usr/lib/${PN}/image-processor.pl" /usr/bin/image-processor.pl
	dodoc README.TXT
	dobin "${FILESDIR}/image-processor"
}
