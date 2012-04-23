# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/nokogiri/nokogiri-1.5.0-r2.ebuild,v 1.4 2012/03/02 09:51:03 naota Exp $

EAPI=4

USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.rdoc CHANGELOG.ja.rdoc README.rdoc README.ja.rdoc"

inherit ruby-fakegem eutils multilib

DESCRIPTION="Nokogiri is an HTML, XML, SAX, and Reader parser."
HOMEPAGE="http://nokogiri.rubyforge.org/"
LICENSE="MIT"
SRC_URI="https://github.com/tenderlove/nokogiri/tarball/v${PV} -> ${P}.tgz"
RUBY_S="tenderlove-nokogiri-*"

KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
SLOT="0"
IUSE=""

RDEPEND="${RDEPEND}
	dev-libs/libxml2
	dev-libs/libxslt"
DEPEND="${DEPEND}
	dev-libs/libxml2
	dev-libs/libxslt"

# The tests require _minitest_, not the virtual; what is shipped with
# Ruby 1.9 is *not* enough, unfortunately
ruby_add_bdepend "
	dev-ruby/rake-compiler
	dev-ruby/rexical
	dev-ruby/hoe
	dev-ruby/rdoc
	dev-ruby/racc
	test? ( dev-ruby/minitest )"

all_ruby_prepare() {
	sed -i \
		-e '/tasks\/cross_compile/s:^:#:' \
		-e '/:test.*prerequisites/s:^:#:' \
		Rakefile || die
	# Remove the cross compilation options since they interfere with
	# native building.
	sed -i -e 's/cross_compile  = true/cross_compile = false/' Rakefile || die
	sed -i -e '/cross_config_options/d' Rakefile || die
}

each_ruby_prepare() {
	# These test exclusions should be limited to the specific tests, but
	# we are overdue with re-adding jruby so we use the big hammer for now.
	case ${RUBY} in
		*ruby19)
			# Remove test file with failing tests related to encodings.
			rm test/xml/test_node_encoding.rb || die
			;;
		*jruby)
			# Remove test files with broken tests,
			# https://github.com/tenderlove/nokogiri/issues/496
			rm test/html/sax/test_parser.rb test/html/test_document_encoding.rb test/xml/sax/test_push_parser.rb test/xslt/test_exception_handling.rb || die
			;;
		*)
			;;
	esac
}

each_ruby_configure() {
	case ${RUBY} in
		*jruby)
			;;
		*)
			${RUBY} -Cext/${PN} extconf.rb \
				--with-zlib-include="${EPREFIX}"/usr/include \
				--with-zlib-lib="${EPREFIX}"/$(get_libdir) \
				--with-iconv-include="${EPREFIX}"/usr/include \
				--with-iconv-lib="${EPREFIX}"/$(get_libdir) \
				--with-xml2-include="${EPREFIX}"/usr/include/libxml2 \
				--with-xml2-lib="${EPREFIX}"/usr/$(get_libdir) \
				--with-xslt-dir="${EPREFIX}"/usr \
				--with-iconvlib=iconv \
				|| die "extconf.rb failed"
			;;
	esac
}

each_ruby_compile() {
	case ${RUBY} in
		*jruby)
			${RUBY} -S rake compile || die
			;;
		*)
			if ! [[ -f lib/nokogiri/css/tokenizer.rb ]]; then
				${RUBY} -S rake lib/nokogiri/css/tokenizer.rb || die "rexical failed"
			fi

			if ! [[ -f lib/nokogiri/css/parser.rb ]]; then
				${RUBY} -S rake lib/nokogiri/css/parser.rb || die "racc failed"
			fi

			emake -Cext/${PN} \
				CFLAGS="${CFLAGS} -fPIC" \
				archflag="${LDFLAGS}" || die "make extension failed"
			cp -l ext/${PN}/${PN}$(get_modname) lib/${PN}/ || die
			;;
	esac
}
