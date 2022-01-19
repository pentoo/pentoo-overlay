# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit toolchain-funcs

DESCRIPTION="Wireless injection tool tool to exploit common IEEE 802.11 protocol weaknesses"


if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/aircrack-ng/mdk4.git"
	EGIT_BRANCH="master"
	KEYWORDS=""
	inherit git-r3
else
	COMMIT="8ddd3969f6457a3d275d6f9e078ec95b6b2b47ea"
	SRC_URI="https://github.com/aircrack-ng/mdk4/archive/"${COMMIT}".tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
	S="${WORKDIR}/${PN}-${COMMIT}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""
DEPEND="dev-libs/libnl:=
		net-libs/libpcap:="
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
