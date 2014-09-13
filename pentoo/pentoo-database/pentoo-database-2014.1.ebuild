# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Pentoo database attack meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
KEYWORDS="~amd64 ~arm ~x86"
SLOT="0"
LICENSE="GPL-3"
IUSE="minipentoo"

PDEPEND="
	dev-db/sqlmap
	dev-db/sqlitebrowser
	!minipentoo? (
		net-analyzer/sqlninja
		dev-db/minimysqlator
		dev-db/mssqlscan
		dev-db/oat
		dev-db/sqlibf
	)
"
