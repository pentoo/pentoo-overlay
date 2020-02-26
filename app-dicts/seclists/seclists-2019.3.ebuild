# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="A collection of multiple types of lists used during security assessments"
HOMEPAGE="https://github.com/danielmiessler/SecLists"
SRC_URI="https://github.com/danielmiessler/SecLists/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

S="${WORKDIR}/SecLists-${PV}"

src_prepare(){
	#https://github.com/danielmiessler/SecLists/issues/226
	rm ./Payloads/File-Names/max-length/*
	eapply_user
}

src_install(){
	insinto /usr/share/dict/seclists
	doins -r *
}
