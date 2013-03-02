# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $


# @ECLASS: compat-drivers-3.8.eclass
# @MAINTAINER:
# wuodan@pentoo.ch
# @BLURB: Implements functionality of driver-select script for several modules
# @DESCRIPTION:
# Implements functionality of driver-select script for several modules

# compose IUSE and REQUIRED_USE from the categories
IUSE+=" +build-all-modules"
REQUIRED_USE+=" || ("
for useexp in ${CPD_USE_EXPAND}; do
	USE_TEMP="\$CPD_USE_EXPAND_$useexp"
	for iuse in `eval echo "\$USE_TEMP"`; do
		if [ "${iuse:0:1}" = '+' ]; then
			IUSE+=" ${iuse:0:1}compat_drivers_${useexp}_${iuse:1}" || die
			REQUIRED_USE+=" compat_drivers_${useexp}_${iuse:1}" || die
		else
			IUSE+=" compat_drivers_${useexp}_${iuse}" || die
			REQUIRED_USE+=" compat_drivers_${useexp}_${iuse} build-all-modules" || die
		fi
	done
done
REQUIRED_USE+=" )"

# ==============================================================================
# INTERNAL VARIABLES
# ==============================================================================

# @VARIABLE: CPD_USE_EXPAND
# @DESCRIPTION:
# This variable needs to be set in the ebuild and contains the categories for
# USE_EXPAND

# @VARIABLE: CPD_USE_EXPAND_category
# @DESCRIPTION:
# These variables need to be set in the ebuild, one per category in
# CPD_USE_EXPAND. They contain the modules of the categories.

# @ECLASS-VARIABLE: CPD_MODULE
# @DESCRIPTION:
# This internal variable contains a temporary value, the currently processed
# module.

# @ECLASS-VARIABLE: CPD_DISABLE_${CPD_MODULE}
# @DESCRIPTION:
# These internal variables contains values, the 'disable-actions' of the
# currently processed module. One variable exists for each active module.

# @ECLASS-VARIABLE: CPD_MAKEFILES
# @DESCRIPTION:
# This internal variable contains a list of all 'Makefile's
CPD_MAKEFILES="
	MAKEFILE
	COMPAT_CONFIG_CW
	DRIVERS_MAKEFILE
	ATH_MAKEFILE
	ATH9K_MAKEFILE
	BRCM80211_MAKEFILE
	RT2X00_MAKEFILE
	TI_MAKEFILE
	NET_WIRELESS_MAKEFILE
	EEPROM_MAKEFILE
	DRIVERS_NET_ATHEROS
	DRIVERS_NET_BROADCOM
	DRIVERS_NET_USB_MAKEFILE
	SSB_MAKEFILE
	BCMA_MAKEFILE"

# @ECLASS-VARIABLE: CPD_MAKEFILES_ARRAY
# @DESCRIPTION:
# This internal variable contains an array with paths to all files
CPD_MAKEFILES_ARRAY=(
	MAKEFILE=Makefile
	COMPAT_CONFIG_CW=config.mk
	DRIVERS_MAKEFILE=drivers/net/wireless/Makefile
	ATH_MAKEFILE=drivers/net/wireless/ath/Makefile
	ATH9K_MAKEFILE=drivers/net/wireless/ath/ath9k/Makefile
	BRCM80211_MAKEFILE=drivers/net/wireless/brcm80211/Makefile
	RT2X00_MAKEFILE=drivers/net/wireless/rt2x00/Makefile
	TI_MAKEFILE=drivers/net/wireless/ti/Makefile
	NET_WIRELESS_MAKEFILE=net/wireless/Makefile
	EEPROM_MAKEFILE=drivers/misc/eeprom/Makefile
	DRIVERS_NET_ATHEROS=drivers/net/ethernet/atheros/Makefile
	DRIVERS_NET_BROADCOM=drivers/net/ethernet/broadcom/Makefile
	DRIVERS_NET_USB_MAKEFILE=drivers/net/usb/Makefile
	SSB_MAKEFILE=drivers/ssb/Makefile
	BCMA_MAKEFILE=drivers/bcma/Makefile
)

