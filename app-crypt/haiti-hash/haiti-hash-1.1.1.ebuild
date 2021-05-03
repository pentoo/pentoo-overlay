# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#wait for ruby30 in dev-ruby/paint
USE_RUBY="ruby26 ruby27"

RUBY_FAKEGEM_EXTRAINSTALL="data/prototypes.json"

inherit ruby-fakegem

DESCRIPTION="A CLI tool to identify the hash type of a given hash"
HOMEPAGE="https://noraj.github.io/haiti/"

#wait for dev-ruby/paint
KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

ruby_add_rdepend "
	=dev-ruby/docopt-0.6*
	=dev-ruby/paint-2*
"

all_ruby_prepare() {
	sed -i -e 's|../data/prototypes.json|../prototypes.json|' lib/haiti.rb || die
	sed -i -e 's|../data/commons.json|../commons.json|' lib/haiti.rb || die
}
