# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit udev toolchain-funcs

if [ "${PV}" = "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/RfidResearchGroup/proxmark3.git"
	RESTRICT="strip"
else
	#snapshot
	#HASH_COMMIT="1ac5211601b50b82b41737dce0c3a72d9e0374ac"
	#SRC_URI="https://github.com/RfidResearchGroup/${PN}/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	#S=${WORKDIR}/${PN}-${HASH_COMMIT}

	#or release
	KEYWORDS="~amd64"
	SRC_URI="https://github.com/RfidResearchGroup/proxmark3/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi
DESCRIPTION="A general purpose RFID tool for Proxmark3 hardware"
HOMEPAGE="https://github.com/RfidResearchGroup/proxmark3"

LICENSE="GPL-3+"
SLOT="0"
IUSE="+bluez +firmware opencl +qt"

CDEPEND="
	app-arch/bzip2
	app-arch/lz4:=
	dev-libs/jansson:=
	dev-libs/openssl:=
	sys-libs/readline:=
	media-libs/gd:2=
	bluez? ( net-wireless/bluez:= )
	opencl? ( dev-libs/opencl-icd-loader )
	qt? ( dev-qt/qtcore:5
	dev-qt/qtwidgets:5
	dev-qt/qtgui:5 )
"
DEPEND="${CDEPEND}
	dev-util/opencl-headers
"
RDEPEND="${CDEPEND}
	dev-python/ansicolors
	dev-python/sslcrypto
"
#ncurses is basically just used for termcap
PDEPEND="sys-libs/ncurses:*[tinfo]"
BDEPEND="firmware? ( sys-devel/gcc-arm-none-eabi:0 )"

QA_FLAGS_IGNORED="usr/share/proxmark3/firmware/bootrom.elf
		usr/share/proxmark3/firmware/fullimage.elf
		usr/share/proxmark3/firmware/PM3BOOTROM.elf
		usr/share/proxmark3/firmware/PM3GENERIC_256.elf
		usr/share/proxmark3/firmware/PM3GENERIC.elf
		usr/share/proxmark3/firmware/PM3GENERIC_LFSKELETON.elf
		usr/share/proxmark3/firmware/PM3GENERIC_LFEM4100EMUL.elf
		usr/share/proxmark3/firmware/PM3GENERIC_LFEM4100RSWB.elf
		usr/share/proxmark3/firmware/PM3GENERIC_LFEM4100RSWW.elf
		usr/share/proxmark3/firmware/PM3GENERIC_LFEM4100RWC.elf
		usr/share/proxmark3/firmware/PM3GENERIC_LFHIDBRUTE.elf
		usr/share/proxmark3/firmware/PM3GENERIC_LFMULTIHID.elf
		usr/share/proxmark3/firmware/PM3GENERIC_LFNEDAP_SIM.elf
		usr/share/proxmark3/firmware/PM3GENERIC_LFPROXBRUTE.elf
		usr/share/proxmark3/firmware/PM3GENERIC_LFPROX2BRUTE.elf
		usr/share/proxmark3/firmware/PM3GENERIC_LFSAMYRUN.elf
		usr/share/proxmark3/firmware/PM3GENERIC_HF14ASNIFF.elf
		usr/share/proxmark3/firmware/PM3GENERIC_HF14BSNIFF.elf
		usr/share/proxmark3/firmware/PM3GENERIC_HF15SNIFF.elf
		usr/share/proxmark3/firmware/PM3GENERIC_HF15SIM.elf
		usr/share/proxmark3/firmware/PM3GENERIC_HFAVEFUL.elf
		usr/share/proxmark3/firmware/PM3GENERIC_HFCRAFTBYTE.elf
		usr/share/proxmark3/firmware/PM3GENERIC_HFLEGIC.elf
		usr/share/proxmark3/firmware/PM3GENERIC_HFMATTYRUN.elf
		usr/share/proxmark3/firmware/PM3GENERIC_HFMSDSAL.elf
		usr/share/proxmark3/firmware/PM3GENERIC_HFTCPRST.elf
		usr/share/proxmark3/firmware/PM3GENERIC_HFTMUDFORD.elf
		usr/share/proxmark3/firmware/PM3GENERIC_HFUNISNIFF.elf
		usr/share/proxmark3/firmware/PM3GENERIC_HFYOUNG.elf
		usr/share/proxmark3/firmware/PM3GENERIC_DANKARMULTI.elf
		usr/share/proxmark3/firmware/PM3RDV4.elf
		usr/share/proxmark3/firmware/PM3RDV4_LFSKELETON.elf
		usr/share/proxmark3/firmware/PM3RDV4_LFEM4100EMUL.elf
		usr/share/proxmark3/firmware/PM3RDV4_LFEM4100RSWB.elf
		usr/share/proxmark3/firmware/PM3RDV4_LFEM4100RSWW.elf
		usr/share/proxmark3/firmware/PM3RDV4_LFEM4100RWC.elf
		usr/share/proxmark3/firmware/PM3RDV4_LFHIDBRUTE.elf
		usr/share/proxmark3/firmware/PM3RDV4_LFHIDFCBRUTE.elf
		usr/share/proxmark3/firmware/PM3RDV4_LFICEHID.elf
		usr/share/proxmark3/firmware/PM3RDV4_LFMULTIHID.elf
		usr/share/proxmark3/firmware/PM3RDV4_LFNEDAP_SIM.elf
		usr/share/proxmark3/firmware/PM3RDV4_LFNEXID.elf
		usr/share/proxmark3/firmware/PM3RDV4_LFPROXBRUTE.elf
		usr/share/proxmark3/firmware/PM3RDV4_LFPROX2BRUTE.elf
		usr/share/proxmark3/firmware/PM3RDV4_LFSAMYRUN.elf
		usr/share/proxmark3/firmware/PM3RDV4_LFTHAREXDE.elf
		usr/share/proxmark3/firmware/PM3RDV4_HF14ASNIFF.elf
		usr/share/proxmark3/firmware/PM3RDV4_HF14BSNIFF.elf
		usr/share/proxmark3/firmware/PM3RDV4_HF15SNIFF.elf
		usr/share/proxmark3/firmware/PM3RDV4_HF15SIM.elf
		usr/share/proxmark3/firmware/PM3RDV4_HFAVEFUL.elf
		usr/share/proxmark3/firmware/PM3RDV4_HFBOG.elf
		usr/share/proxmark3/firmware/PM3RDV4_HFCOLIN.elf
		usr/share/proxmark3/firmware/PM3RDV4_HFCRAFTBYTE.elf
		usr/share/proxmark3/firmware/PM3RDV4_HFICECLASS.elf
		usr/share/proxmark3/firmware/PM3RDV4_HFLEGIC.elf
		usr/share/proxmark3/firmware/PM3RDV4_HFLEGICSIM.elf
		usr/share/proxmark3/firmware/PM3RDV4_HFMATTYRUN.elf
		usr/share/proxmark3/firmware/PM3RDV4_HFMFCSIM.elf
		usr/share/proxmark3/firmware/PM3RDV4_HFMSDSAL.elf
		usr/share/proxmark3/firmware/PM3RDV4_HFTCPRST.elf
		usr/share/proxmark3/firmware/PM3RDV4_HFTMUDFORD.elf
		usr/share/proxmark3/firmware/PM3RDV4_HFUNISNIFF.elf
		usr/share/proxmark3/firmware/PM3RDV4_HFYOUNG.elf
		usr/share/proxmark3/firmware/PM3RDV4_DANKARMULTI.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_LFSKELETON.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_LFEM4100EMUL.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_LFEM4100RSWB.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_LFEM4100RSWW.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_LFEM4100RWC.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_LFHIDBRUTE.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_LFHIDFCBRUTE.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_LFICEHID.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_LFMULTIHID.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_LFNEDAP_SIM.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_LFNEXID.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_LFPROXBRUTE.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_LFPROX2BRUTE.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_LFSAMYRUN.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_LFTHAREXDE.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_HF14ASNIFF.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_HF14BSNIFF.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_HF15SNIFF.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_HF15SIM.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_HFAVEFUL.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_HFBOG.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_HFCARDHOPPER.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_HFCOLIN.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_HFCRAFTBYTE.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_HFICECLASS.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_HFLEGIC.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_HFLEGICSIM.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_HFMATTYRUN.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_HFMFCSIM.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_HFMSDSAL.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_HFREBLAY.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_HFTCPRST.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_HFTMUDFORD.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_HFUNISNIFF.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_HFYOUNG.elf
		usr/share/proxmark3/firmware/PM3RDV4_BTADDON_DANKARMULTI.elf
"

src_prepare(){
	default
	build_time=$(date '+%Y-%m-%d %H:%M:%S')
	sed -i "s#\"\$ctime\",#\"${build_time}\",#" tools/mkversion.sh || die
}

src_compile(){
	export PREFIX=/usr
	#verbose
	export V=1
	#common flags
	EMAKE_COMMON=CC="$(tc-getCC)" DEFCFLAGS="${CFLAGS}" MYCFLAGS="${CFLAGS}"
	EMAKE_COMMON+= MYCXXFLAGS="${CXXFLAGS}" MYLDFLAGS="${LDFLAGS}"
	use bluez || export SKIPBT=1
	use qt || export SKIPQT=1
	use opencl || export SKIPOPENCL=1
	if use firmware; then
		#prevent repeat cleaning of things which were never built
		sed -i '/\$(Q)\$(MAKE) \-\-no-print-directory \-C recovery clean/d' Makefile || die
		sed -i '/\$(Q)\$(MAKE) \-\-no-print-directory \-C client clean/d' Makefile || die
		#prevent rebuilding fpga_compress for every firmware
		sed -i '/\$(Q)\$(MAKE) \-\-no-print-directory \-C tools\/fpga_compress clean/d' Makefile || die
		DEST="firmware" MKFLAGS="${MAKEOPTS} ${EMAKE_COMMON}" ./tools/build_all_firmwares.sh || die
		# We removed the auto cleans for speed so we have to do it once manually
		emake clean
	fi
	# If we wanted firmware we built it in USE=firmware
	sed -i 's#bootrom/% armsrc/% recovery/%##' Makefile || die
	emake ${EMAKE_COMMON} all hitag2crack
}

src_install(){
	export PREFIX=/usr
	export DESTDIR="${ED}"
	# hitag2crack needs it's own DESTDIR variable?
	export MYDESTDIR="${ED}"
	export UDEV_PREFIX="$(get_udevdir)/rules.d"
	export INSTALLDOCSRELPATH="/share/doc/${PF}"
	emake INSTALLDOCSRELPATH="/share/doc/${PF}" install hitag2crack/install
	if use firmware; then
		insinto /usr/share/${PN}
		doins -r "${S}"/firmware
		ln -s ./PM3BOOTROM.elf "${ED}/usr/share/${PN}/firmware/bootrom.elf"
		ln -s ./PM3GENERIC_256.elf "${ED}/usr/share/${PN}/firmware/proxmark3_recovery.bin"
		ln -s ./PM3GENERIC.elf "${ED}/usr/share/${PN}/firmware/fullimage.elf"
	fi
}

src_test() {
	# Because of building all firmware the some files end up in a different location with a different name
	sed -i -e 's#bootrom/obj/bootrom.elf#firmware/PM3BOOTROM.elf#' \
		-e 's#recovery/proxmark3_recovery.bin#firmware/PM3GENERIC_256.elf#' \
		-e 's#armsrc/obj/fullimage.elf#firmware/PM3GENERIC.elf#' tools/pm3_tests.sh || die
	# This isn't installed and was removed by "make clean" after firmware build
	sed -i '/if ! CheckFileExist "fpgacompress exists"/d' tools/pm3_tests.sh || die
	if use firmware; then
		./tools/pm3_tests.sh --long || die
	else
		./tools/pm3_tests.sh --long client || die
	fi
	# Opencl stuff doesn't work as the portage user
	#if use opencl; then
	#	./tools/pm3_tests.sh --long --opencl hitag2crack || die
	#else
		./tools/pm3_tests.sh --long hitag2crack || die
	#fi
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