# ==============================================================================
# INTERNAL FUNCTIONS
# ==============================================================================

# @FUNCTION: get_makefile
# @DESCRIPTION:
# This internal function returns the path to a file from CPD_MAKEFILES_ARRAY
function get_makefile {
	for file in "${CPD_MAKEFILES_ARRAY[@]}"; do
		if [ "${file%%=*}"	= "${1}" ]; then
			echo "${file#*=}"
			return 0
		fi
	done
	die "Not found"
}

# @FUNCTION: select_drivers_from_makefile
# @DESCRIPTION:
# This internal function filters a Makefile
# It deletes all non matching lines!
function select_drivers_from_makefile
{
	local makefile=$(get_makefile "$1")
	shift
	local configs=""
	for i in $@; do
		[ "${configs}" != '' ] && configs+='|'
		configs+="${i}"
	done
	einfo "Filtering file ${makefile} for: ${configs}"
	sed -r "/${configs}/!d"  ${makefile} > ${makefile}.tmp || die
	mv ${makefile}.tmp ${makefile} || die
}

# @FUNCTION: disable
# @DESCRIPTION:
# This internal function registers a 'disable' action for a module.
# It writes to a variable CPD_DISABLE_${CPD_MODULE}
function disable {
	eval "CPD_DISABLE_${CPD_MODULE}+=\" ${*}\"" || die
}

# @FUNCTION: disable_makefile
# @DESCRIPTION:
# This internal function clears a Makefile completely. Use with care!
function disable_makefile {
	einfo "Clearing entire file: ${1}"
	echo > $1 || die
}

# @FUNCTION: disable_staging
# @DESCRIPTION:
# This internal function disables "staging"
function disable_staging
{
	# perl -i -ne 'print if ! /CONFIG_COMPAT_STAGING/ ' "${MAKEFILE}"
	sed -i '/CONFIG_COMPAT_STAGING/d' "$(get_makefile MAKEFILE)" || die
}

# @FUNCTION: disable_update-initramfs
# @DESCRIPTION:
# This internal function disables "update-initramfs"
function disable_update-initramfs
{
	# perl -i -ne 'print if ! /update-initramfs/' "${MAKEFILE}"
	sed -i '/update-initramfs/d' "$(get_makefile MAKEFILE)" || die
}

# @FUNCTION: disable_lib80211
# @DESCRIPTION:
# This internal function disables "lib80211"
function disable_lib80211
{
	# perl -i -ne 'print if ! /LIB80211/ ' $NET_WIRELESS_MAKEFILE
	sed -i '/LIB80211/d' "$(get_makefile NET_WIRELESS_MAKEFILE)" || die
}

# @FUNCTION: disable_b44
# @DESCRIPTION:
# This internal function disables "b44"
function disable_b44 {
	# perl -i -ne 'print if ! /CONFIG_B44/ ' $DRIVERS_NET_BROADCOM
	sed -i '/CONFIG_B44/d' "$(get_makefile DRIVERS_NET_BROADCOM)" || die
}

# @FUNCTION: disable_ssb
# @DESCRIPTION:
# This internal function disables "ssb"
function disable_ssb
{
	disable_makefile "$(get_makefile ${SSB_MAKEFILE})"
	# perl -i -ne 'print if ! /drivers\/ssb\//' "${MAKEFILE}"
	sed -i '/drivers\/ssb\//d' "$(get_makefile MAKEFILE)" || die
}

# @FUNCTION: disable_bcma
# @DESCRIPTION:
# This internal function disables "bcma"
function disable_bcma
{
	disable_makefile "$(get_makefile ${BCMA_MAKEFILE})"
	# perl -i -ne 'print if ! /drivers\/bcma\//' "${MAKEFILE}"
	sed -i '/drivers\/bcma\//d' "$(get_makefile MAKEFILE)" || die
}

