# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 fcaps flag-o-matic toolchain-funcs

DESCRIPTION="A tunnel which turns UDP traffic into encrypted FakeTCP/UDP/ICMP traffic"
HOMEPAGE="https://github.com/wangyu-/udp2raw-tunnel"

EGIT_REPO_URI="https://github.com/wangyu-/udp2raw-tunnel"
if [[ ${PV} != *9999 ]]; then
	EGIT_COMMIT="${PV}"
	KEYWORDS="~amd64 ~arm ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="cpu_flags_x86_aes doc"

DEPEND=""
RDEPEND="${DEPEND}
	net-firewall/iptables"

src_prepare() {
	# Disable optimisation flags and remove prefixes of exec files
	sed -e 's/ -O[0-3a-z]*//' \
		-e 's/\${NAME}_[a-zA-Z0-9\$@]*/\${NAME}/' \
		-e 's/ -static//' \
		-e "s/\${cc_[a-zA-Z0-9_]*}/$(tc-getCXX)/" \
		-i makefile || die 'sed failed!'

	eapply_user
}

src_compile() {
	append-cxxflags -Wa,--noexecstack
	emake OPT="${CXXFLAGS}" \
		$(use cpu_flags_x86_aes && use amd64 && echo amd64_hw_aes) \
		$(use arm && echo arm_asm_aes) \
		$(use x86 && echo x86_asm_aes)
}

src_install() {
	local exec_name=${PN%-tunnel}

	insinto "/etc/${exec_name}"
	fowners root:nobody "/etc/${exec_name}"
	fperms 750 "/etc/${exec_name}"
	doins example.conf

	newinitd "${FILESDIR}"/udp2raw-daemon.initd udp2raw-daemon
	newconfd "${FILESDIR}"/udp2raw-daemon.confd udp2raw-daemon

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/udp2raw-daemon.logrotated udp2raw-daemon

	dodoc -r $(use doc && echo 'images doc/*') README.md example.conf Dockerfile
	doman "${FILESDIR}"/man/udp2raw.1
	dobin ${exec_name}
}

pkg_postinst() {
	fcaps cap_net_raw+ep /usr/bin/${PN%-tunnel}

	if ! use cpu_flags_x86_aes && use amd64; then
		ewarn "Please add CPU_FLAGS_X86=\"aes\" to /etc/portage/make.conf"
		ewarn "if your CPU support the AES instruction. Just run:"
		ewarn "    ~# emerge -uDN @world"
	fi

	elog "\nSee documentation: https://github.com/wangyu-/udp2raw-tunnel#getting-started\n"
}
