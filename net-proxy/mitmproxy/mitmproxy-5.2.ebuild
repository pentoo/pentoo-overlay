# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6,7} )
inherit distutils-r1

DESCRIPTION="An interactive, SSL-capable, man-in-the-middle HTTP proxy"
HOMEPAGE="https://mitmproxy.org/"
SRC_URI="https://github.com/mitmproxy/mitmproxy/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test examples"

RDEPEND="=dev-python/blinker-1.4*[${PYTHON_USEDEP}]
	=app-arch/brotli-1.0*[python,${PYTHON_USEDEP}]
	>=dev-python/certifi-2019.9.11[${PYTHON_USEDEP}]
	=dev-python/click-7*[${PYTHON_USEDEP}]
	=dev-python/cryptography-2.9*[${PYTHON_USEDEP}]
	=dev-python/flask-1.1*[${PYTHON_USEDEP}]
	>=dev-python/hyper-h2-3.2.0[${PYTHON_USEDEP}]
	>=dev-python/hyperframe-5.1.0[${PYTHON_USEDEP}]
	>=dev-python/kaitaistruct-0.7[${PYTHON_USEDEP}]
	>=dev-python/ldap3-2.6.1[${PYTHON_USEDEP}]
	>=dev-python/passlib-1.6.5[${PYTHON_USEDEP}]
	>=dev-python/protobuf-python-3.6.0[${PYTHON_USEDEP}]
	>=dev-python/publicsuffix-2.20190205[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.3.1[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-19.1[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-2.4.2[${PYTHON_USEDEP}]
	>=dev-python/pyperclip-1.6.0[${PYTHON_USEDEP}]
	>=dev-python/ruamel-yaml-0.16[${PYTHON_USEDEP}]
	>=dev-python/sortedcontainers-2.1.0[${PYTHON_USEDEP}]
	>=www-servers/tornado-4.3[${PYTHON_USEDEP}]
	>=dev-python/urwid-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/wsproto-0.14.0[${PYTHON_USEDEP}]
	>=dev-python/publicsuffix-2.20190812[${PYTHON_USEDEP}]
	>=dev-python/zstandard-0.11.0[${PYTHON_USEDEP}]
	examples? ( dev-python/beautifulsoup[${PYTHON_USEDEP}] )
"

DEPEND="${RDEPEND}
	test? (
		=dev-python/flask-1.1*[${PYTHON_USEDEP}]
		>=dev-python/parver-0.1[${PYTHON_USEDEP}]
		>=dev-python/pytest-5.1.3[${PYTHON_USEDEP}]
		>=dev-python/requests-2.9.1[${PYTHON_USEDEP}]
	)"

RESTRICT="!test? ( test )"

python_prepare_all() {
	# loosen dependencies
	sed -i '/>/s/>.*/",/g' setup.py || die

	# fix brotli dependency
	sed -i 's/Brotli/brotli/g' setup.py || die

	# remove failing tests
	sed -e 's/test_iframe_injector/_&/g' \
		-i test/examples/test_examples.py || die

	sed -e 's/test_find_unclaimed_URLs/_&/g' \
		-i examples//contrib/test_xss_scanner.py || die

	rm test/mitmproxy/addons/test_readfile.py || die

	sed \
		-e 's/test_mode_none_should_pass_without_sni/_&/g' \
		-e 's/test_mode_strict_w_pemfile_should_pass/_&/g' \
		-e 's/test_mode_strict_w_confdir_should_pass/_&/g' \
		-i test/mitmproxy/net/test_tcp.py || die

	sed \
		-e 's/test_verification_w_confdir/_&/g' \
		-e 's/test_verification_w_pemfile/_&/g' \
		-i test/mitmproxy/proxy/test_server.py || die

	# needs pytest-asyncio
	rm test/mitmproxy/tools/test_main.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	pytest -vv || die
}
