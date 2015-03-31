# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jre/jre-1.6.0.ebuild,v 1.12 2010/01/11 11:03:47 ulm Exp $

EAPI=4

DESCRIPTION="Virtual for nv/ati/intel opencl SDK"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"

IUSE_VIDEO_CARDS="video_cards_intel video_cards_fglrx video_cards_nvidia "
IUSE="${IUSE_VIDEO_CARDS}"

RDEPEND="app-eselect/eselect-opencl
	video_cards_intel? ( dev-util/intel-ocl-sdk )
	video_cards_fglrx?  ( >=dev-util/ati-stream-sdk-bin-2.2 )
	video_cards_nvidia? ( >=dev-util/nvidia-cuda-sdk-3.0[opencl] )
	"
DEPEND=""

pkg_setup(){
	if ! use video_cards_intel && ! use video_cards_fglrx && ! use video_cards_nvidia ; then
	    eerror "at least one video card must be enabled"
	    die "at least one video card must be enabled"
	fi
}
