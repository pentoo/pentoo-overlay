# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_EXTRADOC="readme.txt ChangeLog"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="Rjb is a Ruby-Java software bridge"
HOMEPAGE="http://rjb.rubyforge.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE=""

RDEPEND="virtual/jdk"
DEPEND="virtual/jdk"

each_ruby_configure() {
	export JAVA_HOME=/etc/java-config-2/current-system-vm # <-- HACK !
	${RUBY} -C ext extconf.rb || die "extconf.rb failed"
}

each_ruby_compile() {
	emake -C ext CFLAGS="${CFLAGS} -fPIC" archflags="${LDFLAGS}" || die "emake failed"
}

each_ruby_install() {
	each_fakegem_install

	local dest="${D}/$(ruby_fakegem_gemsdir)/gems/${P}"

	cp ext/*.so "${dest}"/lib || die "copying lib failed"
}

all_ruby_install() {
	insinto /usr/share/rjb/jp/co/infoseek/hp/arton/rjb/
	doins data/rjb/jp/co/infoseek/hp/arton/rjb/RBridge.class || die "installing BRIDGE_FILE failed"
}
