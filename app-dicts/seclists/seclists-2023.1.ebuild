# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A collection of multiple types of lists used during security assessments"
HOMEPAGE="https://github.com/danielmiessler/SecLists"
SRC_URI="https://github.com/danielmiessler/SecLists/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm x86"

S="${WORKDIR}/SecLists-${PV}"

src_install(){
	insinto /usr/share/dict/seclists
	doins -r *
}
