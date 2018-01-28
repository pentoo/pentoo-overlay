# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="bluetooth discovery service built on top of bluez"
HOMEPAGE="https://github.com/pwnieexpress/blue_hydra"
SRC_URI=""

LICENSE="BSD-4"
SLOT="0"
USE_RUBY="ruby21 ruby22 ruby23 ruby24"
inherit ruby-ng

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	KEYWORDS=""
	EGIT_REPO_URI="https://github.com/pwnieexpress/blue_hydra.git"
	EGIT_CHECKOUT_DIR="${WORKDIR}"/all
else
	KEYWORDS="amd64 x86 arm"
	#strictly speaking this isn't a blue_hydra version number but the Pwnie Express software release number
	#but close enough for pushing out stable releases
	SRC_URI="https://github.com/pwnieexpress/blue_hydra/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

IUSE="development ubertooth"

DEPEND=""
PDEPEND="dev-python/dbus-python
	 || ( <net-wireless/bluez-5.46[test-programs] >=net-wireless/bluez-5.46[test-programs,deprecated] )
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
	sed -i -e '/simplecov/I s:^:#:' spec/spec_helper.rb || die
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
