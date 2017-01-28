# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

USE_RUBY="ruby20 ruby21"
#RUBY_FAKEGEM_GEMSPEC="ckeditor-rails.gemspec"
RUBY_FAKEGEM_EXTRAINSTALL="vendor"

inherit ruby-fakegem

DESCRIPTION="CKEditor is a javascript library of the WYSIWYG rich-text editor"
HOMEPAGE="https://github.com/tsechingho/ckeditor-rails"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#all_ruby_prepare() {
#	sed -i -e "s|git ls-files --|find ./|g" ckeditor-rails.gemspec || die
#	sed -i -e "s|git ls-files|find ./|g" ckeditor-rails.gemspec || die
#}
