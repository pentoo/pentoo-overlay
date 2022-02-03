# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pentoo kernel sources (kernel series ${KV_MAJOR}.${KV_MINOR})"
HOMEPAGE="https://github.com/pentoo/pentoo-livecd/tree/master/kernel/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="sys-kernel/pentoo-sources[lts(-)]
	!sys-kernel/pentoo-sources[-lts(+)]"
RDEPEND="${DEPEND}"
BDEPEND=""