# @FUNCTION: disable_rfkill
# @DESCRIPTION:
# This internal function disables "rfkill"
function disable_rfkill
{
	# perl -i -ne 'print if ! /CONFIG_COMPAT_RFKILL/' "${MAKEFILE}"
	sed -i '/CONFIG_COMPAT_RFKILL/d' "$(get_makefile MAKEFILE)" || die
}

# @FUNCTION: disable_eprom
# @DESCRIPTION:
# This internal function disables "eprom"
function disable_eeprom
{
	disable_makefile "$(get_makefile ${EEPROM_MAKEFILE})" || die
	# perl -i -ne 'print if ! /drivers\/misc\/eeprom\//' "${MAKEFILE}"
	sed -i '/drivers\/misc\/eeprom\//d' "$(get_makefile MAKEFILE)" || die
}

# @FUNCTION: disable_usbnet
# @DESCRIPTION:
# This internal function disables "usbnet"
function disable_usbnet
{
	disable_makefile ${DRIVERS_NET_USB_MAKEFILE} || die
	# perl -i -ne 'print if ! /drivers\/net\/usb\//' "${MAKEFILE}"
	sed -i '/drivers\/net\/usb\//d' "$(get_makefile MAKEFILE)" || die
}

# @FUNCTION: disable_usbnet
# @DESCRIPTION:
# This internal function disables "usbnet"
# this function is twice in driver-select script!?!
function disable_usbnet {
	# perl -i -ne 'print if ! /CONFIG_COMPAT_NET_USB_MODULES/' "${MAKEFILE}"
	sed -i '/CONFIG_COMPAT_NET_USB_MODULES/d' "$(get_makefile MAKEFILE)" || die
} 

# @FUNCTION: disable_ethernet
# @DESCRIPTION:
# This internal function disables "ethernet"
function disable_ethernet {
	# perl -i -ne 'print if ! /CONFIG_COMPAT_NETWORK_MODULES/' "${MAKEFILE}"
	sed -i '/CONFIG_COMPAT_NETWORK_MODULES/d' "$(get_makefile MAKEFILE)" || die
} 

# @FUNCTION: disable_var_03
# @DESCRIPTION:
# This internal function disables "var_03"
function disable_var_03 {
	# perl -i -ne 'print if ! /CONFIG_COMPAT_VAR_MODULES/' "${MAKEFILE}"
	sed -i '/CONFIG_COMPAT_VAR_MODULES/d' "$(get_makefile MAKEFILE)" || die
} 

# @FUNCTION: disable_bt
# @DESCRIPTION:
# This internal function disables "bt"
function disable_bt {
	# perl -i -ne 'print if ! /CONFIG_COMPAT_BLUETOOTH/' "${MAKEFILE}"
	sed -i '/CONFIG_COMPAT_BLUETOOTH/d' "$(get_makefile MAKEFILE)" || die
} 

# @FUNCTION: disable_80211
# @DESCRIPTION:
# This internal function disables "80211"
function disable_80211 {
	# perl -i -ne 'print if ! /CONFIG_COMPAT_WIRELESS/' "${MAKEFILE}"
	sed -i '/CONFIG_COMPAT_WIRELESS/d' "$(get_makefile MAKEFILE)" || die
}

# @FUNCTION: disable_drm
# @DESCRIPTION:
# This internal function disables "drm"
function disable_drm {
	# perl -i -ne 'print if ! /CONFIG_COMPAT_VIDEO_MODULES/' "${MAKEFILE}"
	sed -i '/CONFIG_COMPAT_VIDEO_MODULES/d' "$(get_makefile MAKEFILE)" || die
}

