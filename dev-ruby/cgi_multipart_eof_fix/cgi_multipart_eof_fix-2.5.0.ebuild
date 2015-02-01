# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

USE_RUBY="ruby19"

inherit ruby-fakegem versionator

DESCRIPTION="Fix an exploitable bug in CGI multipart parsing."
HOMEPAGE="https://github.com/merbist/cgi_multipart_eof_fix"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="LGPL"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""
