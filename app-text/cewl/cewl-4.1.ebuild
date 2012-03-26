# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit ruby

USE_RUBY="ruby18 ruby19"

DESCRIPTION="a custom word list generator"
HOMEPAGE="http://www.digininja.org/projects/cewl.php"
SRC_URI="http://www.digininja.org/files/${PN}_${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-ruby/hpricot
		 dev-ruby/http_configuration
		 dev-ruby/spider
		 dev-ruby/mime-types
		 dev-ruby/rubyzip
		 dev-ruby/mini_exiftool"

S="${WORKDIR}"/$PN

src_install() {
	ruby_einstall "$@"
	dobin "$FILESDIR"/$PN || die "install failed"
}
