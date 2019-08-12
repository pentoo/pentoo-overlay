# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit python-single-r1 eutils

DESCRIPTION="A tool to automate injection attacks and exploit weaknesses in NoSQL"
HOMEPAGE="https://github.com/codingo/NoSQLMap"

HASH_COMMIT="1ccd177b3e0be4aba1cb547b9d4cfd803f8d0f08" # snapshot: 20190709
SRC_URI="https://github.com/codingo/NoSQLMap/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/couchdb-python[${PYTHON_USEDEP}]
	dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/ipcalc[${PYTHON_USEDEP}]
	dev-python/pbkdf2[${PYTHON_USEDEP}]
	dev-python/pymongo[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"

RDEPEND="${DEPEND}"

S="${WORKDIR}/NoSQLMap-${HASH_COMMIT}"

src_prepare() {
	cat > ${PN} << EOF
#!/bin/sh
cd /usr/share/nosqlmap
exec python2 nosqlmap.py "\${@}"
EOF
	eapply_user
}

src_install() {
	insinto "/usr/share/${PN}"
	doins ${PN}.py nsmcouch.py nsmmongo.py nsmscan.py nsmweb.py
	fperms 0755 "/usr/share/${PN}/${PN}.py"
	dobin ${PN}
}
