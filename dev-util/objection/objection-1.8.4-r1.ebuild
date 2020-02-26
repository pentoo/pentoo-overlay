# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )
inherit distutils-r1

DESCRIPTION="Runtime mobile exploration"
HOMEPAGE="https://github.com/sensepost/objection"
SRC_URI="https://github.com/sensepost/objection/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://dev.pentoo.ch/~blshkv/distfiles/objection-1.7.0-node_modules.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="<dev-util/frida-tools-6.0.1[${PYTHON_USEDEP}]
	dev-python/frida-python[${PYTHON_USEDEP}]
	>=dev-python/prompt_toolkit-2.0.8[${PYTHON_USEDEP}] <dev-python/prompt_toolkit-3.0.0[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
	dev-python/delegator[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	~dev-python/litecli-1.1.0[${PYTHON_USEDEP}]
	net-libs/nodejs[npm]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare(){
	rm -r tests
	mv "${WORKDIR}/node_modules" "${S}/agent/" || die "unable to move node_modules"
#	https://github.com/sensepost/objection/issues/321
	sed -e 's|frida-tools<6.0.0|frida-tools|' -i requirements.txt || die "sed failed"
	eapply_user
}

python_compile() {
	addpredict /etc/npm
	emake frida-agent
#	cd agent
#	npm run build || die "npm build failed"
	distutils-r1_python_compile
}
