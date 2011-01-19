# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit nsplugins

if [ "${PV}" != "9999" ]; then
	DEB_PATCH="1"
	#http://dl.google.com/linux/talkplugin/deb/dists/stable/main/binary-i386/Packages
	MY_URL="http://dl.google.com/linux/talkplugin/deb/pool/main/${P:0:1}/${PN}"
	MY_PKG="${PN}_${PV}-${DEB_PATCH}_i386.deb"
else
	MY_URL="http://dl.google.com/linux/direct"
	MY_PKG="${PN}_current_i386.deb"
fi

DESCRIPTION="Video chat browser plug-in for Google Talk"
SRC_URI="x86? ( ${MY_URL}/${MY_PKG} )
	amd64? ( ${MY_URL}/${MY_PKG/i386/amd64} )"

HOMEPAGE="http://www.google.com/chat/video"
IUSE="+system-libCg"
SLOT="0"

KEYWORDS="-* ~amd64 ~x86"
LICENSE="UNKNOWN"
RESTRICT="strip mirror"

#to get these run:
#for i in $(scanelf -n /opt/google/talkplugin/* | awk '/^ET/{gsub(/,/,"\n",$2);print $2}' | sort -u)
#do
#  find /lib /usr/lib -maxdepth 1 -name $i -exec qfile -S {} \;
#done |  awk '{print $1}' | sort -u
#also see debian control file
NATIVE_DEPS="|| ( media-sound/pulseaudio media-libs/alsa-lib )
	dev-libs/glib:2
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/libpng:1.2
	>=sys-libs/glibc-2.4
	x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/libXfixes
	x11-libs/libXt
	system-libCg? ( media-gfx/nvidia-cg-toolkit )
	sys-apps/lsb-release"

DEPEND=""

EMUL_DEPS=">=app-emulation/emul-linux-x86-baselibs-20100220
	app-emulation/emul-linux-x86-gtklibs
	app-emulation/emul-linux-x86-soundlibs
	app-emulation/emul-linux-x86-xlibs"

#amd64 always needs EMUL_DEPS GoogleTalkPlugin is always a 32-bit binary
RDEPEND="x86? ( ${NATIVE_DEPS} )
	amd64? ( ${NATIVE_DEPS} ${EMUL_DEPS} )"

INSTALL_BASE="opt/google/talkplugin"

[ "${ARCH}" = "amd64" ] && SO_SUFFIX="64" || SO_SUFFIX=""

QA_TEXTRELS="${INSTALL_BASE}/libnpgtpo3dautoplugin.so
	${INSTALL_BASE}/libnpgoogletalk${SO_SUFFIX}.so"

src_unpack() {
	unpack ${A} ./data.tar.gz ./usr/share/doc/google-talkplugin/changelog.Debian.gz
}

src_install() {
	dodoc ./usr/share/doc/google-talkplugin/changelog.Debian

	cd "./${INSTALL_BASE}"
	exeinto "${EROOT}${INSTALL_BASE}"
	doexe GoogleTalkPlugin libnpgtpo3dautoplugin.so	libnpgoogletalk"${SO_SUFFIX}".so
	inst_plugin "${EROOT}${INSTALL_BASE}"/libnpgtpo3dautoplugin.so
	inst_plugin "${EROOT}${INSTALL_BASE}"/libnpgoogletalk"${SO_SUFFIX}".so

	#install bundled libCg
	if ! use system-libCg; then
		cd lib
		exeinto "${EROOT}${INSTALL_BASE}/lib"
		doexe *.so
	fi
}
