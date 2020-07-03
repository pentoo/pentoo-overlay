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

RDEPEND=""
DEPEND="${RDEPEND}"

RESTRICT="strip"
QA_PREBUILT="*"

S="${WORKDIR}/android-11"

ANDROID_SDK_BUILD_TOOLS_DIR="/opt/android-sdk-update-manager/${PN}"

src_install() {
#	echo "PATH=\"${EPREFIX}${ANDROID_SDK_DIR}/tools:${EPREFIX}${ANDROID_SDK_DIR}/platform-tools\"" > "${T}/80${PN}" || die

	echo "PATH=\"${EPREFIX}${ANDROID_SDK_BUILD_TOOLS_DIR}\"" > "${T}/81${PN}" || die
	doenvd "${T}/81${PN}"

	dodir "${ANDROID_SDK_BUILD_TOOLS_DIR}/${PV}"
	cp -R "${S}"/* "${ED}/${ANDROID_SDK_BUILD_TOOLS_DIR}/${PV}"  || die "Copy files failed"
}
