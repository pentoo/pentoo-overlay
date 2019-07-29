# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit python-r1

DESCRIPTION="Web Reconnaissance Framework"
HOMEPAGE="https://bitbucket.org/LaNMaSteR53/recon-ng"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://bitbucket.org/LaNMaSteR53/recon-ng"
else
	CUR_COMMIT="1a691939a77f"
	SRC_URI="https://bitbucket.org/LaNMaSteR53/recon-ng/get/v${PV}.tar.bz2 -> ${P}.tar.bz2"
	KEYWORDS="amd64 ~x86"
	S="${WORKDIR}/LaNMaSteR53-${PN}-${CUR_COMMIT}"
fi

LICENSE="GPL-3"
SLOT=0
IUSE=""

RDEPEND="${PYTHON_DEPS}
	>=dev-python/jsonrpclib-0.1.3[${PYTHON_USEDEP}]
	dev-python/dicttoxml[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/mechanize[${PYTHON_USEDEP}]
	dev-python/slowaes[${PYTHON_USEDEP}]
	dev-python/xlsxwriter[${PYTHON_USEDEP}]
	dev-python/PyPDF2[${PYTHON_USEDEP}]
	dev-python/olefile[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/unicodecsv[${PYTHON_USEDEP}]
	virtual/python-dnspython[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}"

pkg_setup() {
	python_setup
}

src_prepare() {
	python_fix_shebang "${S}"
	default
}

src_install() {
	dodir "/usr/share/${PN}"
	cp -R * "${ED}/usr/share/${PN}/"
	python_optimize "${ED}/usr/share/${PN}"

	for x in recon-*; do
		dosym "../share/${PN}/${x}" "/usr/bin/${x}"
	done

	dodoc README.md
}
