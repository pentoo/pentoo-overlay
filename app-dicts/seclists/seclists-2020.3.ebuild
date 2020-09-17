# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A collection of multiple types of lists used during security assessments"
HOMEPAGE="https://github.com/danielmiessler/SecLists"
SRC_URI="https://github.com/danielmiessler/SecLists/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm x86"

S="${WORKDIR}/SecLists-${PV}"

src_prepare(){
	default

	#https://github.com/danielmiessler/SecLists/issues/226
	rm ./Payloads/File-Names/max-length/* || die
}

src_install(){
	insinto /usr/share/dict/seclists
	doins -r *
}
