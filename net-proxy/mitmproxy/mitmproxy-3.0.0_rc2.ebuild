# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5} )
inherit distutils-r1 versionator

DESCRIPTION="An interactive, SSL-capable, man-in-the-middle HTTP proxy"
HOMEPAGE="http://mitmproxy.org/"
MY_PV="$(get_version_component_range 1-3)$(get_version_component_range 4-5)"
MY_P="${PN}-${MY_PV}"
SRC_URI="https://github.com/mitmproxy/mitmproxy/archive/v${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND="
	>=dev-python/blinker-1.4[${PYTHON_USEDEP}] <dev-python/blinker-1.5
	>=dev-python/brotlipy-0.5.1[${PYTHON_USEDEP}] <dev-python/brotlipy-0.8
	>=dev-python/certifi-2015.11.20.1[${PYTHON_USEDEP}]
	>=dev-python/click-6.2[${PYTHON_USEDEP}] <dev-python/click-7
	>=dev-python/cryptography-2.1.4[${PYTHON_USEDEP}] <dev-python/cryptography-2.2
	>=dev-python/hyper-h2-3.0[${PYTHON_USEDEP}] <dev-python/hyper-h2-4
	>=dev-python/hyperframe-5.0[${PYTHON_USEDEP}] <dev-python/hyperframe-6
	>=dev-python/kaitaistruct-0.7[${PYTHON_USEDEP}] <dev-python/kaitaistruct-0.8
	>=dev-python/ldap3-2.4[${PYTHON_USEDEP}] <dev-python/ldap3-2.5
	>=dev-python/passlib-1.6.5[${PYTHON_USEDEP}] <dev-python/passlib-1.8
	>=dev-python/pyasn1-0.3.1[${PYTHON_USEDEP}] <dev-python/pyasn1-0.5
	>=dev-python/pyopenssl-17.2[${PYTHON_USEDEP}] <dev-python/pyopenssl-17.6
	>=dev-python/pyparsing-2.1.3[${PYTHON_USEDEP}] <dev-python/pyparsing-2.3
	>=dev-python/pyperclip-1.5.22[${PYTHON_USEDEP}] <dev-python/pyperclip-1.7
	>=dev-python/requests-2.9.1[${PYTHON_USEDEP}] <dev-python/requests-3
	>=dev-python/ruamel-yaml-0.13.2[${PYTHON_USEDEP}] <dev-python/ruamel-yaml-0.16
	>=dev-python/sortedcontainers-1.5.4[${PYTHON_USEDEP}] <dev-python/sortedcontainers-1.6
	>=www-servers/tornado-4.3[${PYTHON_USEDEP}] <www-servers/tornado-4.6
	>=dev-python/urwid-1.3.1[${PYTHON_USEDEP}] <dev-python/urwid-1.4
	>=dev-python/wsproto-0.11.0[${PYTHON_USEDEP}] <dev-python/wsproto-0.12.0

	examples? ( >=dev-python/pillow-4.3[${PYTHON_USEDEP}] <dev-python/pillow-5.1
		dev-python/beautifulsoup:4[${PYTHON_USEDEP}] <dev-python/beautifulsoup-4.7:4
	)
"

DEPEND="${RDEPEND}
	test? (
		>=dev-python/mock-1.0.1[${PYTHON_USEDEP}]
		>=dev-python/nose-1.3.0[${PYTHON_USEDEP}]
	)
	doc? ( dev-python/sphinx dev-python/sphinxcontrib-documentedlist )"
#fixme: bump it too
#		=www-servers/pathod-$(get_version_component_range 1-2)*[${PYTHON_USEDEP}]

S="${WORKDIR}/${MY_P}"

python_prepare() {
	#we allow to use 34 until 35 is stable
	hack_python34() {
		if [[ `pwd` == *python3_4 ]] ; then
			# do not use circular imports
			sed -i -e "s|^from mitmproxy import contentviews|#from mitmproxy import contentviews|" mitmproxy/contentviews/auto.py || die "failed to sed"
		fi
	}
	python_foreach_impl hack_python34
}

python_test() {
	nosetests -v || die "Tests fail with ${EPYTHON}"
}

python_compile_all() {
	use doc && emake -C docs html
}

python_install_all() {
	local DOCS=( CHANGELOG CONTRIBUTORS )
	use doc && local HTML_DOCS=( docs/_build/html. )
	use examples && local EXAMPLES=( examples/. )

	distutils-r1_python_install_all
}

pkg_postinst() {
	if [[ ${PYTHON_TARGETS} == *python3_4* ]] ; then
		ewarn "Attention: Python 3_4 is not officially supported by this version"
		ewarn
	fi
}
