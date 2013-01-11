# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
#K_NOUSENAME="yes"
#K_NOSETEXTRAVERSION="yes"
K_SECURITY_UNSUPPORTED="1"
K_DEBLOB_AVAILABLE="1"
ETYPE="sources"
CKV='3.4.0'
inherit kernel-2 git-2
detect_version

DESCRIPTION="Linux kernel source for the Samsung Chromebook"
HOMEPAGE="http://git.chromium.org/gitweb/?p=chromiumos/third_party/kernel.git;a=shortlog;h=refs/heads/chromeos-3.4"
EGIT_REPO_URI="https://git.chromium.org/git/chromiumos/third_party/kernel.git"
EGIT_BRANCH="chromeos-3.4"

KEYWORDS=""
IUSE="deblob"
