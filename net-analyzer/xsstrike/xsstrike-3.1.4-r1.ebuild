# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_5,3_6,3_7} )
inherit python-single-r1

KEYWORDS="~amd64 ~x86"
SRC_URI="https://github.com/s0md3v/XSStrike/archive/${PV}.tar.gz -> ${P}.tar.gz"
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
exec ./xsstrike.py "\${@}"
EOF
	eapply_user
}

src_install() {
	dobin ${PN}
	python_fix_shebang "${PN}.py"
	insinto "/usr/share/${PN}"
	doins -r core db modes plugins "${PN}.py"
	fperms 0755 "/usr/share/${PN}/${PN}.py"
}
