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
	COMMIT="9e595b2f72b9c6cf12cc688e46e3eba3bac1b4d3"
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

PATCHES=( "${FILESDIR}"/4.2ish-makefile.patch )

src_compile() {
	emake CC="$(tc-getCC)" AR="$(tc-getAR)" RANLIB="$(tc-getRANLIB)"
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${ED}" install

	insinto /usr/share/${PN}
	doins -r useful_files

	dodoc AUTHORS CHANGELOG TODO
}
