# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs systemd

DESCRIPTION="A network interface promiscuous mode detection tool"
HOMEPAGE="https://www.noorg.org/ifchk/"
SRC_URI="https://www.noorg.org/ifchk/dist/${P}.tar.gz"
KEYWORDS="~amd64 ~arm ~x86"
RESTRICT="mirror"
LICENSE="GPL-2"
SLOT="0"
IUSE="doc"

RDEPEND="sys-fs/sysfsutils"
DEPEND="${RDEPEND}"

src_prepare() {
	# Enable append *FLAGS
	sed -e "s/CFLAGS=/CFLAGS+=/" \
		-e "s/LDFLAGS=/LDFLAGS+=/" \
		-i Makefile || die 'sed failed!'

	mv -v ifchk.conf ifchk.conf.example || die

	eapply_user
}

src_compile() {
	filter-ldflags -Wl,--as-needed
	emake \
		BIN=${PN} \
		CC=$(tc-getCC)
}

src_install() {
	doman docs/*.{1,5}
	dodoc \
		CHANGES \
		README* \
		ifchk.conf.example \
		$(use doc && echo papers/*.{pdf,ps})

	newinitd "${FILESDIR}"/ifchkboot.initd ifchkboot
	newconfd "${FILESDIR}"/ifchkboot.confd ifchkboot
	systemd_dounit "${FILESDIR}"/ifchkboot.service

	insinto /etc
	newins ifchk.conf.example ifchk.conf

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/ifchkboot.logrotated ifchkboot

	dosbin ${PN}
}
