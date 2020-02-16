# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1

DESCRIPTION="Python library for reading and writing Windows shortcut files"
HOMEPAGE="https://sourceforge.net/projects/pylnk/"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"
#HASH_COMMIT="c0c2f7451d435b64ed8899aa0cc650c817208043"
#SRC_URI="https://github.com/strayge/pylnk/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

#S="${WORKDIR}/${PN}-${HASH_COMMIT}"

#src_prepare(){
#	sed -e 's|pylnk3|pylnk|' -i setup.py || die "sed failed"
#	eapply_user
#}
