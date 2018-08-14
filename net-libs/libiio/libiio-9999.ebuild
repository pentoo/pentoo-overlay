# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Library for interfacing with IIO devices"
HOMEPAGE="https://github.com/analogdevicesinc/libiio"

EGIT_REPO_URI="https://github.com/analogdevicesinc/libiio"
KEYWORDS=""

LICENSE="LGPL-2.1"
SLOT="0/${PV}"

RDEPEND="dev-libs/libxml2:=
	virtual/libusb:1="

DEPEND="${RDEPEND}"

inherit cmake-utils git-r3
