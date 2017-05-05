# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby21 ruby22 ruby23 ruby24"

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
KEYWORDS="~x86 ~amd64 ~arm"
IUSE=""

RESTRICT="test"
