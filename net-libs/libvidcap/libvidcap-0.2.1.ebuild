DESCRIPTION="a cross-platform library for capturing video from webcams and other video capture devices"
HOMEPAGE="http://libvidcap.sourceforge.net/"
LICENSE="GPL-2 LGPL-2"

MY_PV="${PV/_/}"

SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.gz"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="mirror"

S="${WORKDIR}/${PN}-${MY_PV}"

src_install() {
	emake DESTDIR="${D}" install || die 'emake install failed'
}
