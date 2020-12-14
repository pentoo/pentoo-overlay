# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26"

RUBY_FAKEGEM_EXTRAINSTALL="app spec"

inherit ruby-fakegem

DESCRIPTION="Metasploit concern allows you to define concerns in app/concerns. "
HOMEPAGE="https://github.com/rapid7/metasploit-concern"
SRC_URI="https://rubygems.org/gems/${P}.gem"

LICENSE="BSD"
SLOT="$(ver_cut 1-2)"
KEYWORDS="~amd64 ~arm64 ~x86"
#IUSE="development test"
RESTRICT=test
IUSE=""

RDEPEND="${RDEPEND} !dev-ruby/metasploit-concern:0"

ruby_add_rdepend ">=dev-ruby/railties-5.2.2:5.2
		>=dev-ruby/activesupport-5.2.2:5.2
		>=dev-ruby/activemodel-5.2.2:5.2"
