# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Stable kernel pre-release wifi subsystem backport"
HOMEPAGE="http://wireless.kernel.org/en/users/Download/stable"
MY_P=${P/_rc/-rc}
SRC_URI="http://www.orbit-lab.org/kernel/compat-wireless-2.6-stable/v2.6.30/${MY_P}.tar.bz2"

PROVIDES="net-wireless/athload"
DEPENDS="!net-wireless/athload"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="kernel_linux"

S=${WORKDIR}/${MY_P}

src_compile() {
    emake || die "emake failed"
}

src_install() {
    emake DESTDIR="${D}" install || die "install failed"
    dodoc README || die
}

