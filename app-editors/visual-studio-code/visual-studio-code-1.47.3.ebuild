# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils pax-utils desktop

DESCRIPTION="Multiplatform Visual Studio Code from Microsoft"
HOMEPAGE="https://code.visualstudio.com"
BASE_URI="https://vscode-update.azurewebsites.net/${PV}"
#	x86? ( ${BASE_URI}/linux-ia32/stable ->  ${P}-x86.tar.gz )
SRC_URI="
	amd64? ( ${BASE_URI}/linux-x64/stable -> ${P}-amd64.tar.gz )
	"

RESTRICT="mirror strip bindist"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gnome-keyring"

DEPEND="gnome-base/gsettings-desktop-schemas
		>=media-libs/libpng-1.2.46:0
		>=x11-libs/cairo-1.14.12:0
		>=x11-libs/gtk+-2.24.31-r1:2
		>=x11-libs/libXtst-1.2.3:0
		"

RDEPEND="
	${DEPEND}
	>=net-print/cups-2.1.4:0
	>=x11-libs/libnotify-0.7.7:0
	>=x11-libs/libXScrnSaver-1.2.2-r1:0
	dev-libs/nss
	gnome-keyring? ( app-crypt/libsecret[crypt] )
	"

QA_PREBUILT="opt/${PN}/*"
QA_PRESTRIPPED="opt/${PN}/*"

pkg_setup(){
	use amd64 && S="${WORKDIR}/VSCode-linux-x64" || S="${WORKDIR}/VSCode-linux-ia32"
}

src_install(){
	local DEST="/opt/${PN}"
	pax-mark m code
	insinto "${DEST}"
	doins -r *
	dosym "${DEST}/bin/code" "/usr/bin/${PN}"
	dosym "${DEST}/bin/code" "/usr/bin/vscode"
	make_desktop_entry "vscode" "Visual Studio Code" "${PN}" "Development;IDE"
	doicon "${FILESDIR}/${PN}.png"
	fperms +x "${DEST}/code"
	fperms +x "${DEST}/bin/code"
#	fperms +x "${DEST}/libnode.so"
	fperms +x "${DEST}/resources/app/node_modules.asar.unpacked/vscode-ripgrep/bin/rg"
	fperms +x "${DEST}/resources/app/extensions/git/dist/askpass.sh"
	insinto "/usr/share/licenses/${PN}"
	for i in resources/app/LICEN*;
	do
		newins "${i}" "`basename ${i}`"
	done
	for i in resources/app/licenses/*;
	do
		newins "${i}" "`basename ${i}`"
	done
}

pkg_postinst(){
	einfo "You may install some additional utils, so check them in:"
	einfo "https://code.visualstudio.com/Docs/setup#_additional-tools"
}
