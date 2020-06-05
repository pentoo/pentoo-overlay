# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/google/rekall.git"
	EGIT_CHECKOUT_DIR="${WORKDIR}/rekall"
	S="${WORKDIR}/rekall/${PN}"
else
	HASH_COMMIT="v${PV}"
	SRC_URI="https://github.com/google/rekall/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/rekall-${PV}/${PN}"
fi

DESCRIPTION="Rekall Memory Forensic Framework"
HOMEPAGE="http://www.rekall-forensic.com/"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~amd64 ~x86"

# Commented out KEYWORDS because this ebuild installs to /usr/manuskript and
# /usr/rekall_gui, which is dirty

RDEPEND=""
DEPEND="${RDEPEND}
	>=app-forensics/rekall-core-1.5[${PYTHON_USEDEP}]
	>=dev-python/codegen-1.0[${PYTHON_USEDEP}]
	>=dev-python/flask-0.10.1[${PYTHON_USEDEP}]
	>=dev-python/gevent-1.0.2[${PYTHON_USEDEP}]
	>=dev-python/gevent-websocket-0.9.3[${PYTHON_USEDEP}]
	dev-python/flask-sockets[${PYTHON_USEDEP}]
"

src_prepare() {
	eapply "${FILESDIR}/rekall-gui-1.7.1-fix-setup.patch"
	eapply_user
}
