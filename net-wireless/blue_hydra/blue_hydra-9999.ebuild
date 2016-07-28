# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="bluetooth discovery service built on top of bluez"
HOMEPAGE="https://github.com/pwnieexpress/blue_hydra"
SRC_URI=""

LICENSE="BSD-4"
SLOT="0"
USE_RUBY="ruby21"
inherit git-r3 ruby-ng
#KEYWORDS="amd64 x86 arm"
KEYWORDS=""
EGIT_REPO_URI="https://github.com/pwnieexpress/blue_hydra.git"
EGIT_CHECKOUT_DIR="${WORKDIR}"/all
IUSE="development ubertooth"

DEPEND=""
PDEPEND="dev-python/dbus-python
	 net-wireless/bluez[test-programs]
	 ubertooth? ( net-wireless/ubertooth )"

test_deps="dev-ruby/rake dev-ruby/rspec:*"
ruby_add_bdepend "dev-ruby/bundler
		  test? ( ${test_deps} )"
ruby_add_rdepend "dev-ruby/dm-migrations
		  dev-ruby/dm-sqlite-adapter
		  dev-ruby/dm-timestamps
		  dev-ruby/dm-validations
		  dev-ruby/louis
		  development? ( dev-ruby/pry
				 ${test_deps} )"

#RUBY_S="${WORKDIR}/${P}"

all_ruby_unpack () {
	if [[ ${PV} == "9999" ]]; then
		git-r3_src_unpack
	else
		default_src_unpack
	fi
}

all_ruby_prepare() {
	[ -f Gemfile.lock ] && rm Gemfile.lock
	if ! use development; then
		sed -i -e "/^group :development do/,/^end$/d" Gemfile || die
	fi
	if ! use test; then
		sed -i -e "/^group :test do/,/^end$/d" Gemfile || die
	fi
	if ! use test && ! use development; then
		sed -i -e "/^group :test, :development do/,/^end$/d" Gemfile || die
	fi
}

each_ruby_prepare() {
	if [ -f Gemfile ]
	then
		BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
		BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die
	fi
}

each_ruby_test() {
	ruby-ng_rspec || die
}

each_ruby_install() {
	dodir /usr/share/doc/${PF}
	cp -R {README.md,TODO} "${ED}"/usr/share/doc/${PF} || die

	rm -r spec || die
	if [ -f Gemfile.lock ]; then
		rm Gemfile.lock || die
	fi

	dodir /usr/$(get_libdir)/${PN}
	cp -R * "${ED}"/usr/$(get_libdir)/${PN}
	fowners -R root:0 /

	dodir /usr/sbin
	cat <<-EOF > "${ED}"/usr/sbin/blue_hydra
		#! /bin/sh
		cd /usr/$(get_libdir)/${PN}
		exec ${RUBY} -S ./bin/blue_hydra \$@
	EOF
	fperms +x /usr/sbin/blue_hydra

	#touch these files so we know who owns them
	touch blue_hydra.yml blue_hydra_rssi.log blue_hydra.log
}
