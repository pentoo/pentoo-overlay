# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/ffmpeg/ffmpeg-0.10.3.ebuild,v 1.9 2012/07/26 20:12:54 grobian Exp $

EAPI=4

DESCRIPTION="Virtual package for FFmpeg implementation"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x64-macos ~x86-solaris"
IUSE="X +encode gsm jpeg2k mp3 sdl speex theora threads truetype vaapi vdpau x264"

RDEPEND="
	|| (
		>=media-video/libav-0.8.2-r2[X?,encode?,gsm?,jpeg2k?,mp3?,sdl?,speex?,theora?,threads?,truetype?,vaapi?,vdpau?,x264?]
		>=media-video/ffmpeg-0.10.3[X?,encode?,gsm?,jpeg2k?,mp3?,sdl?,speex?,theora?,threads?,truetype?,vaapi?,vdpau?,x264?]
	)
"
DEPEND=""
