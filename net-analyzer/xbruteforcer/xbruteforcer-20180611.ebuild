# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit perl-module

DESCRIPTION="Login brute forc tool for WordPress, Joomla, DruPal, OpenCart, and Magento."
HOMEPAGE="https://github.com/Moham3dRiahi/XBruteForcer"
COMMIT="48056437cc1abac05b80bf9aabf6066659a41d8a"
MY_P="XBruteForcer-${COMMIT}"
SRC_URI="https://github.com/Moham3dRiahi/XBruteForcer/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="Unknown"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="dev-lang/perl"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -e 's#/usr/bin/perl.*#/usr/bin/perl#' -i *.pl || die # there's a ^M at the end of shebang from upstream, and there is no perl_fix_shebang to fix this
	eapply_user
}

src_install() {
	dobin XBruteForcer.pl
	dosym XBruteForcer.pl /usr/bin/xbruteforcer
}

