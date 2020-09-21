# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A tiny web auditor with strong opinions"
HOMEPAGE="https://trailofbits.github.io/twa https://github.com/trailofbits/twa"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/trailofbits/twa"
else
	SRC_URI="https://github.com/trailofbits/twa/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+testssl"

RDEPEND="
	app-misc/jq
	net-misc/curl
	net-analyzer/netcat
	sys-apps/gawk
	testssl? ( net-analyzer/testssl )"

src_prepare() {
	default

	# Fix shebang
	sed -e 's|^#!/usr/bin/env bash$|#!/bin/bash|' -i twa || die

	# Remove the bash version check
	sed -e '/Expected GNU Bash 4.0 or later/d' -i twa || die

	# Remove the "ensure dependency is installed" checks
	sed -e '/^ensure installed .*/d' -i twa || die
}

src_install() {
	dobin twa tscore
	doman twa.1
}
