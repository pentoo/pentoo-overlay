# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Collection of browser's plugins for application security testing"
HOMEPAGE="http://pentoo.ch"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm x86"

S="${WORKDIR}"

# ringleader

# about:policies
src_install() {
	insinto /etc/firefox/policies/
	newins "${FILESDIR}/ff-policies.json" policies.json

	#(alternative location) the existing one, installed by Gentoo
	#insinto ${MOZILLA_FIVE_HOME}/distribution/
	#firefox: /usr/${get_libdir}/firefox
	#firefox-bin: /opt/firefox
}
