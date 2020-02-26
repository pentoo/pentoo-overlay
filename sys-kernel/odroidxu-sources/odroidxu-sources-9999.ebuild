# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

K_SECURITY_UNSUPPORTED="1"
K_DEBLOB_AVAILABLE="1"
ETYPE="sources"
CKV='3.4.99'
inherit kernel-2 git-r3
detect_version

DESCRIPTION="Linux kernel source for the ODROIDXU products"
HOMEPAGE="https://github.com/hardkernel/linux"
EGIT_REPO_URI="https://github.com/hardkernel/linux.git"
EGIT_BRANCH="odroidxu-3.4.y"
EGIT_CHECKOUT_DIR="${WORKDIR}/linux-${KV_FULL}"

#unsupported
KEYWORDS=""
IUSE="deblob"
