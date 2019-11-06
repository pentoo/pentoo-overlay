# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="GPU and OpenCL accelerated password auditing tools for security professionals"
HOMEPAGE="http://www.cryptohaze.com/"

MY_PV="${PV/\./_}"
SRC_URI="mirror://sourceforge/cryptohaze/Cryptohaze-Src_${MY_PV}.tar.bz2"

KEYWORDS="~amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE="+grt +multiforcer"

DEPEND="
	dev-libs/argtable
	dev-libs/boost:=
	dev-libs/protobuf
	dev-util/nvidia-cuda-sdk[examples(+)]
	net-misc/curl"

RDEPEND="${DEPEND}"

S="${WORKDIR}/Cryptohaze-Combined"

src_compile() {
	use grt && emake -j1 \
		CUDA_INSTALL_PATH=/opt/cuda \
		CUDA_SDK_INSTALL_PATH=/opt/cuda/sdk grt

	use multiforcer && emake -j1 \
		CUDA_INSTALL_PATH=/opt/cuda \
		CUDA_SDK_INSTALL_PATH=/opt/cuda/sdk multiforcer
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
