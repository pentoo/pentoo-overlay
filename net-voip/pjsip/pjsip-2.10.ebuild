# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Multimedia communication libraries for building VoIP applications"
HOMEPAGE="http://www.pjsip.org/"

SRC_URI="https://github.com/pjsip/pjproject/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"
IUSE="alsa doc epoll examples ext-sound g711 g722 g7221 gsm ilbc l16 oss python speex ssl"
#small-filter large-filter speex-aec

DEPEND="alsa? ( media-libs/alsa-lib )
	ilbc? ( media-libs/libilbc )
	gsm? ( media-sound/gsm )
	speex? ( media-libs/speex )
	ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/pjproject-${PV}"

src_prepare() {
	# Fix hardcoded prefix and flags
	sed -i \
		-e 's/poll@/poll@\nexport PREFIX := @prefix@\n/g' \
		-e 's!prefix = /usr/local!prefix = $(PREFIX)!' \
		Makefile \
		build.mak.in || die "sed failed."

	# apply -fPIC globally
	cp "${FILESDIR}/user.mak ${S}"

	# TODO: remove deps to shipped codecs and libs, use system ones
	# rm -r third_party
	# libresample: https://ccrma.stanford.edu/~jos/resample/Free_Resampling_Software.html

#	use ring && {
#		eapply "${WORKDIR}"/ring/contrib/src/pjproject/*.patch "${FILESDIR}"/pjsip-ring-intptr_t.patch
#		sed -i -e 's#/usr/local#/usr#' aconfigure
#	}
	default
}

src_configure() {
	econf	$(use_enable epoll) \
		$(use_enable alsa sound) \
		$(use_enable ext-sound) \
		$(use_enable g711 g711-codec) \
		$(use_enable l16 l16-codec) \
		$(use_enable gsm gsm-codec) \
		$(use_enable g722 g722-codec) \
		$(use_enable g7221 g7221-codec) \
		--disable-speex-codec \
		--disable-speex-aec \
		$(use_enable ilbc ilbc-codec) || die "econf failed."
		#l16-codec
		#$(use_enable small-filter) \
		#$(use_enable large-filter) \
		#$(use_enable speex-aec) \
}

src_compile() {
	emake dep || die "emake dep failed."
	emake -j1 || die "emake failed."
}

src_install() {
	DESTDIR="${D}" emake install || die "emake install failed."

	if use amd64; then
		newbin ./pjsip-apps/bin/pjsua-x86_64-pc-linux-gnu pjsua
	fi

	if use python; then
		pushd pjsip-apps/src/python
		python setup.py install --prefix="${D}/usr/"
		popd
	fi

	if use doc; then
		dodoc README.txt README-RTEMS
	fi

	if use examples; then
		insinto "/usr/share/doc/${P}/examples"
		doins "${S}/pjsip-apps/src/samples/"*
	fi

	# Remove files that pjproject should not install
#	rm -r "${D}/usr/lib/libportaudio.a" \
#		"${D}/usr/lib/libsrtp.a"
}
