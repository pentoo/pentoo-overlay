# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-single-r1

CUR_COMMIT="9fdc4d7e7cd4"

DESCRIPTION="Web Reconnaissance Framework"
HOMEPAGE="https://bitbucket.org/LaNMaSteR53/recon-ng"
SRC_URI="https://bitbucket.org/LaNMaSteR53/recon-ng/get/v${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	>=dev-python/dicttoxml-1.6.6
	virtual/python-dnspython
	>=dev-python/jsonrpclib-0.1.3
	>=dev-python/lxml-3.4.4
	>=dev-python/mechanize-0.2.5
	>=dev-python/slowaes-0.1
	>=dev-python/xlsxwriter-0.7.3
	>=dev-python/PyPDF2-1.25.1
	>=dev-python/olefile-0.42.1
	"
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
