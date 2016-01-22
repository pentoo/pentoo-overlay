# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

USE_RUBY="ruby20 ruby21 ruby22"

RUBY_FAKEGEM_TASK_DOC=""

inherit ruby-fakegem

DESCRIPTION="Ruby DNS library, with a clean OO interface and an extensible API"
HOMEPAGE="https://github.com/bluemonk/net-dns"

LICENSE="Ruby-BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~arm"
IUSE=""
