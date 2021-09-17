# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

HASH_COMMIT="ef87c87151b7fb534637ed3db49e598c7380bdce"

DESCRIPTION="A free Open Source test tool / traffic generator for the SIP protocol"
HOMEPAGE="http://sipp.sourceforge.net/ https://github.com/SIPp/sipp/releases"
SRC_URI="https://github.com/SIPp/sipp/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
#SRC_URI="https://github.com/w1ndy/kcptun-plugins/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2 ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gsl +pcap sctp +ssl"

DEPEND="sys-libs/ncurses:=
	gsl? ( sci-libs/gsl:= )
	pcap? (
		net-libs/libpcap
		net-libs/libnet:1.1
	)
	sctp? ( net-misc/lksctp-tools )
	ssl? ( dev-libs/openssl:= )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

src_prepare() {
	default

	#https://bugs.gentoo.org/813420

	# fix version for cmake to work
	cp include/version.h.in include/version.h
	sed -i "s|@VERSION@|${PV}|" include/version.h || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSE_GSL=$(usex gsl 1 0)
		-DUSE_PCAP=$(usex pcap 1 0)
		-DUSE_SCTP=$(usex sctp 1 0)
		-DUSE_SSL=$(usex ssl 1 0)
	)

	cmake_src_configure
}
