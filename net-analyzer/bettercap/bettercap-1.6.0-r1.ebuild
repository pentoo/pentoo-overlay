# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby21 ruby22 ruby23"

inherit multilib ruby-fakegem

DESCRIPTION="A complete, modular, portable and easily extensible MITM framework"
HOMEPAGE="https://github.com/evilsocket/bettercap/"
SRC_URI="https://github.com/evilsocket/bettercap/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT=0
KEYWORDS="~amd64"

ruby_add_bdepend "dev-ruby/bundler"

ruby_add_rdepend "
	=dev-ruby/colorize-0.8*
	=dev-ruby/net-dns-0.8*
	dev-ruby/network_interface
	>=dev-ruby/packetfu-1.1.10:*
	dev-ruby/pcaprub:0.12
	=dev-ruby/em-proxy-0.1*
	=dev-ruby/rubydns-2.0*
"

each_ruby_prepare() {
	sed -e "s|'rubydns', '~> 1.0', '>= 1.0.3'|'rubydns'|" -i bettercap.gemspec

	BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
	BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
}

# FIXME:
# install bettercap binary into /usr/sbin
