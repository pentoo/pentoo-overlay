# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6} )
PYTHON_REQ_USE="sqlite"

inherit python-r1

DESCRIPTION="Web Reconnaissance Framework"
HOMEPAGE="https://bitbucket.org/LaNMaSteR53/recon-ng https://github.com/lanmaster53/recon-ng"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://bitbucket.org/LaNMaSteR53/recon-ng"
else
	SRC_URI="https://github.com/lanmaster53/recon-ng/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT=0
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/dicttoxml[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	>=dev-python/mechanize-0.4.2[${PYTHON_USEDEP}]
	dev-python/xlsxwriter[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/unicodecsv[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/dnspython[${PYTHON_USEDEP}]"

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
