# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_5,3_6} )
inherit distutils-r1

MY_PN="frida"

DESCRIPTION="Inject JavaScript to explore native apps"
HOMEPAGE="https://github.com/frida/frida"

#FIXME: quick hack, download frida .so file earlier
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz
	x86? ( https://files.pythonhosted.org/packages/87/02/73030e1a938f7b9797678f174a425ed8600977863a8816e83df65df44f54/frida-10.7.7-py2.7-linux-i686.egg
		https://files.pythonhosted.org/packages/11/0a/ac1b93932c7b11e87e675214966df3c3303aa4bef721b7c7f54d03d03e9e/frida-10.7.7-py3.6-linux-i686.egg
	)
	amd64? ( https://files.pythonhosted.org/packages/c2/d1/dc5e3d8534c05bb34f28acfe10c2780ff233c7280552a58a066ba0a25c8e/frida-10.7.7-py2.7-linux-x86_64.egg
		https://files.pythonhosted.org/packages/d5/d5/86be98523ac97efa2a95b4eaa9db3d33fcf909c4685df2bf0048ef05f1d5/frida-10.7.7-py3.6-linux-x86_64.egg
	)
"
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

QA_PREBUILT="usr/lib*/pyton*/site-packages/_frida*.so"

src_prepare(){
	#copy symlinks to homedir for offline installation
	if use x86; then
		cp -s "${DISTDIR}"/frida-10.7.7-py2.7-linux-i686.egg "${HOME}"
		cp -s "${DISTDIR}"/frida-10.7.7-py3.6-linux-i686.egg "${HOME}"
		cp -s "${DISTDIR}"/frida-10.7.7-py3.6-linux-i686.egg "${HOME}"/frida-10.7.7-py3.5-linux-i686.egg
	elif use amd64; then
		cp -s "${DISTDIR}"/frida-10.7.7-py2.7-linux-x86_64.egg "${HOME}"
		cp -s "${DISTDIR}"/frida-10.7.7-py3.6-linux-x86_64.egg "${HOME}"
		cp -s "${DISTDIR}"/frida-10.7.7-py3.6-linux-x86_64.egg "${HOME}"/frida-10.7.7-py3.5-linux-x86_64.egg
	fi

	default
}
