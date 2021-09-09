# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=pyproject.toml
PYTHON_COMPAT=( python3_{8..9} )
inherit python-utils-r1 distutils-r1

DESCRIPTION="A swiss army knife for pentesting Windows/Active Directory environments"
HOMEPAGE="https://github.com/byt3bl33d3r/CrackMapExec/releases"
#SRC_URI="https://mirrors.neusoft.edu.cn/kali/pool/main/c/crackmapexec/crackmapexec_${PV}.orig.tar.xz"
SRC_URI="https://github.com/byt3bl33d3r/CrackMapExec/archive/refs/tags/v${PV}dev.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT="0"

#pyproject.toml, [tool.poetry.dependencies]
RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requests-ntlm[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/lsassy[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/msgpack[${PYTHON_USEDEP}]
	>=dev-python/neo4j-4.1.1[${PYTHON_USEDEP}]
	dev-python/pylnk3[${PYTHON_USEDEP}]
	>=dev-python/pypsrp-0.5.0[${PYTHON_USEDEP}]
	>=dev-python/paramiko-2.7.2[${PYTHON_USEDEP}]
	dev-python/impacket[${PYTHON_USEDEP}]
	dev-python/xmltodict[${PYTHON_USEDEP}]
	dev-python/terminaltables[${PYTHON_USEDEP}]
	dev-python/aioconsole[${PYTHON_USEDEP}]
	dev-python/pywerview[${PYTHON_USEDEP}]
"

QA_FLAGS_IGNORED="usr/lib.*/python.*/site-packages/cme/data/mimipenguin/.*"
QA_PRESTRIPPED="usr/lib.*/python.*/site-packages/cme/data/mimipenguin/.*"

PATCHES=(
	#thirdparty: https://github.com/byt3bl33d3r/CrackMapExec/issues/361
#	"${FILESDIR}/5.1.4-remove_thirdparty.patch"
	#almost debian patch, bs4 -> beautifulsoup4
	"${FILESDIR}/5.1.4-setup.py.patch"
	)

S="${WORKDIR}/CrackMapExec-${PV}dev"

src_prepare() {
	default
}

#src_install() {
#	distutils-r1_src_install

python_install() {
	distutils-r1_python_install
	insinto /etc/revdep-rebuild
	doins "${FILESDIR}"/50${PN}

	python_optimize "./cme/modules/"
	insinto "$(python_get_sitedir)/cme/data/"
	doins "./cme/data/cme.conf"
	insinto "$(python_get_sitedir)/cme/"
	doins -r "./cme/modules"
}
