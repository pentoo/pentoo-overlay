# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Capture all RabbitMQ messages being sent through a broker"
HOMEPAGE="https://github.com/QKaiser/cottontail"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/QKaiser/cottontail"
else
	HASH_COMMIT="77ed037395a3e98bf5339aa14f6f02c002f3ab51"
	SRC_URI="https://github.com/QKaiser/cottontail/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="
	dev-python/coloredlogs[${PYTHON_USEDEP}]
	dev-python/pika[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/verboselogs[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"
