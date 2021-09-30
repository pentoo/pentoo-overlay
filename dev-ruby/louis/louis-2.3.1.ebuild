# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27 ruby27"

RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.md"
RUBY_FAKEGEM_EXTRAINSTALL="data"
RUBY_FAKEGEM_TASK_TEST="spec"

inherit ruby-fakegem

DESCRIPTION="Lookup mac address assignments in the iana database"
HOMEPAGE="https://github.com/pwnieexpress/louis"

LICENSE="AGPL-3+"
SLOT="0"
KEYWORDS="amd64 ~arm x86"

RESTRICT="test"
