# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils

MY_PV=${PV/_/}

DESCRIPTION="Multiplatform IAX library for creating telephony solutions that interoperate with Asterisk"
HOMEPAGE="http://iaxclient.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="stresstest vtestcall +wxwidgets"

DEPEND=""
RDEPEND="wxwidgets? ( x11-libs/wxGTK:2.8[X] )
	 media-libs/portaudio
	 net-libs/libvidcap
	 media-sound/gsm
	 virtual/ffmpeg[speex,gsm]
	 stresstest? ( media-libs/liboggz )
	 vtestcall? ( media-libs/libsdl )"

S="${WORKDIR}"/"${PN}"-"${MY_PV}"

pkg_setup()
{
	if use wxwidgets; then
		eselect wxwidgets list | grep -q \* || eselect wxwidgets set 1
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/iaxclient-fix-avcodec-include.patch || die "patch failed"
	sed -i 's#e->avctx->mb_qmin = e->avctx->qmin = 10;#//e->avctx->mb_qmin = e->avctx->qmin = 10;#' lib/codec_ffmpeg.c
	sed -i 's#e->avctx->mb_qmax = e->avctx->qmax = 10;#//e->avctx->mb_qmax = e->avctx->qmax = 10;#' lib/codec_ffmpeg.c
	sed -i 's#avcodec_decode_video#avcodec_decode_video2#' lib/codec_ffmpeg.c
	sed -i 's#in, inlen)#in)#g' lib/codec_ffmpeg.c
}

src_configure() {
	local myclients
	myclients="testcall"
	if use vtestcall; then
		myclients="${myclients} vtestcall"
	fi
	if use wxwidgets; then
		myclients="${myclients} wx"
		ewarn 'If your build fails with "configure: error: wx client requires wxWidgets"'
		ewarn 'you can fix it with "eselect wxwidgets set 1"'
	fi
	if use stresstest; then
		myclients="${myclients} stresstest"
	fi
	sed -e 's/m_id/GetId()/' -i simpleclient/wx/wx.cc
	econf --enable-clients="${myclients}" --with-gsm-includes=/usr/include/gsm DESTDIR="${ED}" || die 'configure failed'
}

src_install() {
	emake DESTDIR="${ED}" install || die 'emake install failed'
}
