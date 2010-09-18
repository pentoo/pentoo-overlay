# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
KEYWORDS="-*"
DESCRIPTION="Pentoo database attack meta ebuild"
HOMEPAGE="http://www.pentoo.ch"
SLOT="0"
LICENSE="GPL"
IUSE=""

DEPEND=""

#the tools
RDEPEND="${RDEPEND}
	dev-db/minimysqlator
	dev-db/mssqlscan
	dev-db/oat
	dev-db/sqlbf
	dev-db/sqlibf
	dev-db/sqlix
	dev-db/sqlmap
	dev-db/sqlninja
	dev-db/sqid"
