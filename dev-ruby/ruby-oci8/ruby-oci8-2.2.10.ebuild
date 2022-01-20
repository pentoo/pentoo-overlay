# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
USE_RUBY="ruby26 ruby27 ruby30"

inherit multilib ruby-fakegem

RUBY_FAKEGEM_EXTRADOC="NEWS README.md ChangeLog"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

DESCRIPTION="A Ruby library for Oracle OCI8"
HOMEPAGE="https://rubygems.org/gems/ruby-oci8/"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-db/oracle-instantclient"
DEPEND="dev-db/oracle-instantclient"

EXT_DIR="ext/oci8"

each_ruby_configure() {
	# configure the native libraries
	${RUBY} -C${EXT_DIR} extconf.rb --prefix="${D}/usr" || die "configure failed"
}

each_ruby_compile() {
	# compile the native libraries
	emake -C ${EXT_DIR} V=1 || die "could not compile native library"
}

each_ruby_install() {
	# install the native libraries
	emake -C ${EXT_DIR} install DESTDIR="${D}" || die "could not install native library"
	# install the gem files
	each_fakegem_install
}
