# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27"
RUBY_FAKEGEM_EXTRAINSTALL="vendor"
#RUBY_FAKEGEM_GEMSPEC="ckeditor-rails.gemspec"

inherit ruby-fakegem

DESCRIPTION="CKEditor is a javascript library of the WYSIWYG rich-text editor"
HOMEPAGE="https://github.com/tsechingho/ckeditor-rails"

HASH_COMMIT="16b77cca464ecf78a3318df64bb23f95b297adb2"
SRC_URI="https://github.com/tsechingho/ckeditor-rails/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
#KEYWORDS="~amd64 ~x86"

S="${WORKDIR}"/all/ckeditor-rails-${HASH_COMMIT}
