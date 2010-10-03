# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/adobe-flash/adobe-flash-10.2.161.22_pre20100915.ebuild,v 1.2 2010/09/17 18:25:17 lack Exp $

EAPI=3
inherit nsplugins multilib toolchain-funcs versionator

# Specal version parsing for date-based 'square' releases
# For proper date ordering in the ebuild we are using preCCYYMMDD whereas Adobe
# uses MMDDYY
EBUILD_DATE=$(get_version_component_range $(get_version_component_count))
DATE_SUFFIX=${EBUILD_DATE: -4}${EBUILD_DATE:5:2}
MY_32B_URI="http://download.macromedia.com/pub/labs/flashplayer10/flashplayer_square_p2_32bit_linux_${DATE_SUFFIX}.tar.gz"
MY_64B_URI="http://download.macromedia.com/pub/labs/flashplayer10/flashplayer_square_p2_64bit_linux_${DATE_SUFFIX}.tar.gz"

DESCRIPTION="Adobe Flash Player"
SRC_URI="x86? ( ${MY_32B_URI} )
amd64? (
	multilib? (
		32bit? ( ${MY_32B_URI} )
		64bit? ( ${MY_64B_URI} )
	)
	!multilib? ( ${MY_64B_URI} )
)"
#HOMEPAGE="http://www.adobe.com/"
HOMEPAGE="http://labs.adobe.com/technologies/flashplayer10/"
IUSE="multilib nspluginwrapper +32bit +64bit"
SLOT="0"

KEYWORDS="-* ~amd64 ~x86"
LICENSE="AdobeFlash-10.1"
RESTRICT="strip mirror"

S="${WORKDIR}"

NATIVE_DEPS="x11-libs/gtk+:2
	media-libs/fontconfig
	dev-libs/nss
	net-misc/curl
	>=sys-libs/glibc-2.4"

EMUL_DEPS=">=app-emulation/emul-linux-x86-gtklibs-20100409-r1
	app-emulation/emul-linux-x86-soundlibs"

DEPEND="amd64? ( multilib? ( 32bit? ( nspluginwrapper? (
	www-plugins/nspluginwrapper ) ) ) )"
RDEPEND="x86? ( $NATIVE_DEPS )
	amd64? (
		multilib? (
			64bit? ( $NATIVE_DEPS )
			32bit? ( $EMUL_DEPS )
		)
		!multilib? ( $NATIVE_DEPS )
	)
	|| ( media-fonts/liberation-fonts media-fonts/corefonts )
	${DEPEND}"

# Where should this all go? (Bug #328639)
INSTALL_BASE="opt/Adobe/flash-player"

# Ignore QA warnings in these binary closed-source libraries, since we can't fix
# them:
QA_EXECSTACK="${INSTALL_BASE}32/libflashplayer.so
	${INSTALL_BASE}/libflashplayer.so"

QA_DT_HASH="${INSTALL_BASE}32/libflashplayer.so
	${INSTALL_BASE}/libflashplayer.so"

pkg_setup() {
	einfo "Date is $EBUILD_DATE suffix is $DATE_SUFFIX"
	if use x86; then
		export native_install=1
	elif use amd64; then
		# amd64 users may unselect the native 64bit binary, if they choose
		if ! use multilib || use 64bit; then
			export native_install=1
		else
			unset native_install
		fi

		if use multilib && use 32bit; then
			export amd64_32bit=1
		else
			unset amd64_32bit
		fi

		if use multilib && ! use 32bit && ! use 64bit; then
			eerror "You must select at least one library USE flag (32bit or 64bit)"
			die "No library version selected [-32bit -64bit]"
		fi

		if [[ $native_install ]]; then
			# 64bit flash requires the 'lahf' instruction (bug #268336)
			# Also, check if *any* of the processors are affected (bug #286159)
			if grep '^flags' /proc/cpuinfo | grep -qv 'lahf_lm'; then
				export need_lahf_wrapper=1
			else
				unset need_lahf_wrapper
			fi
		fi
	fi
}

