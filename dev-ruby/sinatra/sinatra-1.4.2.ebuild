# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"

# no documentation is generable, it needs hanna, which is broken
RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="AUTHORS CHANGES"

inherit ruby-fakegem versionator

DESCRIPTION="Sinatra is a DSL for quickly creating web applications in Ruby with minimal effort."
HOMEPAGE="http://www.sinatrarb.com/"

LICENSE="MIT"
SLOT="$(get_version_component_range 1-2)"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_rdepend "=dev-ruby/rack-1* >=dev-ruby/rack-1.4
	>=dev-ruby/rack-protection-1.4:1
	=dev-ruby/tilt-1* >=dev-ruby/tilt-1.3.4"
ruby_add_bdepend "test? ( >=dev-ruby/rack-test-0.5.6 >=dev-ruby/haml-3.0 dev-ruby/erubis dev-ruby/builder )"
