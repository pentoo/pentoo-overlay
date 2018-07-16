# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_5,3_6} )
inherit distutils-r1

MY_PN="frida"

DESCRIPTION="Inject JavaScript to explore native apps"
HOMEPAGE="https://github.com/frida/frida"

#FIXME: quick hack, download frida .so file earlier
#https://pypi.org/simple/frida/
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz
	x86? (
		https://files.pythonhosted.org/packages/74/61/588b0f495108b4b562b48f888ef6698a96e3034ea73e55428e98f1813812/frida-12.0.3-py2.7-linux-i686.egg
		https://files.pythonhosted.org/packages/3b/cc/484ccb5171039168b652304a3e16030c718c7a78ecfe62cd2c1f0c93ad95/frida-12.0.3-py3.6-linux-i686.egg
	)
	amd64? (
		https://files.pythonhosted.org/packages/02/e0/6f2d741c82aa40967792f7b1ab6d73cfba6a5fddc4b3b0c27b5197417738/frida-12.0.3-py2.7-linux-x86_64.egg
		https://files.pythonhosted.org/packages/73/d8/ffeed9316a2e73ec1920c02bb1bfb37db62c6b56e83b5d3d0e6c17ae63b2/frida-12.0.3-py3.6-linux-x86_64.egg
	)"

LICENSE="wxWinLL-3.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/prompt_toolkit[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_PN}-${PV}"

QA_FLAGS_IGNORED="usr/lib.*/python.*/site-packages/_frida.*\.so"

src_prepare(){
	#copy symlinks to homedir for offline installation
	if use x86; then
		cp -s "${DISTDIR}"/frida-${PV}-py2.7-linux-i686.egg "${HOME}"
		cp -s "${DISTDIR}"/frida-${PV}-py3.6-linux-i686.egg "${HOME}"
		cp -s "${DISTDIR}"/frida-${PV}-py3.6-linux-i686.egg "${HOME}"/frida-${PV}-py3.5-linux-i686.egg
	elif use amd64; then
		cp -s "${DISTDIR}"/frida-${PV}-py2.7-linux-x86_64.egg "${HOME}"
		cp -s "${DISTDIR}"/frida-${PV}-py3.6-linux-x86_64.egg "${HOME}"
		cp -s "${DISTDIR}"/frida-${PV}-py3.6-linux-x86_64.egg "${HOME}"/frida-${PV}-py3.5-linux-x86_64.egg
	fi

	default
}
