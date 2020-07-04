# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Android SDK Build Tools"
HOMEPAGE="https://developer.android.com/studio/releases/build-tools"
#https://androidsdkoffline.blogspot.com/p/android-sdk-build-tools.html
SRC_URI="https://dl.google.com/android/repository/build-tools_r${PV}-linux.zip"

LICENSE="android"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ncurses"

RDEPEND="ncurses? ( sys-libs/ncurses-compat )
		sys-libs/zlib"
DEPEND="${RDEPEND}"

RESTRICT="strip"
QA_PREBUILT="*"

S="${WORKDIR}/android-11"

ANDROID_SDK_BUILD_TOOLS_DIR="/opt/android-sdk-update-manager/${PN}/${PV}"

src_install() {
	dodir "${ANDROID_SDK_BUILD_TOOLS_DIR}/"
	cp -R "${S}"/* "${ED}/${ANDROID_SDK_BUILD_TOOLS_DIR}/"  || die "Copy files failed"

	for linkfile in aapt aapt2 apksigner dexdump zipalign
	do
		dosym "${EPREFIX}${ANDROID_SDK_BUILD_TOOLS_DIR}/$linkfile" /usr/bin/$linkfile
	done
}
