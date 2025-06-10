# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
LAST_COMMIT="0aeb29ed29cb4dd7318ab2f1bfdd98c5b8236a6f"

inherit distutils-r1

DESCRIPTION="Pure Python package for reading and parsing libpcap savefiles"
HOMEPAGE="https://github.com/kisom/pypcapfile"
SRC_URI="https://github.com/kisom/${PN}/archive/${LAST_COMMIT}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${PN}-${LAST_COMMIT}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

distutils_enable_sphinx "doc/source"

src_prepare() {
	sed -i -e "/data_files/,+2d" "setup.py"
	eapply_user
}

python_test() {
	"${EPYTHON}" pcapfile/test/ || die "Tests have failed with ${EPYTHON}"
}
