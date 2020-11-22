# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=AHERNIT
inherit perl-module

DESCRIPTION="Converts ascii strings to hex and reverse"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

SRC_TEST="do"

RDEPEND="virtual/perl-Exporter"
DEPEND="${RDEPEND}"
