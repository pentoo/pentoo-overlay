# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

USE_RUBY="ruby26 ruby27"

inherit ruby-fakegem

DESCRIPTION="wrapper for exiftool"
HOMEPAGE="https://rubygems.org/gems/mini_exiftool"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE=""

RDEPEND="media-libs/exiftool"
