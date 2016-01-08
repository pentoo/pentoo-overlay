# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

USE_RUBY="ruby21"

inherit ruby-fakegem

DESCRIPTION="WebDriver-backed Watir"
HOMEPAGE="http://rubygems.org/gems/watir-webdriver"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

ruby_add_rdepend "
	>=dev-ruby/selenium-webdriver-2.18.0
"

#ruby_add_bdepend "
#	test? (
#activesupport ~> 3.0
#coveralls >= 0
#fuubar >= 0
#nokogiri >= 0
#pry >= 0
#rake ~> 0.9.2
#rspec ~> 2.6
#sinatra ~> 1.0
#webidl >= 0.1.5
#yard ~> 0.8.2.1
