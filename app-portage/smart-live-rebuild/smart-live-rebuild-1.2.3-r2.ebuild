# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/smart-live-rebuild/smart-live-rebuild-1.2.3-r2.ebuild,v 1.1 2012/10/15 08:09:59 mgorny Exp $

EAPI=4
PYTHON_COMPAT=(python2_6 python2_7 python3_1 python3_2)

inherit distutils-r1 eutils

DESCRIPTION="Check live packages for updates and emerge them as necessary"
HOMEPAGE="https://bitbucket.org/mgorny/smart-live-rebuild/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=app-portage/gentoopm-0.2.1[${PYTHON_USEDEP}]"

src_prepare() {
	epatch "${FILESDIR}"/one.patch
	epatch "${FILESDIR}"/two.patch
	epatch "${FILESDIR}"/three.patch
}

python_test() {
	"${PYTHON}" setup.py test || die
}

python_install_all() {
	distutils-r1_python_install_all

	insinto /etc/portage
	newins smart-live-rebuild.conf{.example,}
	insinto /usr/share/portage/config/sets
	newins sets.conf.example ${PN}.conf
}
