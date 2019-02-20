# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )
EGO_PN=github.com/epinna/${PN}

inherit python-single-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/epinna/tplmap.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="39c7c5bb54cd27489f0e220e7d90339faf3fc5b8"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Server-Side Template Injection and code injection tool"
HOMEPAGE="https://github.com/epinna/tplmap"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/certifi[${PYTHON_USEDEP}]
		dev-python/chardet[${PYTHON_USEDEP}]
		dev-python/idna[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/urllib3[${PYTHON_USEDEP}]
		dev-python/wsgiref[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

src_prepare() {
	python_fix_shebang "${PN}.py"
	eapply_user
}

src_install(){
	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins -r *

	fperms +x /usr/share/${PN}/${PN}.py

	# tplmap needs to be run from its installation directory.
	insinto /usr/bin
	doins "${FILESDIR}/${PN}"
	fperms +x /usr/bin/${PN}
}
