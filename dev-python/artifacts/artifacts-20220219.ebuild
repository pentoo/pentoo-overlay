# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Digital Forensics Artifact Repository"
HOMEPAGE="https://github.com/ForensicArtifacts/artifacts"
SRC_URI="https://github.com/ForensicArtifacts/artifacts/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

DEPEND="
	>=dev-python/pip-7.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.10[${PYTHON_USEDEP}]
	${PYTHON_DEPS}
	test? (
		>=dev-python/mock-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/pbr-4.2.0[${PYTHON_USEDEP}]
		>=dev-python/six-1.1.0[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"

src_prepare() {
	# already fixed in upstream master
	eapply "${FILESDIR}/${PN}"_setup_cfg_license_param.patch
	default
}

python_test() {
	"${EPYTHON}" run_tests.py -v || die
}

python_install_all() {
	distutils-r1_python_install_all

	# move some documentation files to the canonical target path
	mv "${ED}"/usr/share/doc/"${PN}"/* "${ED}"/usr/share/doc/"${PF}"/ || die
	rmdir "${ED}"/usr/share/doc/"${PN}" || die
}
