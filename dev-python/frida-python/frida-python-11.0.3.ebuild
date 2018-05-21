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
		https://files.pythonhosted.org/packages/72/c4/a72a72e17f3d60fd4c100a6079bdb8b7f6ec7f0692c6e6091fb75e5c8275/frida-11.0.3-py2.7-linux-i686.egg
		https://files.pythonhosted.org/packages/09/82/6d800c475b67cd17f264f8d3ba12dbedb0e12500ccbfaaa84ab4692b131f/frida-11.0.3-py3.6-linux-i686.egg
	)
	amd64? (
		https://files.pythonhosted.org/packages/1f/83/958e7b198a5196a5f2de319c324d30189fca52759db342fe8ae41a530e94/frida-11.0.3-py2.7-linux-x86_64.egg
		https://files.pythonhosted.org/packages/50/6c/4e5e80254cb97c9f7100fb3e02563f9854640f529636c1f27d5a1c99240a/frida-11.0.3-py3.6-linux-x86_64.egg
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

PATCHES=( "${FILESDIR}/frida-offline.patch" )

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
