# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Fast directory scanning and scraping tool"
HOMEPAGE="https://github.com/nccgroup/dirble"

MY_PN="${PN%-bin}"
SRC_URI="
	amd64? ( https://github.com/nccgroup/dirble/releases/download/v${PV}/dirble-x86_64-linux.zip -> ${P}-amd64.zip )
	x86? ( https://github.com/nccgroup/dirble/releases/download/v${PV}/dirble-i686-linux.zip -> ${P}-x86.zip )"

KEYWORDS="-* ~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"
#RDEPEND="!net-analyzer/dirble"

S="${WORKDIR}"/${MY_PN}

src_install() {
	local ins_dir="/opt/${MY_PN}"

	insinto "${ins_dir}" && exeinto "${ins_dir}"
	doins -r dirble_wordlist.txt extensions
	doexe ${MY_PN}

	make_wrapper "${PN}" \
		"${ins_dir}/${MY_PN}"
}
