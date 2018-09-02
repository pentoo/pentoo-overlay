# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23 ruby24 ruby25"

RUBY_FAKEGEM_GEMSPEC="libv8.gemspec"

inherit ruby-fakegem

DESCRIPTION="Distributes the V8 JavaScript engine in binary and source forms"
HOMEPAGE="https://github.com/cowboyd/libv8"
SRC_URI="mirror://rubygems/${P}.gem"

LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

all_ruby_prepare() {
	#fix mksnapshot segmentation fault
	epatch "${FILESDIR}/libv8-nosnapshot.patch"
}

each_ruby_configure() {
	${RUBY} -C ext/libv8 extconf.rb || die "extconf failed"
}

each_ruby_install() {
	each_fakegem_install

	insinto $(ruby_fakegem_gemsdir)/gems/${RUBY_FAKEGEM_NAME}-${RUBY_FAKEGEM_VERSION}/ext/libv8/
	doins ext/libv8/{.location.yml,arch.rb,location.rb,paths.rb}

	insinto $(ruby_fakegem_gemsdir)/gems/${RUBY_FAKEGEM_NAME}-${RUBY_FAKEGEM_VERSION}/vendor/v8/out/x64.release/obj.target/tools/gyp/
	doins vendor/v8/out/x64.release/obj.target/tools/gyp/*.a

	insinto $(ruby_fakegem_gemsdir)/gems/${RUBY_FAKEGEM_NAME}-${RUBY_FAKEGEM_VERSION}/vendor/v8/
	doins -r vendor/v8/include/

}