src_unpack() {
	# In this pre-release version, both tarballs have just 'libflashplayer.so'
	# and no prefix directory, so put the 32-bit one somewhere else.
	if [[ $amd64_32bit ]]; then
		mkdir 32bit
		pushd "${S}/32bit"
			unpack $(basename $MY_32B_URI)
		popd
		unpack $(basename $MY_64B_URI)
	else
		default_src_unpack
	fi
}

src_compile() {
	if [[ $need_lahf_wrapper ]]; then
		# This experimental wrapper, from Maks Verver via bug #268336 should
		# emulate the missing lahf instruction affected platforms.
		$(tc-getCC) -fPIC -shared -nostdlib -lc -oflashplugin-lahf-fix.so \
			"${FILESDIR}/flashplugin-lahf-fix.c" \
			|| die "Compile of flashplugin-lahf-fix.so failed"
	fi
}

src_install() {
	if [[ $native_install ]]; then
		exeinto /${INSTALL_BASE}
		doexe libflashplayer.so
		inst_plugin /${INSTALL_BASE}/libflashplayer.so
	fi

	if [[ $need_lahf_wrapper ]]; then
		# This experimental wrapper, from Maks Verver via bug #268336 should
		# emulate the missing lahf instruction affected platforms.
		exeinto /${INSTALL_BASE}
		doexe flashplugin-lahf-fix.so
		inst_plugin /${INSTALL_BASE}/flashplugin-lahf-fix.so
	fi

	if [[ $amd64_32bit ]]; then
		local oldabi="${ABI}"
		ABI="x86"

		# 32b plugin
		pushd "${S}/32bit"
			exeinto /${INSTALL_BASE}32
			doexe libflashplayer.so
			inst_plugin /${INSTALL_BASE}32/libflashplayer.so
		popd

		ABI="${oldabi}"
	fi

	# The magic config file!
	insinto "/etc/adobe"
	doins "${FILESDIR}/mms.cfg"
}

pkg_postinst() {
	if use amd64; then
		if has_version 'www-plugins/nspluginwrapper'; then
			if [[ $native_install ]]; then
				# TODO: Perhaps parse the output of 'nspluginwrapper -l'
				#       However, the 64b flash plugin makes
				#       'nspluginwrapper -l' segfault.
				local FLASH_WRAPPER="${ROOT}/usr/lib64/nsbrowser/plugins/npwrapper.libflashplayer.so"
				if [[ -f ${FLASH_WRAPPER} ]]; then
					einfo "Removing duplicate 32-bit plugin wrapper: Native 64-bit plugin installed"
					nspluginwrapper -r "${FLASH_WRAPPER}"
				fi
				if [[ $need_lahf_wrapper ]]; then
					ewarn "Your processor does not support the 'lahf' instruction which is used"
					ewarn "by Adobe's 64-bit flash binary.  We have installed a wrapper which"
					ewarn "should allow this plugin to run.  If you encounter problems, please"
					ewarn "adjust your USE flags to install only the 32-bit version and reinstall:"
					ewarn "  ${CATEGORY}/$PN[+32bit -64bit]"
					elog
				fi
			fi
			if [[ $amd64_32bit ]]; then
				einfo "nspluginwrapper detected: Installing plugin wrapper"
				local oldabi="${ABI}"
				ABI="x86"
				local FLASH_SOURCE="${ROOT}/${INSTALL_BASE}32/libflashplayer.so"
				nspluginwrapper -i "${FLASH_SOURCE}"
				ABI="${oldabi}"
				ewarn "Using adobe-flash-10.1 in a 64-bit browser is unstable:"
				ewarn "  http://bugs.gentoo.org/324365"
				ewarn "The recommended configuration is to use the 32-bit plugin"
				ewarn "in a 32-bit browser such as www-client/firefox-bin"
				elog
			fi
		elif [[ ! $native_install ]]; then
			elog "To use the 32-bit flash player in a native 64-bit browser,"
			elog "you must install www-plugins/nspluginwrapper"
		fi
	fi

	ewarn "Flash player is closed-source, with a long history of security"
	ewarn "issues.  Please consider only running flash applets you know to"
	ewarn "be safe.  The 'flashblock' extension may help for mozilla users:"
	ewarn "  https://addons.mozilla.org/en-US/firefox/addon/433"
}
