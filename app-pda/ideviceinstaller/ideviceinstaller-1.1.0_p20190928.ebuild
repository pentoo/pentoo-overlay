# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

MY_COMMIT="b37ce232a44e4e212f71d3792cbd3d86e2f9ac33"

DESCRIPTION="A tool to interact with the installation_proxy of an Apple's iDevice"
HOMEPAGE="http://www.libimobiledevice.org/ https://github.com/libimobiledevice/ideviceinstaller"
SRC_URI="https://github.com/libimobiledevice/${PN}/archive/${MY_COMMIT}.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=app-pda/libimobiledevice-1.2.0:=
	>=app-pda/libplist-1.8:=
	>=dev-libs/libzip-0.10"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS NEWS README )

S="${WORKDIR}/${PN}-${MY_COMMIT}"

src_prepare() {
	./autogen.sh
	sed -i -e 's:-Werror -g::' configure || die
	eapply_user
}
