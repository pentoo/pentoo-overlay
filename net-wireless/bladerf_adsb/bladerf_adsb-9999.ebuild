# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 toolchain-funcs

DESCRIPTION="bladeRF ADS-B hardware decoder"
HOMEPAGE="https://github.com/Nuand/bladeRF-adsb"
SRC_URI="x40? ( https://www.nuand.com/fpga/adsbx40.rbf )
		x115? ( https://www.nuand.com/fpga/adsbx115.rbf )"
EGIT_REPO_URI="https://github.com/Nuand/bladeRF-adsb.git"

LICENSE="nuand_adsb"
SLOT="0"
KEYWORDS=""
IUSE="x40 x115"

DEPEND="net-wireless/bladerf"
RDEPEND="${DEPEND}"

src_unpack() {
	git-r3_src_unpack
	use x40 && cp "${DISTDIR}"/adsbx40.rbf "${S}"
	use x115 && cp "${DISTDIR}"/adsbx115.rbf "${S}"
}

src_prepare() {
	sed -i 's#./adsbx40.rbf#/usr/share/Nuand/bladeRF/adsbx40.rbf#' bladeRF_adsb/bladeRF_adsb.c
	sed -i 's#./adsbx115.rbf#/usr/share/Nuand/bladeRF/adsbx115.rbf#' bladeRF_adsb/bladeRF_adsb.c
	eapply_user
}

src_compile() {
	pushd bladeRF_adsb
	$(tc-getCC) ${CFLAGS} -o bladeRF_adsb bladeRF_adsb.c -lbladeRF
	popd
}

src_install() {
	dobin bladeRF_adsb/bladeRF_adsb

	insinto /usr/share/Nuand/bladeRF
	use x40 && doins "${S}"/adsbx40.rbf
	use x115 && doins "${S}"/adsbx115.rbf
}
