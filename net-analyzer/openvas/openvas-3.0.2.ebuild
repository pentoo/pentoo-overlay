# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="A remote security scanner"
HOMEPAGE="http://www.openvas.org/"
SLOT="3"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="cli gtk webgui"

DEPEND=""

RDEPEND="net-analyzer/openvas-scanner:3
	gtk? ( net-analyzer/openvas-client:3 )
	cli? ( net-analyzer/openvas-cli:3 )
	webgui? ( net-analyzer/openvas-gsa:3 )"
