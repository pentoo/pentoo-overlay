# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby27 ruby30 ruby31"
RUBY_FAKEGEM_EXTRAINSTALL="vendor"

inherit ruby-fakegem

DESCRIPTION="CKEditor is a javascript library of the WYSIWYG rich-text editor"
HOMEPAGE="https://github.com/tsechingho/ckeditor-rails"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
