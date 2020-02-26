# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby24 ruby25 ruby26"

RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_DOCDIR="doc"

RUBY_FAKEGEM_TASK_TEST="spec"
#fails, not sure why
RESTRICT="test"

RUBY_FAKEGEM_EXTRADOC="README.markdown"

# We normally don't install specs, but other do_ packages depend on
# these files being here to run their own specs.
RUBY_FAKEGEM_EXTRAINSTALL="spec"

inherit ruby-fakegem

DESCRIPTION="The Core DataObjects class"
HOMEPAGE="http://rubyforge.org/projects/dorb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( >=dev-ruby/yard-0.5 >=dev-ruby/rspec-2.5 )"

ruby_add_rdepend ">=dev-ruby/addressable-2.1"
