# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby23 ruby24 ruby25"

RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

DESCRIPTION="DataMapper plugin for serializing Resources and Collections"
HOMEPAGE="https://github.com/datamapper/dm-serializer"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE=""

RESTRICT="test"

#may be required?
#each_ruby_install() {
#	each_fakegem_install
#	ruby_fakegem_doins -r {autotest,benchmarks,spec,tasks}
#}
