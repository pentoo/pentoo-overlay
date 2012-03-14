# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

EAPI=4

DESCRIPTION="GPU and OpenCL accelerated password auditing tools for security professionals"
HOMEPAGE="http://www.cryptohaze.com/"
ESVN_REPO_URI="https://cryptohaze.svn.sourceforge.net/svnroot/cryptohaze/Cryptohaze-Combined"

LICENSE=""
SLOT="0"
KEYWORDS="-*"
IUSE="+grt +multiforcer"

DEPEND="dev-libs/argtable
	net-misc/curl
	dev-util/nvidia-cuda-sdk[pentoo]
	>=dev-libs/boost-1.47.0-r1"
RDEPEND="${DEPEND}"

src_compile() {
	use grt && emake -j1 CUDA_INSTALL_PATH=/opt/cuda CUDA_SDK_INSTALL_PATH=/opt/cuda/sdk grt
	use multiforcer && emake -j1 CUDA_INSTALL_PATH=/opt/cuda CUDA_SDK_INSTALL_PATH=/opt/cuda/sdk multiforcer
}