# @FUNCTION: disable_ath9k_rate_control
# @DESCRIPTION:
# This internal function disables "ath9k_rate_control"
# new function, not in driver-select
function disable_ath9k_rate_control {
	# perl -i -ne 'print if ! /CONFIG_COMPAT_ATH9K_RATE_CONTROL/ ' $COMPAT_CONFIG_CW
	sed -i '/CONFIG_COMPAT_ATH9K_RATE_CONTROL/d' "$(get_makefile COMPAT_CONFIG_CW)" || die
}

# @FUNCTION: select_drivers
# @DESCRIPTION:
# This internal function registers filters for the drivers Makefile
function select_drivers {
	eval "CPD_DRIVERS_MAKEFILE+=\" ${*}\"" || die
}

# @FUNCTION: select_ath_driver
# @DESCRIPTION:
# This internal function registers filters for the ath Makefile
function select_ath_driver {
	eval "CPD_ATH_MAKEFILE+=\" ${*}\"" || die
}

# @FUNCTION: select_ath_driver_common
# @DESCRIPTION:
# This internal function registers common filters for the ath Makefile
function select_ath_driver_common {
	# eval "CPD_ATH_MAKEFILE+=\" CONFIG_ATH_ ath-objs regd.o hw.o\"" || die
	select_ath_driver CONFIG_ATH_ ath-objs regd.o hw.o key.o || die
}

# @FUNCTION: select_brcm80211_driver
# @DESCRIPTION:
# This internal function registers filters for the brcm80211 Makefile
function select_brcm80211_driver {
	eval "CPD_BRCM80211_MAKEFILE+=\" ${*}\"" || die
}

# @FUNCTION: select_ti_driver
# @DESCRIPTION:
# This internal function registers filters for the ti Makefile
function select_ti_drivers {
	select_drivers CONFIG_WL_TI
	eval "CPD_TI_MAKEFILE+=\" ${*}\"" || die
}

