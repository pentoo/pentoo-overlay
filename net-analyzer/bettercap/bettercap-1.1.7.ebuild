# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"

inherit multilib ruby-fakegem

DESCRIPTION="A complete, modular, portable and easily extensible MITM framework"
HOMEPAGE="https://github.com/evilsocket/bettercap/"

LICENSE="GPL-3"
SLOT=0
KEYWORDS="~amd64 ~arm ~x86"

ruby_add_rdepend "
	dev-ruby/colorize
	dev-ruby/packetfu:1.1.11
	dev-ruby/pcaprub:0.12
"
# FIXME:
# install bettercap binary into /usr/sbin
