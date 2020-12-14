# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby25 ruby26 ruby27"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Memory profiling routines for Ruby 2.1+"
HOMEPAGE="https://github.com/SamSaffron/memory_profiler"
SRC_URI="https://github.com/SamSaffron/memory_profiler/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"

KEYWORDS="amd64 ~arm64 x86"
SLOT="0"
