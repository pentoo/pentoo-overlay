# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
#K_NOUSENAME="yes"
#K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"
K_DEBLOB_AVAILABLE="1"
ETYPE="sources"
CKV='3.4.99'
inherit kernel-2 git-2
detect_version

DESCRIPTION="Linux kernel source for the ODROIDXU products"
HOMEPAGE="https://github.com/hardkernel/linux"
EGIT_REPO_URI="https://github.com/hardkernel/linux.git"
EGIT_BRANCH="odroidxu-3.4.y"

KEYWORDS=""
IUSE="deblob"
