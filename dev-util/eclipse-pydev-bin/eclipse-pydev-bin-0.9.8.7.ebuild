# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /root/portage/dev-util/eclipse-pydev-bin/eclipse-pydev-bin-0.9.8.7.ebuild,v 1.1.1.1 2006/03/09 22:54:57 grimmlin Exp $

inherit eclipse-ext

MY_PV=${PV//\./_}

DESCRIPTION="Python Development Tools for Eclipse"
HOMEPAGE="http://pydev.sourceforge.net"
SRC_URI="mirror://sourceforge/pydev/org.python.pydev.feature-${MY_PV}.zip"
SLOT="1"
LICENSE="CPL-1.0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=dev-util/eclipse-sdk-3.1
	>=dev-lang/python-2.3"

S=${WORKDIR}

src_compile() {
	einfo "${P} is a binary package"
}

src_install () {
	eclipse-ext_require-slot 3.1 || die "Failed to find suitable Eclipse installation"

	eclipse-ext_create-ext-layout binary || die "Failed to create layout"

	eclipse-ext_install-features eclipse/features/* || die "Failed to install features"
	eclipse-ext_install-plugins eclipse/plugins/* || die "Failed to install plugins"
}
