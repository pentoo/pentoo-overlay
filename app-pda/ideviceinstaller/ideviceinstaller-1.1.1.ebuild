# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A tool to interact with the installation_proxy of an Apple's iDevice"
HOMEPAGE="http://www.libimobiledevice.org/ https://github.com/libimobiledevice/ideviceinstaller"
SRC_URI="https://github.com/libimobiledevice/${PN}/archive/${PV}.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND=">=app-pda/libimobiledevice-1.3.0:=
	>=app-pda/libplist-1.8:=
	>=dev-libs/libzip-0.10"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS NEWS README.md )

src_prepare() {
	./autogen.sh
	sed -i -e 's:-Werror -g::' configure || die
	eapply_user
}
