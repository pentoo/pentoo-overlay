# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils git-r3 systemd toolchain-funcs user

DESCRIPTION="Tunnel TCP connections over the Tox protocol"
HOMEPAGE="https://gdr.name/tuntox https://github.com/gjedeer/tuntox"

EGIT_REPO_URI="https://github.com/gjedeer/tuntox"
if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="${PV}"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="systemd static"

RDEPEND="
	dev-libs/libevent:=[threads]
	net-libs/tox"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/${PN} ${PN}
}

src_prepare() {
	# Do not rename binary files
	sed -e "s/\$(CC) -o \$@/\$(CC) -o ${PN}/" \
		-i Makefile || die "sed failed!"

	use systemd && (
		sed -e "s/#User=proxy/User=${PN}/" \
			-e "s/#Group=proxy/Group=${PN}/" \
			-i scripts/tuntox.service || die "sed failed!"
	)

	eapply "${FILESDIR}"
	eapply_user
}

src_compile() {
	emake CC=$(tc-getCC) \
		tox_bootstrap.h \
		gitversion.h \
		$(usex static "tuntox" "tuntox_nostatic")
}

src_install() {
	for d in lib log; do
		keepdir "/var/${d}/${PN}"
		fowners ${PN}:${PN} "/var/${d}/${PN}"
		fperms 750 "/var/${d}/${PN}"
	done

	insinto /var/lib/${PN}
	doins "${FILESDIR}"/tuntox.conf "${FILESDIR}"/rules.example
	fowners ${PN}:${PN} "/var/lib/${PN}"/{tuntox.conf,rules.example}

	insinto /etc/logrotate.d/
	newins "${FILESDIR}"/tuntox.logrotated ${PN}

	newinitd "${FILESDIR}"/tuntox.initd ${PN}
	newconfd "${FILESDIR}"/tuntox.confd ${PN}
	use systemd && systemd_dounit scripts/tuntox.service

	dobin ${PN}
	dobin scripts/tokssh

	dodoc README.md VPN.md BUILD.md
}

pkg_postinst() {
	ewarn "\nPlease, add yourself to the \"${PN}\" group. This security measure ensures"
	ewarn "that only trusted users can use tuntox.\n"
	einfo "See documentation: https://github.com/gjedeer/tuntox#introduction\n"
}
