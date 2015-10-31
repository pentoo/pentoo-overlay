# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils git-r3

DESCRIPTION="This is a userspace tool to manage encrypted ext4 directories since Linux kernel 4.1 introduced native encryption"
HOMEPAGE="https://github.com/gdelugre/ext4-crypt"
SRC_URI=""

EGIT_REPO_URI="https://github.com/gdelugre/ext4-crypt"
EGIT_CHECKOUT_DIR="${WORKDIR}/${PN}-9999"

SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}
		app-crypt/libscrypt
		sys-apps/keyutils
		"
