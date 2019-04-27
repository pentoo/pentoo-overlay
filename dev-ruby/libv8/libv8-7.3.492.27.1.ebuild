# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby24 ruby25"

RUBY_FAKEGEM_GEMSPEC="libv8.gemspec"

inherit ruby-fakegem

DESCRIPTION="Distributes the V8 JavaScript engine in binary and source forms"
HOMEPAGE="https://github.com/cowboyd/libv8"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND+="sys-libs/ncurses:5"

each_ruby_configure() {
	${RUBY} -C ext/libv8 extconf.rb || die "extconf failed"
}

each_ruby_install() {
	each_fakegem_install

	insinto $(ruby_fakegem_gemsdir)/gems/${RUBY_FAKEGEM_NAME}-${RUBY_FAKEGEM_VERSION}/ext/libv8/
	doins ext/libv8/{.location.yml,location.rb,paths.rb}

	insinto $(ruby_fakegem_gemsdir)/gems/${RUBY_FAKEGEM_NAME}-${RUBY_FAKEGEM_VERSION}/vendor/v8/out.gn/libv8/obj/
	doins vendor/v8/out.gn/libv8/obj/*.a

	insinto $(ruby_fakegem_gemsdir)/gems/${RUBY_FAKEGEM_NAME}-${RUBY_FAKEGEM_VERSION}/vendor/v8/
	doins -r vendor/v8/include/

}
