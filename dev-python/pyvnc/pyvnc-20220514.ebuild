# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )
inherit distutils-r1

MY_PN="pyVNC"

DESCRIPTION="Client library for interacting with a VNC session"
HOMEPAGE="https://github.com/BC-SECURITY/pyVNC"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

if [[ "${PV}" == "2022"* ]]; then
#	inherit git-r3
#	EGIT_REPO_URI="https://github.com/BC-SECURITY/pyVNC.git"
	HASH_COMMIT="a565e9b5f1c076ebcfda6234700b723e204bcafc"
	SRC_URI="https://github.com/BC-SECURITY/pyVNC/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${MY_PN}-${HASH_COMMIT}"
else
	SRC_URI="https://github.com/BC-SECURITY/pyVNC/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

IUSE=""

RDEPEND="dev-python/twisted[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pygame[${PYTHON_USEDEP}]
	dev-python/service_identity[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

#distutils_enable_tests pytest
