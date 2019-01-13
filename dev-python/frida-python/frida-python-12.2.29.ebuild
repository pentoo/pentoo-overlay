# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_6,3_7} )
inherit distutils-r1

MY_PN="frida"

DESCRIPTION="Inject JavaScript to explore native apps"
HOMEPAGE="https://github.com/frida/frida"

SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz
	x86? (
		https://files.pythonhosted.org/packages/2.7/f/frida/frida-${PV}-py2.7-linux-i686.egg
		https://files.pythonhosted.org/packages/3.6/f/frida/frida-${PV}-py3.6-linux-i686.egg
	)
	amd64? (
		https://files.pythonhosted.org/packages/2.7/f/frida/frida-${PV}-py2.7-linux-x86_64.egg
		https://files.pythonhosted.org/packages/3.6/f/frida/frida-${PV}-py3.6-linux-x86_64.egg
	)"

LICENSE="wxWinLL-3.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_PN}-${PV}"

QA_FLAGS_IGNORED="usr/lib.*/python.*/site-packages/_frida.*\.so"

PATCHES=( "${FILESDIR}/frida-offline.patch" )

src_prepare(){
	#copy symlinks to homedir for offline installation
	if use x86; then
		cp -s "${DISTDIR}"/frida-${PV}-py2.7-linux-i686.egg "${HOME}"
		cp -s "${DISTDIR}"/frida-${PV}-py3.6-linux-i686.egg "${HOME}"
		cp -s "${DISTDIR}"/frida-${PV}-py3.6-linux-i686.egg "${HOME}"/frida-${PV}-py3.7-linux-i686.egg
	elif use amd64; then
		cp -s "${DISTDIR}"/frida-${PV}-py2.7-linux-x86_64.egg "${HOME}"
		cp -s "${DISTDIR}"/frida-${PV}-py3.6-linux-x86_64.egg "${HOME}"
		cp -s "${DISTDIR}"/frida-${PV}-py3.6-linux-x86_64.egg "${HOME}"/frida-${PV}-py3.7-linux-x86_64.egg
	fi

	default
}
