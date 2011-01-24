# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

USE_RUBY="ruby18 ruby19"
RUBY_FAKEGEM_EXTRADOC="readme.txt readme.sj ChangeLog"

inherit ruby-fakegem

DESCRIPTION="Rjb is a Ruby-Java bridge"
HOMEPAGE="http://rjb.rubyforge.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

each_ruby_configure() {
	export JAVA_HOME=/etc/java-config-2/current-system-vm # <-- HACK !
	${RUBY} -C ext extconf.rb || die "extconf.rb failed"
}

each_ruby_compile() {
	cd ext
	emake CFLAGS="${CFLAGS} -fPIC" archflags="${LDFLAGS}" || die "emake failed"
}

each_ruby_install() {
	each_fakegem_install

	local dest="${D}/$(ruby_fakegem_gemsdir)/gems/${P}"

	# Untar the "data" tarball
	tar -mxf ../data.tar.gz -C "${dest}" || die "untarring failed"

	# Copy compiled extension into lib dir
	cp ext/*.so "${dest}"/lib || die "copying lib failed"

	# Copy everyting from ext, just in case
	cp -r ext "${dest}" || die "copying ext failed"

	# ...but remove some junk we know we won't need
	cd "${dest}"
	rm -f ext/*.o ext/mkmf.log > /dev/null 2>&1
	rm -f ${RUBY_FAKEGEM_EXTRADOC} COPYING > /dev/null 2>&1 # already in /usr/share/doc
}
