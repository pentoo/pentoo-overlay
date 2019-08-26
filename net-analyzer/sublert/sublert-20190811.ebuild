# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_{5,6,7}} )
inherit distutils-r1

COMMIT_HASH="f0814ada5a5fbfb430d4473277ddeac6b6778739"

DESCRIPTION="Monitor new subdomains deployed by specific organizations and issued TLS/SSL certificate"
HOMEPAGE="https://github.com/yassineaboukir/sublert"
SRC_URI="https://github.com/yassineaboukir/sublert/archive/${COMMIT_HASH}.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=dev-python/psycopg-2*[${PYTHON_USEDEP}]
	dev-python/argparse[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/tld[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}"

S="${WORKDIR}/sublert-${COMMIT_HASH}"
