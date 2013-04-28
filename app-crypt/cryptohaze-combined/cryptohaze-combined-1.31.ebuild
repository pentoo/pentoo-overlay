# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="GPU and OpenCL accelerated password auditing tools for security professionals"
HOMEPAGE="http://www.cryptohaze.com/"

LICENSE="GPL-2"
SLOT="0"
IUSE="+grt +multiforcer"

DEPEND="dev-libs/argtable
	net-misc/curl
	dev-libs/protobuf
	dev-util/nvidia-cuda-sdk[examples]
	>=dev-libs/boost-1.47.0"
RDEPEND="${DEPEND}"

if [[ ${PV} == "9999" ]] ; then
	inherit subversion
	KEYWORDS="-*"
	ESVN_REPO_URI="https://cryptohaze.svn.sourceforge.net/svnroot/cryptohaze/Cryptohaze-Combined"
else
	KEYWORDS="amd64 x86"
	MY_PV=${PV/\./_}
	SRC_URI="mirror://sourceforge/cryptohaze/Cryptohaze-Src_${MY_PV}.tar.bz2"
fi

#required for new cmake build system which seems broken and unusable
#export NVSDKCUDA_ROOT=/opt/cuda/sdk/C

S="${WORKDIR}"/Cryptohaze-Combined

src_compile() {
	use grt && emake -j1 CUDA_INSTALL_PATH=/opt/cuda CUDA_SDK_INSTALL_PATH=/opt/cuda/sdk grt
	use multiforcer && emake -j1 CUDA_INSTALL_PATH=/opt/cuda CUDA_SDK_INSTALL_PATH=/opt/cuda/sdk multiforcer
}

src_install() {
	dodir /opt/${PN}
	cp -R "${S}"/binaries/* "${ED}"/opt/${PN}
	dodir /usr/bin
	for i in $(ls -1 /opt/${PN})
	do
		if [ "${i}" != "kernels" ]
		then
			echo '#! /bin/sh' > "${ED}"/usr/bin/${i}
			echo "cd /opt/${PN}" >> "${ED}"/usr/bin/${i}
			echo 'echo "Warning: running from $(pwd) so be careful of relative paths."' >> "${ED}"/usr/bin/${i}
			echo "./${i} $@" >> "${ED}"/usr/bin/${i}
			fperms +x /usr/bin/${i}
		fi
	done
}
