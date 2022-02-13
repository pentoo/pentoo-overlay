# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{9..10} )

inherit eutils python-single-r1

DESCRIPTION="Scan for open AWS S3 buckets and dump the contents"
HOMEPAGE="https://github.com/sa7mon/S3Scanner"

if [[ ${PV} = *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sa7mon/S3Scanner.git"
else
	HASH_COMMIT="28f6ab4e04ddb55b6e0d2f517ced181d5111072a"

	SRC_URI="https://github.com/sa7mon/S3Scanner/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
		app-admin/awscli[${PYTHON_USEDEP}]
		dev-python/boto3[${PYTHON_USEDEP}]
		dev-python/coloredlogs[${PYTHON_USEDEP}]
		dev-python/pytest-xdist[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
	')"
DEPEND="${RDEPEND}"

S="${WORKDIR}/S3Scanner-${HASH_COMMIT}"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	default

	# Dirty hack to actually add a shebang to the file, so that we can then fix
	# it using python_fix_shebang. Without a shebang, python_fix_shebang won't
	# even work.
	sed -i '1i#!/usr/bin/env python' "${PN}.py" || die
	python_fix_shebang "${S}"
}

src_install() {
	insinto /usr/share/${PN}
	doins *.py sites.txt

	python_optimize "${D}/usr/share/${PN}"

	# s3scanner needs to be run from its installation directory.
	make_wrapper $PN \
		"${EPYTHON} /usr/share/${PN}/${PN}.py"

	dodoc README.md Dockerfile
}
