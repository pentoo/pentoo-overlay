# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils python distutils subversion
DESCRIPTION="A GPU-based WPA-PSK and WPA2-PSK cracking tool"
HOMEPAGE="http://code.google.com/p/pyrit/"
ESVN_REPO_URI="http://pyrit.googlecode.com/svn/trunk/@66"

LICENSE="GPL-3"
KEYWORDS="amd64 x86"
IUSE="cuda padlock stream"
SLOT="0"
DEPEND="stream? ( dev-util/amd-stream-sdk-bin )
	cuda? ( dev-util/nvidia-cuda-sdk )"
RDEPEND="${DEPEND}"

src_compile() {
	MYOPTS=""
	if use amd64; then
		epatch "${FILESDIR}/pyrit-0.1-64.patch"
		MY_ARCH="x86_64"
	else
		epatch "${FILESDIR}/pyrit-0.1.patch"
		MY_ARCH="i686"
	fi
	cd cpyrit
	python setup.py build || die "Build cpu failed"
	python setup.py clean
	mv build/lib.linux-"${MY_ARCH}"-2.5  build/cpu
	if use padlock; then
		sed -e 's/_cpyrit.*(/_cpyrit_padlock(/g' -i cpyrit.c
		sed -e 's/_cpyrit.*\"/_cpyrit_padlock\"/g' -i cpyrit.c
		sed -e '/import/ s/_cpyrit.*/_cpyrit_padlock as _cpyrit/' -i cpyrit.py
		python setup.py HAVE_PADLOCK build || die "Build padlock failed"
		python setup.py clean
		mv build/lib.linux-"${MY_ARCH}"-2.5  build/padlock
	fi
	if use cuda; then
		sed -e 's/_cpyrit.*(/_cpyrit_cuda(/g' -i cpyrit.c
		sed -e 's/_cpyrit.*\"/_cpyrit_cuda\"/g' -i cpyrit.c
		sed -e '/import/ s/_cpyrit.*/_cpyrit_cuda as _cpyrit/' -i cpyrit.py
		python setup.py HAVE_CUDA build || die "Build cuda failed"
		python setup.py clean
		rm cpyrit_cuda.linkinfo
		mv build/lib.linux-"${MY_ARCH}"-2.5  build/cuda
	fi
	if use stream; then
		sed -e 's/_cpyrit.*(/_cpyrit_stream(/g' -i cpyrit.c
		sed -e 's/_cpyrit.*\"/_cpyrit_stream\"/g' -i cpyrit.c
		sed -e '/import/ s/_cpyrit.*/_cpyrit_stream as _cpyrit/' -i cpyrit.py
		python setup.py HAVE_STREAM build || die "Build stream failed"
		python setup.py clean
		mv build/lib.linux-"${MY_ARCH}"-2.5  build/stream
	fi
}

src_install() {
	python_version
	insinto /usr/lib/python"${PYVER}"/site-packages/
	cd "${S}"/cpyrit/build/cpu
	doins _cpyrit.so
	doins cpyrit.py
	cd "${S}"
	dosbin pyrit.py
	if use padlock; then
		cd "${S}"/cpyrit/build/padlock
		newins _cpyrit.so _cpyrit_padlock.so
		newins cpyrit.py cpyrit_padlock.py
		cd "${S}"
		sed -e '/import/ s/cpyrit.*/cpyrit_padlock as cpyrit/' -i pyrit.py
		newsbin pyrit.py pyrit-padlock.py
	fi
	if use cuda; then
		cd "${S}"/cpyrit/build/cuda
		newins _cpyrit.so _cpyrit_cuda.so
		newins cpyrit.py cpyrit_cuda.py
		cd "${S}"
		sed -e '/import/ s/cpyrit.*/cpyrit_cuda as cpyrit/' -i pyrit.py
		newsbin pyrit.py pyrit-cuda.py
	fi
	if use stream; then
		cd "${S}"/cpyrit/build/stream
		newins _cpyrit.so _cpyrit_stream.so
		newins cpyrit.py cpyrit_stream.py
		cd "${S}"
		sed -e '/import/ s/cpyrit.*/cpyrit_stream as cpyrit/' -i pyrit.py
		newsbin pyrit.py pyrit-stream.py
	fi
	dosbin "${S}/contrib/create_hashdb.py"
}

pkg_postinst() {
	python_mod_optimize
}

pkg_postrm() {
	python_mod_cleanup
}

