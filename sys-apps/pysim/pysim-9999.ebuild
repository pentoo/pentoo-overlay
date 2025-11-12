EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 optfeature

EGIT_REPO_URI="https://github.com/osmocom/pysim.git"
inherit git-r3

DESCRIPTION="Read, Write and Browse Programmable SIM/USIM Cards"
HOMEPAGE="https://osmocom.org/projects/pysim/wiki"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="
	dev-python/pyscard
	dev-python/pyserial
	dev-python/pytlv
	>=dev-python/cmd2-2.6.2
	dev-python/jsonpath-ng
	>=dev-python/construct-2.10.70
	dev-python/bidict
	>=dev-python/pyosmocom-0.0.9
	>=dev-python/pyyaml-5.1
	dev-python/termcolor
	dev-python/colorlog
	dev-python/pycryptodomex
	dev-python/cryptography
	dev-python/asn1tools-osmocom
	dev-python/packaging
	dev-python/smpp-pdu-hologramio
	dev-python/smpp-twisted3
"

distutils_enable_tests unittest

python_test() {
	# NB: run only unit tests since all other are integration tests and require
	# PCSC reader with physical card.
	eunittest -s tests/unittests
}

pkg_postinst() {
	optfeature "CCID driver for compatible smartcard readers" app-crypt/ccid
	optfeature "Troubleshoot SIM card and (or) PCSC-compatible reader connectivity issues" sys-apps/pcsc-tools
}
