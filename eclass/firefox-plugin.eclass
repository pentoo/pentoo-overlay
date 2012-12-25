# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: firefox-plugin.eclass
# @MAINTAINER:
# Stefan Kuhn <wuodan@pentoo.ch>
# @BLURB: Eclass for installing firefox plugins.
# @DESCRIPTION:
# Install extensions for firefox

inherit mozextension multilib

# This eclass supports all EAPIs
EXPORT_FUNCTIONS src_unpack src_install

RDEPEND="|| (
	www-client/firefox-bin
	www-client/firefox
)"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

# @ECLASS-VARIABLE: FFP_XPI_FILE
# @REQUIRED
# @DEFAULT_UNSET
# @DESCRIPTION:
# Filename of downloaded .xpi file without the .xpi ending
#
# FFP_XPI_FILE="${P}"

# @FUNCTION: firefox-plugin_src_unpack
# @DESCRIPTION:
# Default unpack function for firefox plugins
firefox-plugin_src_unpack() {
	xpi_unpack $A
}

# @FUNCTION: firefox-plugin_src_install
# @DESCRIPTION:
# Default install function for firefox plugins
firefox-plugin_src_install() {
	declare MOZILLA_FIVE_HOME
	if has_version 'www-client/firefox'; then
		MOZILLA_FIVE_HOME="/usr/$(get_libdir)/firefox"
		xpi_install "${S}/${FFP_XPI_FILE}"
	fi
	if has_version 'www-client/firefox-bin'; then
		MOZILLA_FIVE_HOME="/opt/firefox"
		xpi_install "${S}/${FFP_XPI_FILE}"
	fi
}
