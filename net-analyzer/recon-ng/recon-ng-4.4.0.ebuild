# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-single-r1

CUR_COMMIT="c006ecdf2764"

DESCRIPTION="Web Reconnaissance Framework"
HOMEPAGE="https://bitbucket.org/LaNMaSteR53/recon-ng"
SRC_URI="https://bitbucket.org/LaNMaSteR53/recon-ng/get/v${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

S="${WORKDIR}/LaNMaSteR53-${PN}-${CUR_COMMIT}"

src_install() {
	dodir /usr/share/"${PN}"/
	cp -R * "${D}"/usr/share/"${PN}"/
	dosym /usr/share/"${PN}"/recon-rpc /usr/bin/recon-rpc
	dosym /usr/share/"${PN}"/recon-cli /usr/bin/recon-cli
	dosym /usr/share/"${PN}"/recon-ng /usr/bin/recon-ng

	python_fix_shebang "${ED}"/usr/share/recon-ng/
}
