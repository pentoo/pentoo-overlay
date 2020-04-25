# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1 git-r3

DESCRIPTION="A swiss army knife for pentesting Windows/Active Directory environments"
HOMEPAGE="https://github.com/byt3bl33d3r/CrackMapExec/releases"

#EGIT_REPO_URI="https://github.com/byt3bl33d3r/CrackMapExec.git"

#python3 support: https://github.com/byt3bl33d3r/CrackMapExec/issues/317
#EGIT_REPO_URI="https://github.com/mpgn/CrackMapExec"
#EGIT_COMMIT="2aca373e33c175d956033bd2b5683fc39ebe44fc"
#EGIT_BRANCH="python3"
EGIT_REPO_URI="https://github.com/byt3bl33d3r/CrackMapExec.git"
EGIT_COMMIT="ec1b6c69cf32c4e754c53611b9dd5faf34303845"

#use system impacket
EGIT_SUBMODULES=('*' '-*impacket*' '-*pywerview' '-*pywinrm')
#EGIT_SUBMODULES=('*' '-*impacket*' '-*pywinrm')

LICENSE="BSD-2"
KEYWORDS="~amd64"
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
	dev-python/gevent[${PYTHON_USEDEP}]

	dev-python/idna[${PYTHON_USEDEP}]

	dev-python/msgpack[${PYTHON_USEDEP}]
	dev-python/netaddr[${PYTHON_USEDEP}]
	dev-python/ntlm-auth[${PYTHON_USEDEP}]
	dev-python/paramiko[${PYTHON_USEDEP}]
	dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/pycparser[${PYTHON_USEDEP}]
	dev-python/pycryptodomex[${PYTHON_USEDEP}]
	dev-python/pylnk3[${PYTHON_USEDEP}]
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
	dev-python/pywinrm[${PYTHON_USEDEP}]
	dev-python/pywerview[${PYTHON_USEDEP}]
"
#soupsieve==1.8 not in use?

QA_FLAGS_IGNORED="usr/lib.*/python.*/site-packages/cme/data/mimipenguin/.*"

#https://github.com/byt3bl33d3r/CrackMapExec/issues/282
#https://github.com/byt3bl33d3r/CrackMapExec/issues/317
PATCHES=( "${FILESDIR}/setup.patch"
	"${FILESDIR}/invoke-vnc_python3.patch" )

python_prepare_all() {
#	sed -i -e "/pycrypto/d" setup.py || die
	sed -i -e '/bs4/d' setup.py || die
	sed -i -e 's#msgpack-python#msgpack#' setup.py || die
	distutils-r1_python_prepare_all
}

python_install() {
	#install data files disabled in setup.patch
	rm -r cme/thirdparty/{impacket,pywinrm}
	cp -r cme/{data,thirdparty} "${BUILD_DIR}"/lib/cme
	distutils-r1_python_install
}
