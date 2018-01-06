# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: mozilla-webext.eclass
# @MAINTAINER:
# Anton Bolshakov <blshkv@pentoo.ch>
# @BLURB: Eclass for installing firefox addons.
# @DESCRIPTION:
# Install web extensions for firefox

# @ECLASS-VARIABLE: WEXT_GUID
# @REQUIRED
# @DEFAULT_UNSET
# @DESCRIPTION:
# GUID for the web extension
# A string formatted like an email address:
#  WEXT_GUID=extensionname@example.org

# @ECLASS-VARIABLE: WEXT_FILEID
# @REQUIRED
# @DEFAULT_UNSET
# @DESCRIPTION:
# FILEID for the web extension
# A set of digets formatted like:
#  WEXT_FILEID=759731

# @ECLASS-VARIABLE: WEXT_API_PATH
# @DESCRIPTION:
# Path to download API content. Default is ${WORKDIR/${PN}.xml.
: ${MEXT_API_PATH:=${WORKDIR}/${PN}.xml}

# This eclass supports all EAPIs
EXPORT_FUNCTIONS src_unpack src_install

SRC_URI="https://addons.mozilla.org/downloads/file/${WEXT_FILEID} -> ${P}.xpi"

RDEPEND=" || ( >=www-client/firefox-57.0.0 >=www-client/firefox-bin-57.0.0 )"

S="${WORKDIR}"

# @FUNCTION: mozilla-webext_getemid
# @DESCRIPTION:
# Parses api xml file
# Avoid using awk with this dummy parser function
mozilla-webext_getguid() {
	local line
	while read line; do
		if echo -n "${line}" | grep -Eq '<guid>[^<]+</guid>'; then
			WEXT_GUID="$(echo -n "${line}" | sed -r 's#^.*<guid>([^<]+)</guid>.*$#\1#')"
			break
		fi
	done < "${MEXT_API_PATH}"

	[[ -n "${WEXT_GUID}" ]] || die "$FUNCNAME could not find guid!"
	echo -n "${WEXT_GUID}"
}

# @FUNCTION: mozilla-webext_getfileid
# @DESCRIPTION:
# Parses api xml file
# Avoid using awk with this dummy parser function
mozilla-webext_getfileid() {
	local line
	while read line; do
		if echo -n "${line}" | grep -Eq 'https.*xpi'; then
			WEXT_FILEID="$(echo -n "${line}" | sed -r 's#^.*https://.*/([0-9]+)/.*xpi.*$#\1#')"
			break
		fi
	done < "${MEXT_API_PATH}"

	[[ -n "${WEXT_FILEID}" ]] || die "$FUNCNAME could not find guid!"
	echo -n "${WEXT_FILEID}"
}

# @FUNCTION: mozilla-webext_src_unpack
# @DESCRIPTION:
# Default src_unpack function for firefox addons
mozilla-webext_src_unpack() {
	echo
	#this is probably illegal, commet out for now
#	wget https://services.addons.mozilla.org/en-US/firefox/api/1.5/addon/${PN} -O ${MEXT_API_PATH}
}

# @FUNCTION: mozilla-web_src_install
# @DESCRIPTION:
# Default install function for firefox addons
mozilla-webext_src_install() {
#	local guid
#	guid="$(mozilla-webext_getguid)"

	# install to global installation folder
	insinto "/usr/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/"
	newins "${DISTDIR}/${P}".xpi ${WEXT_GUID}.xpi
}
