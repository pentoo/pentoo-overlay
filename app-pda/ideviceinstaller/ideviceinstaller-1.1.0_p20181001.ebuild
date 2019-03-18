# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="A tool to interact with the installation_proxy of an Apple's iDevice"
HOMEPAGE="http://www.libimobiledevice.org/"
#SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"
#EGIT_REPO_URI="https://github.com/libimobiledevice/ideviceinstaller.git"

MY_COMMIT="f14def7cd9303a0fe622732fae9830ae702fdd7c"
SRC_URI="https://github.com/libimobiledevice/${PN}/archive/${MY_COMMIT}.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=app-pda/libimobiledevice-1.1.4:=
	>=app-pda/libplist-1.8:=
	>=dev-libs/libzip-0.8"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS NEWS README )

S="${WORKDIR}/${PN}-${MY_COMMIT}"

src_prepare() {
	./autogen.sh
	sed -i -e 's:-Werror -g::' configure || die
	eapply_user
}
