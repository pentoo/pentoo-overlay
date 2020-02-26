# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

K_SECURITY_UNSUPPORTED="1"
K_DEBLOB_AVAILABLE="1"
ETYPE="sources"
CKV='3.4.0'
#ETYPE="sources"
#CKV="${PV/99/}"

inherit kernel-2 git-r3
detect_version

DESCRIPTION="Linux kernel source for the Samsung Chromebook"
HOMEPAGE="https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.4"
EGIT_REPO_URI="https://chromium.googlesource.com/chromiumos/third_party/kernel"
EGIT_BRANCH="chromeos-3.4"
EGIT_CHECKOUT_DIR="${WORKDIR}/linux-${KV_FULL}"

#unsupported
KEYWORDS=""
IUSE="deblob"

pkg_postinst() {
	einfo "if you want to get the default kernel config just run:"
	einfo "./chromeos/scripts/prepareconfig chromeos-exynos5"
}
