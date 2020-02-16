# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_6,3_7} )

inherit python-single-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sa7mon/S3Scanner.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
	EGIT_COMMIT="28f6ab4e04ddb55b6e0d2f517ced181d5111072a"
	SRC_URI="https://github.com/sa7mon/S3Scanner/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
fi

DESCRIPTION="Scan for open AWS S3 buckets and dump the contents"
HOMEPAGE="https://github.com/sa7mon/S3Scanner"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

MY_PN="S3Scanner"

RDEPEND="dev-python/awscli
    dev-python/boto3
    dev-python/coloredlogs
    dev-python/pytest-xdist
    dev-python/requests"
DEPEND="
    ${RDEPEND}"

S="${WORKDIR}/${MY_PN}-${EGIT_COMMIT}"

src_prepare() {
	# Dirty hack to actually add a shebang to the file, so that we can then fix
    # it using python_fix_shebang. Without a shebang, python_fix_shebang won't
    # even work.
    sed -i '1i#!/usr/bin/env python' "${PN}.py"
	python_fix_shebang "${PN}.py"
	eapply_user
}

src_install(){
	dodir /usr/share/${PN}
    insinto /usr/share/${PN}
    doins "${PN}.py" s3utils.py

    fperms +x "/usr/share/${PN}/${PN}.py"

    # s3scanner needs to be run from its installation directory.
    insinto /usr/bin
    doins "${FILESDIR}/${PN}"
    fperms +x /usr/bin/${PN}
}
