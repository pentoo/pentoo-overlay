# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} pypy3 )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

DESCRIPTION="Python ASN.1 library with a focus on performance and a pythonic API"
HOMEPAGE="https://github.com/wbond/asn1crypto/ https://pypi.org/project/asn1crypto/"
# pypi tarball does not have tests
SRC_URI="https://github.com/wbond/asn1crypto/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND=""
DEPEND="${RDEPEND}"

python_test() {
	esetup.py test
}
