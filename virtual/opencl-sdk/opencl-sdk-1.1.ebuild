# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/jre/jre-1.6.0.ebuild,v 1.12 2010/01/11 11:03:47 ulm Exp $

EAPI="2"

DESCRIPTION="Virtual for nv/ati opencl SDK"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="|| (
		>=dev-util/ati-stream-sdk-bin-2.2
		>=dev-util/nvidia-cuda-sdk-3.0[opencl]
	)"
DEPEND=""
