# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

USE_RUBY="ruby18 ruby19"

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
KEYWORDS="~x86 ~amd64"
IUSE=""

#ruby_add_bdepend "doc? ( >=dev-ruby/jeweler-1.6.4 )"

ruby_add_rdepend ">=dev-ruby/data_objects-0.10.6 >=dev-ruby/dm-core-1.2.0"
