# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit enlightenment

DESCRIPTION="Enlightenment's integration to IO"
SRC_URI="http://download.enlightenment.org/releases/${P}.tar.bz2"
KEYWORDS="~amd64 ~x86"
LICENSE="BSD"

IUSE="static-libs +threads"

RDEPEND=">=dev-libs/ecore-1.7.0"
DEPEND="${RDEPEND}"

src_configure() {
	MY_ECONF="$(use_enable threads posix-threads)"
	enlightenment_src_configure
}
