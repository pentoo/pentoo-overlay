# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/hivex/hivex-1.3.7-r1.ebuild,v 1.1 2013/03/31 09:03:29 maksbotan Exp $

EAPI=5

AUTOTOOLS_IN_SOURCE_BUILD=1
AUTOTOOLS_AUTORECONF=1
WANT_AUTOMAKE=1.11

USE_RUBY="ruby19"
RUBY_OPTIONAL=yes

PYTHON_COMPAT=( python2_7 )

#SUPPORT_PYTHON_ABIS=1

inherit base autotools autotools-utils eutils perl-app ruby-ng python-r1

DESCRIPTION="Library for reading and writing Windows Registry 'hive' binary files"
HOMEPAGE="http://libguestfs.org"
SRC_URI="http://libguestfs.org/download/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ocaml readline +perl python test static-libs ruby"

RDEPEND="
	virtual/libiconv
	virtual/libintl
	dev-libs/libxml2:2
	ocaml? ( dev-lang/ocaml[ocamlopt]
			 dev-ml/findlib[ocamlopt]
			 )
	readline? ( sys-libs/readline )
	perl? ( dev-perl/IO-stringy )
	ruby? ( $(ruby_implementations_depend) )
	"

DEPEND="${RDEPEND}
	dev-lang/perl
	perl? (
	 	test? ( dev-perl/Pod-Coverage
			dev-perl/Test-Pod-Coverage )
	      )
	"

ruby_add_bdepend "ruby? ( dev-ruby/rake )"
ruby_add_bdepend "ruby? ( virtual/ruby-rdoc )"

DOCS=(README)
PATCHES=("${FILESDIR}"/"${PV}"/*.patch)

S="${WORKDIR}/${P}"

pkg_setup() {
	if use python; then
		python_pkg_setup
	fi
	if use perl; then
		perl-module_pkg_setup
	fi
}

src_unpack() {
	default
}

src_prepare() {
	base_src_prepare
	eautomake
}

src_configure() {
	local myeconfargs=(
		$(use_with readline)
		$(use_enable ocaml)
		$(use_enable perl)
		--enable-nls
		$(use_enable python)
		$(use_enable ruby)
		--disable-rpath )

	autotools-utils_src_configure

	if use perl; then
		pushd perl
		perl-app_src_configure
		popd
	fi
}

src_compile() {
	autotools-utils_src_compile
}

src_test() {
	if use perl;then
		pushd perl
		perl-app_src_install
		popd
	fi

	autotools-utils_src_compile check
}

src_install() {
	strip-linguas -i po

	autotools-utils_src_install "LINGUAS=""${LINGUAS}"""

	if use perl; then
		fixlocalpod
	fi
	if use python; then
		compile_and_install() {
			emake -C python clean
			emake -C python PYTHON_VERSION="${PYTHON_ABI}" \
							PYTHON_INCLUDEDIR="$(python_get_includedir)" \
							PYTHON_INSTALLDIR="$(python_get_sitedir)" \
							DESTDIR="${ED}" install
		}
		python_execute_function compile_and_install
	fi
}
