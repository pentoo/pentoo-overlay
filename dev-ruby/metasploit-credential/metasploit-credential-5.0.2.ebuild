# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"

inherit ruby-fakegem

RUBY_FAKEGEM_EXTRAINSTALL="app config db spec"

DESCRIPTION="Code for modeling and managing credentials in Metasploit"
HOMEPAGE="https://github.com/rapid7/metasploit-credential"

LICENSE="BSD"
SLOT="${PV}"
#FIXME: Gentoo's net-ssh/rubyntlm are  not arm64
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE=""
RESTRICT=test

ruby_add_rdepend "dev-ruby/metasploit-concern:4.0
	>=dev-ruby/metasploit_data_models-5.0.0:*
	dev-ruby/metasploit-model
	dev-ruby/net-ssh
	dev-ruby/pg:*
	dev-ruby/railties:6.0
	dev-ruby/rex-socket
	dev-ruby/rubyntlm
	dev-ruby/rubyzip:*"
