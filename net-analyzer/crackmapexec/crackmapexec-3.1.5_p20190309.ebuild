# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1

DESCRIPTION="A swiss army knife for pentesting Windows/Active Directory environments"
HOMEPAGE="https://github.com/byt3bl33d3r/CrackMapExec/releases"

if [ "${PV}" == "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/byt3bl33d3r/CrackMapExec.git"
	#use system impacket
	EGIT_SUBMODULES=('*' '-*impacket*')
else
	COMMIT_HASH="a258bcf409e0d2ef3ce90780c8d38a5d9612c663"
	SRC_URI="https://github.com/byt3bl33d3r/CrackMapExec/archive/${COMMIT_HASH}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/CrackMapExec-${COMMIT_HASH}"
fi

LICENSE="BSD-2"
IUSE=""
SLOT="0"

RDEPEND="
	dev-python/asn1crypto[${PYTHON_USEDEP}]
	dev-python/bcrypt[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/cffi[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	virtual/python-enum34[${PYTHON_USEDEP}]
	dev-python/gevent[${PYTHON_USEDEP}]

	dev-python/idna[${PYTHON_USEDEP}]
	virtual/python-ipaddress[${PYTHON_USEDEP}]

	dev-python/msgpack[${PYTHON_USEDEP}]
	dev-python/netaddr[${PYTHON_USEDEP}]
	dev-python/ntlm-auth[${PYTHON_USEDEP}]
	dev-python/paramiko[${PYTHON_USEDEP}]
	dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/pycparser[${PYTHON_USEDEP}]
	dev-python/pylnk[${PYTHON_USEDEP}]
	dev-python/pynacl[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]
	dev-python/requests-ntlm[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/selenium[${PYTHON_USEDEP}]

	dev-python/six[${PYTHON_USEDEP}]
	dev-python/splinter[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/terminaltables[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/xmltodict[${PYTHON_USEDEP}]

	dev-python/impacket[${PYTHON_USEDEP}]
"

QA_FLAGS_IGNORED="usr/lib.*/python.*/site-packages/data/mimipenguin/.*"

#https://github.com/byt3bl33d3r/CrackMapExec/issues/282
PATCHES=( "${FILESDIR}/setup.patch" )

python_prepare_all() {
	sed -i -e "/pycrypto/d" setup.py || die
	sed -i -e "/bs4/d" setup.py || die
	distutils-r1_python_prepare_all
}

python_install(){
	#install data files disabled in setup.patch
	rm -r cme/thirdparty/impacket
	cp -r cme/{data,thirdparty} "${BUILD_DIR}"/lib/cme
	distutils-r1_python_install
}
