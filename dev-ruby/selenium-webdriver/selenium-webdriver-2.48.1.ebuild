# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

USE_RUBY="ruby21"

inherit ruby-fakegem

DESCRIPTION="A tool for writing automated tests of websites"
HOMEPAGE="http://rubygems.org/gems/watir-webdriver"

LICENSE="Apache-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

ruby_add_rdepend "
	dev-ruby/childprocess:2
	=dev-ruby/multi_json-1*
	dev-ruby/rubyzip:1
	=dev-ruby/websocket-1*
"

#ruby_add_bdepend "
#	test? (
#ci_reporter >= 1.6.2, ~> 1.6
#rack ~> 1.0
#rspec ~> 2.99.0
#webmock >= 1.7.5, ~> 1.7
#yard ~> 0.8.7
