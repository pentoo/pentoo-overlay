# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
#inherit python-single-r1

#PYTHON_COMPAT=( python{2_7,3_5,3_6} )
inherit python-r1

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://bitbucket.org/LaNMaSteR53/recon-ng"
	KEYWORDS=""
else
	CUR_COMMIT="c83599e52159"
	SRC_URI="https://bitbucket.org/LaNMaSteR53/recon-ng/get/v${PV}.tar.bz2 -> ${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/LaNMaSteR53-${PN}-${CUR_COMMIT}"
fi

DESCRIPTION="Web Reconnaissance Framework"
HOMEPAGE="https://bitbucket.org/LaNMaSteR53/recon-ng"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	>=dev-python/dicttoxml-1.6.6[${PYTHON_USEDEP}]
	virtual/python-dnspython[${PYTHON_USEDEP}]
	>=dev-python/jsonrpclib-0.1.3[${PYTHON_USEDEP}]
	>=dev-python/lxml-3.4.4[${PYTHON_USEDEP}]
	>=dev-python/mechanize-0.2.5[${PYTHON_USEDEP}]
	>=dev-python/slowaes-0.1[${PYTHON_USEDEP}]
	>=dev-python/xlsxwriter-0.7.3[${PYTHON_USEDEP}]
	>=dev-python/PyPDF2-1.25.1[${PYTHON_USEDEP}]
	>=dev-python/olefile-0.42.1[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/unicodecsv[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

pkg_setup() {
	python_setup
}

src_install() {
	default
	dodir /usr/share/"${PN}"/
	cp -R * "${ED}"/usr/share/"${PN}"/
	dosym "${EPREFIX}"/usr/share/"${PN}"/recon-rpc /usr/bin/recon-rpc
	dosym "${EPREFIX}"/usr/share/"${PN}"/recon-cli /usr/bin/recon-cli
	dosym "${EPREFIX}"/usr/share/"${PN}"/recon-ng /usr/bin/recon-ng

	python_fix_shebang "${ED}"usr/share/${PN}/
}
