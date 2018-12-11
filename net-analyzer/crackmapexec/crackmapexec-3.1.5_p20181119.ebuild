# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
inherit distutils-r1 eutils

COMMIT_HASH="75449f62bc4c922ef6fb0af78fc9498fb7a6e6ac"
DESCRIPTION="A swiss army knife for pentesting Windows/Active Directory environments"
HOMEPAGE="https://github.com/byt3bl33d3r/CrackMapExec/releases"
SRC_URI="https://github.com/byt3bl33d3r/CrackMapExec/archive/${COMMIT_HASH}.zip -> ${P}.zip"

LICENSE="BSD-2"
#WIP
#KEYWORDS="~amd64 ~x86"
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
	dev-python/pycryptodome[${PYTHON_USEDEP}]
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
"

#greenlet0.4.14; platform_python_implementation == 'CPython'
#	$(python_gen_cond_dep 'dev-python/backports-lzma[${PYTHON_USEDEP}]' python2_7)

S="${WORKDIR}/CrackMapExec-${COMMIT_HASH}"

#python_prepare_all() {
	# disarm pycrypto dep to allow || ( pycryptodome pycrypto )
#	sed -i -e "s|pycrypto|pycryptodome|" requirements.txt || die
#	sed -i -e "s|pycrypto|pycryptodome|" setup.py || die
#	distutils-r1_python_prepare_all
#}
