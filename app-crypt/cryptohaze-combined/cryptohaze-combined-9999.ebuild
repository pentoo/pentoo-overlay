# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cuda cmake-utils pax-utils

DESCRIPTION="GPU and OpenCL accelerated password auditing tools for security professionals"
HOMEPAGE="http://www.cryptohaze.com/"

REQUIRED_USE="|| ( video_cards_nvidia video_cards_fglrx )"

LICENSE="GPL-2"
SLOT="0"

IUSE_VIDEO_CARDS="video_cards_fglrx video_cards_nvidia"

IUSE="${IUSE_VIDEO_CARDS} pax_kernel"

DEPEND="dev-libs/argtable
	net-misc/curl
	dev-libs/protobuf
	dev-util/nvidia-cuda-sdk
	>=dev-util/nvidia-cuda-toolkit-5.5.22
	>=dev-libs/boost-1.48.0:=
	video_cards_nvidia? ( x11-drivers/nvidia-drivers )
	video_cards_fglrx?  ( x11-drivers/ati-drivers )"
RDEPEND="${DEPEND}"

if [[ ${PV} == "9999" ]] ; then
	inherit subversion
	KEYWORDS=""
	ESVN_REPO_URI="https://cryptohaze.svn.sourceforge.net/svnroot/cryptohaze/Cryptohaze-Combined"
else
	KEYWORDS="~amd64 ~x86"
	MY_PV=${PV/\./_}
	SRC_URI="mirror://sourceforge/cryptohaze/Cryptohaze-Src_${MY_PV}.tar.bz2"
fi

S="${WORKDIR}"/Cryptohaze-Combined

src_prepare() {
	cuda_src_prepare
	export CUDA_NVCC_FLAGS="${NVCCFLAGS}"
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCUDA_SDK_ROOT_DIR:OPTION=/opt/cuda/sdk/C
		-DBoost_USE_STATIC_LIBS:BOOL=OFF
		-DCMAKE_INSTALL_PREFIX=/usr/share/${PN}
		-DCUDA_NVCC_FLAGS="${NVCCFLAGS}"
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	pax-mark mr "${ED}"/usr/share/cryptohaze-combined/Cryptohaze-Multiforcer

	dodir /usr/bin
	for i in $(ls -1 "${ED}/usr/share/${PN}")
	do
		if [ -f "${ED}/usr/share/${PN}/"${i} ]
		then
			cat <<-EOF > "${ED}"/usr/bin/${i}
				#! /bin/sh
				cd /usr/share/${PN}
				echo "Warning: running from /usr/share/${PN} so be careful of relative paths."
				exec ./${i} "\$@"
			EOF

	                fperms +x /usr/bin/${i}
		fi
	done
}
