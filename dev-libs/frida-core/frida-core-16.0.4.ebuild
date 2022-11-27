# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Dynamic instrumentation toolkit for reverse-engineers and security researchers"
HOMEPAGE="https://github.com/frida/frida"
SRC_URI="
	amd64? (
		https://github.com/frida/frida/releases/download/${PV}/${PN}-devkit-${PV}-linux-x86_64.tar.xz
	)"
#	x86? (
#		https://files.pythonhosted.org/packages/3.8/f/frida/frida-${PV}-py3.8-linux-i686.egg
#	)
#	arm64? (
#		https://files.pythonhosted.org/packages/3.6/f/frida/frida-${PV}-py3.6-linux-aarch64.egg
#	)"


LICENSE="wxWinLL-3.1"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"

RDEPEND=""
DEPEND=""

S="${WORKDIR}"

QA_FLAGS_IGNORED="usr/lib64/libfrida-core.a"
QA_PRESTRIPPED="usr/lib64/libfrida-core.a"

src_install() {
	doheader frida-core.h
	dolib.a libfrida-core.a
	# /usr/share? frida-core.gir
	# frida-core-example.c
}
