# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd unpacker user

DESCRIPTION="A powerful observable analysis and active response engine"
HOMEPAGE="https://thehive-project.org/ https://github.com/TheHive-Project/Cortex"
SRC_URI="https://dl.bintray.com/thehive-project//debian-stable/cortex_${PV}-1_all.deb"
LICENSE="AGPL-3"
SLOT=0
KEYWORDS="~amd64"
IUSE=""

DEPEND="$(unpacker_src_uri_depends)"
RDEPEND="
	<=app-misc/elasticsearch-5.6.16
	virtual/jre"

S="${WORKDIR}"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /dev/null ${PN}
}

src_install() {
	doins -r "opt/"

	insinto "/etc/cortex"
	doins -r "etc/cortex"/*

	systemd_dounit "etc/systemd/system/cortex.service"
	newinitd "${FILESDIR}"/cortex.initd cortex
	newconfd "${FILESDIR}"/cortex.confd cortex

	keepdir "/var/log/cortex"

	fowners -R ${PN}:${PN} "/var/log/cortex" "/opt/cortex" "/etc/cortex"
	fperms 0750 "/etc/cortex" "/var/log/cortex"
	fperms +x "/opt/cortex/bin/cortex"
}

pkg_postinst() {
	ewarn "\n1) Before starting please change the line from file \"application.conf\" (/etc/cortex/application.conf):"
	ewarn "    #play.http.secret.key=\"***CHANGEME***\""
	ewarn "  to"
	ewarn "    play.http.secret.key=\"<YoUr_some_Secret_KeY>\""
	einfo "\n2) Start the \"cortex\" service:"
	einfo "    ~$ sudo rc-service cortex start"
	einfo "\n3) Wait a few seconds and open in your browser: http://127.0.0.1:9001\n"
	einfo "See documentation: https://github.com/TheHive-Project/CortexDocs\n"
}
