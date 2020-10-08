# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )
inherit distutils-r1

DESCRIPTION="Universal Command Line Interface for Amazon Web Services"
HOMEPAGE="https://github.com/aws/aws-cli"
SRC_URI="https://github.com/aws/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="test"

RDEPEND="
	dev-python/tox[${PYTHON_USEDEP}]
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/botocore[${PYTHON_USEDEP}]
	dev-python/s3transfer[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/rsa[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/wcwidth
	<dev-python/prompt_toolkit-3.0.0
	dev-python/distro
"
#	<=dev-python/colorama-0.3.7[${PYTHON_USEDEP}]
##	dev-python/six[${PYTHON_USEDEP}]
##	dev-python/requests[${PYTHON_USEDEP}]
DEPEND="${RDEPEND}
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
	)"

src_prepare() {
	default
	# Unbundled in dev-python/botocore
	grep -rl 'botocore.vendored' | xargs \
		sed -i -e "/import requests/s/from botocore.vendored //" \
		-e "/^from/s/botocore\.vendored\.//" \
		-e "s/^from botocore\.vendored //" \
		-e "s/'botocore\.vendored\./'/" \
		|| die "sed failed"
}

python_test() {
	# Only run unit tests
	nosetests tests/unit || die "Tests fail with ${EPYTHON}"
}
