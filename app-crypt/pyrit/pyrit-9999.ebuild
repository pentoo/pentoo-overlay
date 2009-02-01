# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils python distutils subversion
DESCRIPTION="A GPU-based WPA-PSK and WPA2-PSK cracking tool"
HOMEPAGE="http://code.google.com/p/pyrit/"
ESVN_REPO_URI="http://pyrit.googlecode.com/svn/trunk/"

LICENSE="GPL-3"
KEYWORDS="-*"
IUSE="cuda stream"
SLOT="0"
DEPEND="stream? ( dev-util/amd-stream-sdk-bin )
	cuda? ( dev-util/nvidia-cuda-sdk )"
RDEPEND="${DEPEND}"

src_compile() {
	MYOPTS="HAVE_PADLOCK"
	if use stream; then
		MYOPTS="${MYOPTS} HAVE_STREAM"
	fi
	if use cuda; then
		MYOPTS="${MYOPTS} HAVE_CUDA"
	fi

	epatch "${FILESDIR}/gentoo.patch"
	cd cpyrit
	python setup.py ${MYOPTS} build || die "Build failed"
}

src_install() {
	python_version
	insinto /usr/lib/python"${PYVER}"/site-packages/
	doins cpyrit/build/lib.linux-i686-2.5/*
	dosbin pyrit.py
}

pkg_postinst() {
	python_mod_optimize
}

pkg_postrm() {
	python_mod_cleanup
}

