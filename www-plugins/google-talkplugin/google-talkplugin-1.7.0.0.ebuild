# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit multilib nsplugins rpm

if [ "${PV}" != "9999" ]; then
	#http://dl.google.com/linux/talkplugin/rpm/stable/x86_64/repodata/other.xml.gz
	RPM_URL="http://dl.google.com/linux/talkplugin/rpm/stable/i386"
	RPM_PATCH="1"
	RPM_32B_PKG="${P}-${RPM_PATCH}.i386.rpm"
	RPM_64B_PKG="${P}-${RPM_PATCH}.x86_64.rpm"
	#http://dl.google.com/linux/talkplugin/deb/dists/stable/main/binary-i386/Packages
	DEB_URL="http://dl.google.com/linux/talkplugin/deb/pool/main/${P:0:1}/${PN}"
	DEB_PATCH="1"
	DEB_32B_PKG="${PN}_${PV}-${DEB_PATCH}_i386.deb"
	DEB_64B_PKG="${PN}_${PV}-${DEB_PATCH}_amd64.deb"
else
	DEB_URL="http://dl.google.com/linux/direct"
	RPM_URL="http://dl.google.com/linux/direct"
	RPM_32B_PKG="${PN}_current_i386.rpm"
	RPM_64B_PKG="${PN}_current_x86_64.rpm"
	DEB_32B_PKG="${PN}_current_i386.deb"
	DEB_64B_PKG="${PN}_current_amd64.deb"
fi

DESCRIPTION="Video chat browser plug-in for Google Talk"
SRC_URI="rpm? (
	x86? ( ${RPM_URL}/${RPM_32B_PKG} )
	amd64? (
		multilib? (
			32bit? ( ${RPM_URL}/${RPM_32B_PKG} )
			64bit? ( ${RPM_URL/i386/x86_64}/${RPM_64B_PKG} )
		)
		!multilib? ( ${RPM_URL/i386/x86_64}/${RPM_64B_PKG} )
	)
) !rpm? (
	x86? ( ${DEB_URL}/${DEB_32B_PKG} )
	amd64? (
		multilib? (
			32bit? ( ${DEB_URL}/${DEB_32B_PKG} )
			64bit? ( ${DEB_URL}/${DEB_64B_PKG} )
		)
		!multilib? ( ${DEB_URL}/${DEB_64B_PKG} )
	)
)"

HOMEPAGE="http://www.google.com/chat/video"
IUSE="multilib nspluginwrapper -rpm +system-libCg 32bit 64bit"
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

DEPEND="amd64? ( nspluginwrapper? ( www-plugins/nspluginwrapper ) )
	rpm? ( >=app-arch/rpm2targz-9.0.0.4g )"

EMUL_DEPS=">=app-emulation/emul-linux-x86-baselibs-20100220
	app-emulation/emul-linux-x86-gtklibs
	app-emulation/emul-linux-x86-soundlibs
	app-emulation/emul-linux-x86-xlibs"

#amd64 always needs EMUL_DEPS GoogleTalkPlugin is always a 32-bit binary
RDEPEND="x86? ( ${NATIVE_DEPS} )
	amd64? (
		multilib? (
			64bit? ( ${NATIVE_DEPS} ${EMUL_DEPS} )
			32bit? ( ${EMUL_DEPS} )
		)
		!multilib? ( ${NATIVE_DEPS} ${EMUL_DEPS} )
	)"

INSTALL_BASE="opt/google/talkplugin"

[ "${ARCH}" = "amd64" ] && SO_SUFFIX="64" || SO_SUFFIX=""

QA_TEXTRELS="${INSTALL_BASE}/libnpgtpo3dautoplugin.so
	${INSTALL_BASE}/libnpgoogletalk${SO_SUFFIX}.so"

QA_TEXTRELS_amd64="${INSTALL_BASE}32/libnpgtpo3dautoplugin.so
	${INSTALL_BASE}32/libnpgoogletalk.so"

