# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
EGO_PN=github.com/s0md3v/XSStrike

inherit python-single-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/s0md3v/XSStrike.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="${PV}"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Advanced XSS detection suite"
HOMEPAGE="https://github.com/s0md3v/XSStrike"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/tld[${PYTHON_USEDEP}]
		dev-python/fuzzywuzzy[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/selenium[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/XSStrike-${PV}"

src_prepare() {
	cat > ${PN} << EOF
#!/bin/sh
cd /usr/share/xsstrike
exec python xsstrike.py "\${@}"
EOF
	eapply_user
}

src_install() {
	dobin ${PN}
	insinto /usr/share/${PN}
	doins -r core db modes ${PN}.py
}
