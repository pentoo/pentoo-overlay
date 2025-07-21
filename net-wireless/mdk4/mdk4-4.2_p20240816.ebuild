# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit toolchain-funcs

DESCRIPTION="Wireless injection tool tool to exploit common IEEE 802.11 protocol weaknesses"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/aircrack-ng/mdk4.git"
	EGIT_BRANCH="master"
	inherit git-r3
else
	COMMIT="36ca143a2e6c0b75b5ec60143b0c5eddd3d2970c"
	SRC_URI="https://github.com/aircrack-ng/mdk4/archive/"${COMMIT}".tar.gz -> ${P}.gh.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
	S="${WORKDIR}/${PN}-${COMMIT}"
fi

HOMEPAGE="https://github.com/aircrack-ng/mdk4"
LICENSE="GPL-3"
SLOT="0"
DEPEND="dev-libs/libnl:3
		net-libs/libpcap"
RDEPEND="${DEPEND}"

src_compile() {
	emake CC="$(tc-getCC)" AR="$(tc-getAR)" RANLIB="$(tc-getRANLIB)"
}

src_install() {
	emake DESTDIR="${ED}" install

	insinto /usr/share/${PN}
	doins -r useful_files

	dodoc AUTHORS CHANGELOG TODO
}
