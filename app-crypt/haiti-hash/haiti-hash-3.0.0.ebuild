# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby32 ruby33"

RUBY_FAKEGEM_EXTRAINSTALL="data"

inherit ruby-fakegem

DESCRIPTION="A CLI tool to identify the hash type of a given hash"
HOMEPAGE="https://noraj.github.io/haiti/"

LICENSE="MIT"
SLOT="0"
#wait for dev-ruby/paint
KEYWORDS="~amd64 ~x86"

# not bundled in the gem
RESTRICT="test"

ruby_add_rdepend "
	=dev-ruby/docopt-0.6*
	=dev-ruby/paint-2.3*
"
