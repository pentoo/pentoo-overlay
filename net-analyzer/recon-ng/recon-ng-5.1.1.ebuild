# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )
PYTHON_REQ_USE="sqlite"

inherit python-r1

DESCRIPTION="Web Reconnaissance Framework"
HOMEPAGE="https://github.com/lanmaster53/recon-ng"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lanmaster53/recon-ng"
else
	SRC_URI="https://github.com/lanmaster53/recon-ng/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/dicttoxml[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	>=dev-python/mechanize-0.4.2[${PYTHON_USEDEP}]
	dev-python/xlsxwriter[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/flask-restful[${PYTHON_USEDEP}]
	dev-python/flasgger[${PYTHON_USEDEP}]
	dev-python/unicodecsv[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/rq[${PYTHON_USEDEP}]"

src_prepare() {
	default

	# disable updates checking, add "__version__" variable instead 
	# reading VERSION file and set to latest/current version
	sed -e 's/self._check_version()//' \
		-e "s/exec(open(os.path.join(Path(os.path.abspath(__file__)).parents\[2\], 'VERSION')).read())/__version__ = '${PV}'/" \
		-i recon/core/base.py || die 'sed failed!'
}

src_install() {
	python_foreach_impl python_domodule recon
	python_foreach_impl python_doscript recon-{cli,web,ng}

	dodoc README.md
}

pkg_postinst() {
	einfo "\nSee documentation: https://github.com/lanmaster53/recon-ng/wiki/Getting-Started\n"
}
