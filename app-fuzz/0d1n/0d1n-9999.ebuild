# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Web security tool to make fuzzing at HTTP/S"
HOMEPAGE="https://github.com/CoolerVoid/0d1n"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/CoolerVoid/0d1n"
else
	SRC_URI="https://github.com/CoolerVoid/0d1n/archive/OdinV${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
	S="${WORKDIR}/0d1n-OdinV${PV}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="doc"

RDEPEND="net-misc/curl"
DEPEND="${RDEPEND}"

src_prepare() {
	default

	# append *FLAGS
	sed -e "s/^CFLAGS=\(.*\)/CFLAGS+=/" \
		-e "s/LDFLAGS=/LDFLAGS+=/" \
		-i Makefile || die 'sed failed!'
}

src_compile() {
	emake CC=$(tc-getCC)
}

src_install() {
	emake PREFIX="${ED}/usr" install

	insinto /usr/share/${PN}
	doins -r payloads/ response2find/ \
		response_sources/ tables/ *.conf

	dodoc -r $(use doc && echo 'doc/*') README.{md,txt}
}
