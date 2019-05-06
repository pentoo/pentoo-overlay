# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# this package has been included a some version of the WebUI
# check before bump it
WEBUI_PV="0.5.12"

MY_PN="${PN%-bin}"
MY_P="${MY_PN}-${PV}-${WEBUI_PV}"

inherit user

DESCRIPTION="Web Application Security Scanner Framework"
HOMEPAGE="https://www.arachni-scanner.com https://github.com/Arachni/arachni"
SRC_URI="https://github.com/Arachni/arachni/releases/download/v${PV}/${MY_P}-linux-x86_64.tar.gz"
LICENSE="APSL-1"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""
QA_PREBUILT="*"

# you need the only dev-lang/ruby for launch it
DEPEND=""
RDEPEND="${DEPEND}
	dev-lang/ruby:="

S="${WORKDIR}"/${MY_P}

pkg_setup() {
	enewgroup ${MY_PN}
	enewuser ${MY_PN} -1 -1 /dev/null ${MY_PN}
}

src_prepare() {
	# cleanup
	rm -r "system/usr/share" "system/usr/etc/fonts/" \
		"system/gems/gems/ffi-1.9.18/ext/ffi_c/libffi-x86_64-linux/include/ffitarget.h" \
		 || die "Failed to install!"

	default
}

src_install() {
	dodir "/opt/${PN}"

	cp -R . "${D}/opt/${PN}" || die "Failed to install!"

	fowners -R ${MY_PN}:${MY_PN} "/opt/${PN}/system"
	fperms -R g=u "/opt/${PN}/system"

	for l in $(ls "bin/"); do
		dosym "../../opt/${PN}/bin"/${l} "/usr/bin"/${l}
	done
	dosym "../../../../usr/share" "/opt/${PN}/system/usr/share"

	newinitd "${FILESDIR}"/arachni-webui-daemon.initd arachni-webui-daemon
	newconfd "${FILESDIR}"/arachni-webui-daemon.confd arachni-webui-daemon

	doman "${FILESDIR}"/man/*
	dodoc README TROUBLESHOOTING
}

pkg_postinst() {
	elog "\nIf you want to use the Web User Interface just run:"
	elog "    ~# rc-service arachni-webui-daemon start"
	elog "and open in browser http://127.0.0.1:9292\n"
	elog "Defaults for the administrator account:"
	elog "    Login: admin@admin.admin"
	elog "    Passwd: administrator\n"

	elog "See documentation:"
	elog "    https://github.com/Arachni/arachni/wiki"
	elog "    https://github.com/Arachni/arachni-ui-web/wiki\n"
}
