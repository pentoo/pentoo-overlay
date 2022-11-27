# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

MY_PN="frida"

DESCRIPTION="Dynamic instrumentation toolkit for reverse-engineers and security researchers"
HOMEPAGE="https://github.com/frida/frida"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz
	amd64? (
		https://files.pythonhosted.org/packages/3.8/f/frida/frida-${PV}-py3.8-linux-x86_64.egg
	)
	x86? (
		https://files.pythonhosted.org/packages/3.8/f/frida/frida-${PV}-py3.8-linux-i686.egg
	)
	arm64? (
		https://files.pythonhosted.org/packages/3.6/f/frida/frida-${PV}-py3.6-linux-aarch64.egg
	)"

LICENSE="wxWinLL-3.1"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND=""
DEPEND="${PYTHON_DEPS}"

S="${WORKDIR}/${MY_PN}-${PV}"

QA_FLAGS_IGNORED="usr/lib/python.*/site-packages/_frida.*\.so"
QA_PRESTRIPPED="usr/lib/python.*/site-packages/_frida.*\.so"

src_prepare(){
	#copy symlinks to homedir for offline installation
	if use amd64; then
		cp -s "${DISTDIR}"/frida-${PV}-py3.8-linux-x86_64.egg "${HOME}"
		cp -s "${DISTDIR}"/frida-${PV}-py3.8-linux-x86_64.egg "${HOME}"/frida-${PV}-py3.9-linux-x86_64.egg
		cp -s "${DISTDIR}"/frida-${PV}-py3.8-linux-x86_64.egg "${HOME}"/frida-${PV}-py3.10-linux-x86_64.egg
	elif use arm64; then
		cp -s "${DISTDIR}"/frida-${PV}-py3.8-linux-aarch64.egg "${HOME}"
		cp -s "${DISTDIR}"/frida-${PV}-py3.8-linux-aarch64.egg "${HOME}"/frida-${PV}-py3.9-linux-aarch64.egg
		cp -s "${DISTDIR}"/frida-${PV}-py3.8-linux-aarch64.egg "${HOME}"/frida-${PV}-py3.10-linux-aarch64.egg
	elif use x86; then
		cp -s "${DISTDIR}"/frida-${PV}-py3.8-linux-i686.egg "${HOME}"
		cp -s "${DISTDIR}"/frida-${PV}-py3.8-linux-i686.egg "${HOME}"/frida-${PV}-py3.9-linux-i686.egg
		cp -s "${DISTDIR}"/frida-${PV}-py3.8-linux-i686.egg "${HOME}"/frida-${PV}-py3.10-linux-i686.egg
	fi

	default
}
