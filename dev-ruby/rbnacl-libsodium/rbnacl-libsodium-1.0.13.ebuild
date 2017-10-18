# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23 ruby24"

inherit ruby-fakegem

DESCRIPTION="rbnacl with bundled libsodium"
HOMEPAGE="https://github.com/cryptosphere/rbnacl-libsodium"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="  >=dev-ruby/rbnacl-3.0.1 "
