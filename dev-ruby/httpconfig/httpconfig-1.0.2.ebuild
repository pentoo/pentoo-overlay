# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gems

USE_RUBY="ruby18"

DESCRIPTION="set configuration for Net::HTTP"
HOMEPAGE="http://rubyforge.org/projects/httpconfig/"
MY_P="${P/httpconfig/http_configuration}"
SRC_URI="mirror://rubygems/${MY_P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
