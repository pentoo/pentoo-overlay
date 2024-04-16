# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C library for easy access and configuration of mobile network modems"
HOMEPAGE="https://github.com/falkenber9/c-mnalib"

SRC_URI="https://github.com/falkenber9/c-mnalib/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"
