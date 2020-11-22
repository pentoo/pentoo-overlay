# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=pyproject.toml
PYTHON_COMPAT=( python3_7 )

inherit distutils-r1 git-r3

DESCRIPTION="A swiss army knife for pentesting Windows/Active Directory environments"
HOMEPAGE="https://github.com/byt3bl33d3r/CrackMapExec/releases"

EGIT_REPO_URI="https://github.com/byt3bl33d3r/CrackMapExec.git"
EGIT_COMMIT="f66fa440688493d3f0fce6680699ec91533d5d7b"

#https://github.com/byt3bl33d3r/CrackMapExec/issues/354
#EGIT_OVERRIDE_COMMIT_ARTKOND_INVOKE_VNC="906c7476b9490817a6defa63e86a5b8c52690182"

#do not checkout existing modules
EGIT_SUBMODULES=('*' '-*pywerview' )

LICENSE="BSD-2"
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT="0"

#grep name poetry.lock | awk '{print $3}'
RDEPEND="
	dev-python/gevent[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requests-ntlm[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/lsassy[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/msgpack[${PYTHON_USEDEP}]
	dev-python/neo4j[${PYTHON_USEDEP}]
	dev-python/pylnk3[${PYTHON_USEDEP}]
	dev-python/pypsrp[${PYTHON_USEDEP}]
	dev-python/paramiko[${PYTHON_USEDEP}]
	dev-python/impacket[${PYTHON_USEDEP}]
	dev-python/xmltodict[${PYTHON_USEDEP}]
	dev-python/terminaltables[${PYTHON_USEDEP}]
	dev-python/pywerview[${PYTHON_USEDEP}]
"

QA_FLAGS_IGNORED="usr/lib.*/python.*/site-packages/cme/data/mimipenguin/.*"
QA_PRESTRIPPED="usr/lib.*/python.*/site-packages/cme/data/mimipenguin/.*"

#thirdparty: https://github.com/byt3bl33d3r/CrackMapExec/issues/361
PATCHES=(
	"${FILESDIR}/remove_thirdparty.patch"
	)

src_install() {
	distutils-r1_src_install
	insinto /etc/revdep-rebuild
	doins "${FILESDIR}"/50${PN}
}
