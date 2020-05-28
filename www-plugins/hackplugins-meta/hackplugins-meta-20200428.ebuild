# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Collection of browser's plugins for application security testing"
HOMEPAGE="http://pentoo.ch"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm x86"
#IUSE="+firefox"

S="${WORKDIR}"

#noscript
#ringleader

src_install() {
	einfo "FIXME: This meta package is blank for now"
	#FIXME: install ${FILESDIR}/ff-policies.json info:
	#insinto ${MOZILLA_FIVE_HOME}/distribution/
	#*overwrite* (alternative location) the existing one, installed by Gentoo
	#firefox: /usr/${get_libdir}/firefox
	#firefox-bin: /opt/firefox
}
