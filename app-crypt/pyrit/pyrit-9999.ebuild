# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils python distutils subversion
DESCRIPTION="A GPU-based WPA-PSK and WPA2-PSK cracking tool"
HOMEPAGE="http://code.google.com/p/pyrit/"
ESVN_REPO_URI="http://pyrit.googlecode.com/svn/trunk/"

LICENSE="GPL-3"
KEYWORDS="-*"
IUSE="cuda padlock stream"
SLOT="0"
DEPEND="stream? ( dev-util/amd-stream-sdk-bin )
	cuda? ( dev-util/nvidia-cuda-sdk )"
RDEPEND="${DEPEND}"

src_compile() {
	MYOPTS=""
	if use amd64; then
		epatch "${FILESDIR}/gentoo-64.patch"
		MY_ARCH="x86_64"
	else
		epatch "${FILESDIR}/gentoo.patch"
		MY_ARCH="i686"
	fi
	cd cpyrit
	if use padlock; then
		python setup.py HAVE_PADLOCK build || die "Build padlock failed"
		python setup.py clean
		mv build/lib.linux-"${MY_ARCH}"-2.5  build/padlock
	fi
	if use cuda; then
		python setup.py HAVE_CUDA build || die "Build cuda failed"
		python setup.py clean
		rm cpyrit_cuda.linkinfo
		mv build/lib.linux-"${MY_ARCH}"-2.5  build/cuda
	fi
	if use stream; then
		python setup.py HAVE_STREAM build || die "Build stream failed"
		python setup.py clean
		mv build/lib.linux-"${MY_ARCH}"-2.5  build/steam
	fi
}

src_install() {
	python_version
	insinto /usr/lib/python"${PYVER}"/site-packages/
	if use padlock; then
		cd "${S}"/build/padlock
		sed -e '/import/ s/_cpyrit/_cpyrit_padlock as _cpyrit/' -i cpyrit.py
		newins _cpyrit.so _cpyrit_padlock.so
		newins cpyrit.py cpyrit_padlock.py
		newsbin "${S}/pyrit.py" pyrit-padlock.py
	fi
	if use amd64; then
		doins cpyrit/build/lib.linux-x86_64-2.5/*
	else
		doins cpyrit/build/lib.linux-i686-2.5/*
	fi
	dosbin pyrit.py
}

pkg_postinst() {
	python_mod_optimize
}

pkg_postrm() {
	python_mod_cleanup
}

