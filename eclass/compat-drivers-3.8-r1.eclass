# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $


# @ECLASS: compat-drivers-3.8-r1.eclass
# @MAINTAINER:
# wuodan@pentoo.ch
# @BLURB: Implements functionality of driver-select script for several modules
# @DESCRIPTION:
# Implements functionality of driver-select script for several modules
# needs a modified version of the driver-select file!

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

# ==============================================================================
# INTERNAL FUNCTIONS
# ==============================================================================

# ==============================================================================
# EXPORTED FUNCTIONS
# ==============================================================================

# @FUNCTION: compat-drivers-3.8-r1_src_configure
# @DESCRIPTION:
# This function reads the configuration (disable-actions and filters) for each
# single active flag, then constructs and applies the common configuration set.
compat-drivers-3.8-r1_src_configure() {
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
			fi
		done
	done
	einfo "List of enabled modules: ${use_enabled_list}"

	# Call the modified driver-select script
	scripts/driver-select -q ${use_enabled_list} || \
		die "driver-select failed. This file was edited by Pentoo"
}

EXPORT_FUNCTIONS src_configure || die
