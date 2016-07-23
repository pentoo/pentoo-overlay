# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="bluetooth discovery service built on top of bluez"
HOMEPAGE="https://github.com/pwnieexpress/blue_hydra"
SRC_URI=""

LICENSE="BSD-3"
SLOT="0"
USE_RUBY="ruby21"
inherit git-r3 ruby-ng
#KEYWORDS="amd64 x86 arm"
KEYWORDS=""
EGIT_REPO_URI="https://github.com/pwnieexpress/blue_hydra.git"
EGIT_CHECKOUT_DIR="${WORKDIR}"/all
IUSE="ubertooth"

DEPEND=""
PDEPEND="dev-python/dbus-python
	 net-wireless/bluez[test-programs]
	 ubertooth? ( net-wireless/ubertooth )"

ruby_add_bdepend "dev-ruby/bundler"
ruby_add_rdepend "dev-ruby/dm-core
		  dev-ruby/dm-sqlite-adapter"

#RUBY_S="${WORKDIR}/${P}"

all_ruby_unpack () {
	if [[ ${PV} == "9999" ]]; then
		git-r3_src_unpack
	else
		default_src_unpack
	fi
}

#each_ruby_prepare() {
#	sed -e \
#	"1s:^#![[:space:]]*\([^[:space:]]*/usr/bin/env[[:space:]]\)\?[[:space:]]*\([^[:space:]]*/\)\?ruby\([[:digit:]]\+\(\.[[:digit:]]\+\)\?\)\?\(\$\|[[:space:]].*\):#!\1\2${RUBY}:" \
#	-i "bin/blue_hydra" || die "Conversion of shebang in 'bin/blue_hydra' failed"
#}

each_ruby_test() {
	${RUBY} -S rspec || die
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
		if [ -f Gemfile.lock ]; then
			rm Gemfile.lock
		fi
		${RUBY} -S bundle exec ./bin/blue_hydra \$@
	EOF
	fperms +x /usr/sbin/blue_hydra
}