# @FUNCTION: set_flag
# @DESCRIPTION:
# This internal function contains the configuration for each flag/module
function set_flag {
	# clear/set global vars
	CPD_MODULE=$1
	case $1 in
		ath5k)
			disable staging usbnet ethernet bt update-initramfs var_03 drm || die
			select_drivers		CONFIG_ATH_CARDS || die
			select_ath_driver	CONFIG_ATH5K || die
			select_ath_driver_common || die
			;;
		ath9k)
			disable staging usbnet ethernet bt update-initramfs var_03 drm || die
			select_drivers		CONFIG_ATH_CARDS || die
			select_ath_driver CONFIG_ATH9K_HW || die
			select_ath_driver_common || die
			;;
		ath9k_ap)
			disable staging usbnet ethernet bt update-initramfs var_03 drm || die
			select_drivers		CONFIG_ATH_CARDS || die
			select_ath_driver CONFIG_ATH9K_HW || die
			select_ath_driver_common || die
			disable ath9k_rate_control || die
			;;
		carl9170)
			disable staging usbnet ethernet bt update-initramfs var_03 drm || die
			select_drivers		CONFIG_ATH_CARDS || die
			select_ath_driver	CONFIG_CARL9170 || die
			select_ath_driver_common || die
			;;
		ath9k_htc)
			disable staging usbnet ethernet bt update-initramfs var_03 drm || die
			select_drivers		CONFIG_ATH_CARDS || die
			select_ath_driver CONFIG_ATH9K_HW || die
			select_ath_driver_common || die
			;;
		ath6kl)
			disable staging usbnet ethernet bt update-initramfs var_03 drm || die
			select_drivers		CONFIG_ATH_CARDS || die
			select_ath_driver	CONFIG_ATH6KL || die
			select_ath_driver_common || die
			;;
		wil6210)
			disable staging usbnet ethernet bt update-initramfs var_03 drm || die
			select_drivers		CONFIG_ATH_CARDS || die
			select_ath_driver	CONFIG_WIL6210 || die
			;;
		brcmsmac)
			disable staging usbnet ethernet bt update-initramfs var_03 drm || die
			select_drivers		CONFIG_BRCMSMAC || die
			select_brcm80211_driver	CONFIG_BRCMSMAC CONFIG_BRCMUTIL || die
			;;
		brcmfmac)
			disable staging usbnet ethernet bt update-initramfs var_03 drm || die
			select_drivers		CONFIG_BRCMFMAC || die
			select_brcm80211_driver	CONFIG_BRCMSMAC CONFIG_BRCMUTIL || die
			;;
		zd1211rw)
			select_drivers		CONFIG_COMPAT_ZD1211RW || die
			disable staging lib80211 ssb bcma usbnet eeprom update-initramfs || die
			;;
		b43)
			disable staging usbnet ethernet bt update-initramfs || die
			disable eeprom lib80211 || die
			select_drivers		CONFIG_B43 || die
			;;
		rt2x00)
			select_drivers		CONFIG_RT2X00 || die
			disable staging usbnet ethernet bt update-initramfs || die
			disable lib80211 ssb bcma usbnet update-initramfs || die
			;;
		wl1251)
			select_ti_drivers	CONFIG_WL1251 || die
			disable staging lib80211 ssb bcma usbnet eeprom update-initramfs || die
			;;
		wl12xx)
			select_ti_drivers	CONFIG_WL12XX || die
			disable staging lib80211 ssb bcma usbnet eeprom update-initramfs || die
			;;
		wl18xx)
			select_ti_drivers	CONFIG_WL18XX || die
			disable staging lib80211 ssb bcma usbnet eeprom update-initramfs || die
			;;
	# Ethernet and Bluetooth drivers
		atl1)
			disable staging usbnet var_03 drm bt rfkill 80211 b44 || die
			echo -e "obj-\$(CONFIG_ATL1) += atlx/" > "$(get_makefile DRIVERS_NET_ATHEROS)" || die
			;;
		atl2)
			disable staging usbnet var_03 drm bt rfkill 80211 b44 || die
			echo -e "obj-\$(CONFIG_ATL2) += atlx/" > "$(get_makefile DRIVERS_NET_ATHEROS)" || die
			;;
		atl1e)
			disable staging usbnet var_03 drm bt rfkill 80211 b44 || die
			echo -e "obj-\$(CONFIG_ATL1E) += atl1e/" > "$(get_makefile DRIVERS_NET_ATHEROS)" || die
			;;
		atl1c)
			disable staging usbnet var_03 drm bt rfkill 80211 b44 || die
			echo -e "obj-\$(CONFIG_ATL1C) += atl1c/" > "$(get_makefile DRIVERS_NET_ATHEROS)" || die
			;;
		alx)
			disable staging usbnet var_03 drm bt rfkill 80211 b44 || die
			echo -e "obj-\$(CONFIG_ALX) += alx/" > "$(get_makefile DRIVERS_NET_ATHEROS)" || die
			;;
		atlxx)
			select_drivers		CONFIG_ATL1 CONFIG_ATL2 CONFIG_ATL1E CONFIG_ALX || die
			disable staging usbnet var_03 drm bt rfkill 80211 b44 update-initramfs || die
			;;
		bt)
			select_drivers 		CONFIG_BT || die
			disable ssb bcma usbnet eeprom update-initramfs ethernet staging 80211 || die
			;;
		i915)
			# rfkill may be needed if you enable b44 as you may have b43
			disable ethernet staging usbnet var_03 bt rfkill 80211 || die
			;;
		drm)
			# rfkill may be needed if you enable b44 as you may have b43
			disable ethernet staging usbnet var_03 bt rfkill 80211 || die
			;;
	# Manually added options by pentoo
		usbnet)
			# disable everything else
			disable staging update-initramfs lib80211 b44 ssb bcma rfkill eeprom ethernet var_03 bt 80211 ath9k_rate_control || die
			;;
		staging)
			# disable everything else
			disable usbnet update-initramfs lib80211 b44 ssb bcma rfkill eeprom ethernet var_03 bt 80211 ath9k_rate_control || die
			;;
		b44)
			disable staging usbnet ethernet bt update-initramfs || die
			disable eeprom lib80211 || die
			select_drivers		CONFIG_B44 || die
			;;
		*)
			die "Unsupported driver: ${1}"
			exit
			;;
	esac
}