rm_nswrapper_plugin() {
	#remove all wrapped plugins 
	local i plugin
	if use amd64 && has_version 'www-plugins/nspluginwrapper'; then
		for i in libnpgtpo3dautoplugin.so libnpgoogletalk.so; do
			plugin=$(nspluginwrapper -l | grep -e "^/.*$i")
			if [[ -f ${plugin} ]]; then
				einfo "Removing 32-bit plugin wrapper: ${plugin}"
				nspluginwrapper -r "${plugin}"
			fi
		done
	fi
}

pkg_setup() {
	if use x86; then
		export MY_INSTALL_TYPE="native"
	elif use amd64; then
		if use multilib; then
			if use 32bit && use 64bit; then
				export MY_INSTALL_TYPE="both"
			elif use 64bit; then
				export MY_INSTALL_TYPE="native"
			elif use 32bit; then
				export MY_INSTALL_TYPE="cross"
			else
				eerror "You must select at least one library USE flag (32bit or 64bit)"
				die "No library version selected [-32bit -64bit]"
			fi
		else
			export MY_INSTALL_TYPE="native"
		fi
	fi
}

src_unpack() {
	if [ "${MY_INSTALL_TYPE}" = "native" ]; then
		if use rpm; then
			rpm_unpack ${A}
		else
			unpack ${A} ./data.tar.gz ./usr/share/doc/google-talkplugin/changelog.Debian.gz
		fi
	else # cross or both
		mkdir 32bit
		cd 32bit
		if use rpm; then
			rpm_unpack "${RPM_32B_PKG}"
		else
			unpack "${DEB_32B_PKG}" ./data.tar.gz ./usr/share/doc/google-talkplugin/changelog.Debian.gz
		fi
		cd ..
	fi

	if [ "${MY_INSTALL_TYPE}" = "both" ]; then
		if use rpm; then
			rpm_unpack "${RPM_64B_PKG}"
		else
			unpack "${DEB_64B_PKG}" ./data.tar.gz ./usr/share/doc/google-talkplugin/changelog.Debian.gz
		fi
	fi
}

src_install() {
	if [ "${MY_INSTALL_TYPE}" != "cross" ]; then #native or both
		use rpm || dodoc ./usr/share/doc/google-talkplugin/changelog.Debian

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
	fi

	if [ "${MY_INSTALL_TYPE}" != "native" ]; then #cross or both
		oldabi="${ABI}"
		ABI="x86"

		cd 32bit

		cd "./${INSTALL_BASE}"
		exeinto "${EROOT}${INSTALL_BASE}32"
		doexe GoogleTalkPlugin libnpgtpo3dautoplugin.so	libnpgoogletalk.so
		inst_plugin "${EROOT}${INSTALL_BASE}"32/libnpgtpo3dautoplugin.so
		inst_plugin "${EROOT}${INSTALL_BASE}"32/libnpgoogletalk.so

		#install bundled libCg
		if ! use system-libCg; then
			cd lib
			exeinto "${EROOT}${INSTALL_BASE}"32/lib
			doexe *.so
		fi
		ABI="${oldabi}"
	fi
}

pkg_prerm() {
	rm_nswrapper_plugin
}

pkg_postinst() {
	local i
	if use amd64; then
		if [ "${MY_INSTALL_TYPE}" = "cross" ]; then
			if has_version 'www-plugins/nspluginwrapper'; then
				#install 32bit plugins for 64bit browsers
				oldabi="${ABI}"
				ABI="x86"
				einfo "nspluginwrapper detected: Installing plugin wrapper"
				for i in libnpgtpo3dautoplugin.so libnpgoogletalk.so; do
					nspluginwrapper -i "${EROOT}/usr/$(get_libdir)/${PLUGINS_DIR}/${i}"
				done
				ABI="${oldabi}"
			else
				einfo "To use the 32-bit plugins in a native 64-bit firefox,"
				einfo "you must install www-plugins/nspluginwrapper and run"
				for i in libnpgtpo3dautoplugin.so libnpgoogletalk.so; do
					einfo "nspluginwrapper -i '${EROOT}/usr/$(get_libdir)/${PLUGINS_DIR}/${i}'"
				done
			fi
		else #both or native
			rm_nswrapper_plugin
		fi
	fi
}
