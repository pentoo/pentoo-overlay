# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26"

RUBY_FAKEGEM_EXTRAINSTALL="spec"

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

ruby_add_rdepend "dev-ruby/railties:6.0
		dev-ruby/activesupport:6.0
		dev-ruby/activemodel:6.0"