# @FUNCTION: echo_flag_settings
# @DESCRIPTION:
# This internal function outputs the "disable" actions for a flag
function echo_flag_settings {
	# example:
	# CPD_DISABLE_${iflag}="action1 action2"
	# CPD_DRIVERS_MAKEFILE="flag1 flag1"
	# CPD_ATH_MAKEFILE="flag3"
	# ...
	local iflag=$1
	eval "local disable_list=\"\${CPD_DISABLE_${iflag}}\"" || die
	einfo "Disable list for ${iflag}: ${disable_list}"
}

# ==============================================================================
# EXPORTED FUNCTIONS
# ==============================================================================

# @FUNCTION: compat-drivers-3.8_src_configure
# @DESCRIPTION:
# This function reads the configuration (disable-actions and filters) for each
# single active flag, then constructs and applies the common configuration set.
compat-drivers-3.8_src_configure() {
	# early exit, skip filtering of configuration and build all modules
	if use build-all-modules; then
		ewarn "You have chosen to build all modules!"
		ewarn "The Pentoo team strives to build only the desired modules and the"
		ewarn "use flag 'build-all-modules' should only be used when"
		ewarn "the desired modules is not available through another flag."
		ewarn "Please open an issue at the Pentoo site and let us know which"
		ewarn "module was missing!"
		return 0
	fi

	# loop over all modules
	local use_temp=''
	local use_enabled_list=''
	for useexp in ${CPD_USE_EXPAND}; do
		use_temp="\$CPD_USE_EXPAND_$useexp" || die
		for iuse in `eval echo "\$use_temp"`; do
			if [ "${iuse:0:1}" = '+' ]; then
				local iuse2=${iuse:1} || die
			else
				local iuse2=${iuse} || die
			fi
			local iflag="compat_drivers_${useexp}_${iuse2}" || die
			# check if it's enabled
			if use "${iflag}"; then
				use_enabled_list+=" ${iuse2}" || die
				# fill the disable/enable lists
				# example:
				# CPD_DISABLE_${iflag}="action1 action2"
				# CPD_DRIVERS_MAKEFILE="flag1 flag1"
				# CPD_ATH_MAKEFILE="flag3"
				# ...
				set_flag "${iuse2}" || die
				echo_flag_settings "${iuse2}" || die
			fi
		done
	done
	einfo "List of enabled modules: ${use_enabled_list}"
	# compose common disable list for all flags
	# 1st module/flag
	local iuse1="$(echo $use_enabled_list | cut -d ' ' -f 1)" || die
	eval "local disable_list=\$CPD_DISABLE_${iuse1}" || die
	for iuse in ${use_enabled_list}; do
		if [ "${iuse}" != "${iuse1}" ]; then
			local disable_list_new='' || die
			eval "local disable_list_other=\$CPD_DISABLE_${iuse}" || die
			for dis in ${disable_list}; do
				has "${dis}" ${disable_list_other} && \
					disable_list_new+=" ${dis}"
			done
			disable_list="${disable_list_new}" || die
		fi
	done
	# execute all filters for the Makefiles
	for file in ${CPD_MAKEFILES}; do
		eval "local filter_list=\$CPD_${file}" || die
		if [ -n "${filter_list}" ]; then
			# einfo "Filtering $(get_makefile ${file}) for: ${filter_list}"
			select_drivers_from_makefile "${file}" "${filter_list}" || die
		fi
	done
	# execute common disable list
	einfo "Common disable list: ${disable_list}"
	for dis in ${disable_list}; do
		einfo "Running disable function: disable_${dis}"
		eval "disable_${dis}" || die
	done
}

EXPORT_FUNCTIONS src_configure || die
