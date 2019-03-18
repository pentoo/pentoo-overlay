# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby24 ruby25"

inherit ruby-fakegem

DESCRIPTION="WebDriver-backed Watir"
HOMEPAGE="http://rubygems.org/gems/watir-webdriver"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

ruby_add_rdepend "
	>=dev-ruby/selenium-webdriver-2.46.2
"
