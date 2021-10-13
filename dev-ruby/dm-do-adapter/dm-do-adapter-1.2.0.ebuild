# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27"

RUBY_FAKEGEM_TASK_DOC=""
#RUBY_FAKEGEM_TASK_DOC="yard"
#RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="A DataObjects Adapter for DataMapper"
HOMEPAGE="http://datamapper.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#ruby_add_bdepend "doc? ( >=dev-ruby/jeweler-1.6.4 )"

ruby_add_rdepend ">=dev-ruby/data_objects-0.10.6 >=dev-ruby/dm-core-1.2.0"
