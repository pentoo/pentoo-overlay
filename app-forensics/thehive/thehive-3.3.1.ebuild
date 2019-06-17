# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd unpacker user

DESCRIPTION="A scalable 4-in-1 open source and free Security Incident Response Platform"
HOMEPAGE="https://thehive-project.org"
SRC_URI="https://dl.bintray.com/thehive-project/debian-stable/thehive_${PV}-1_all.deb"
LICENSE="AGPL-3"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="$(unpacker_src_uri_depends)"
RDEPEND="virtual/jre"
S="${WORKDIR}"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /dev/null ${PN}
}

src_install() {
	doins -r "opt/"

	insinto "/etc/thehive"
	doins -r "etc/thehive"/*

	systemd_dounit "usr/lib/systemd/system/thehive.service"
	newinitd "${FILESDIR}"/thehive.initd thehive
	newconfd "${FILESDIR}"/thehive.confd thehive

	keepdir "/var/log/thehive"

	fowners -R ${PN}:${PN} "/var/log/thehive" "/opt/thehive" "/etc/thehive"
	fperms 0750 "/etc/thehive" "/var/log/thehive"
	fperms +x "/opt/thehive/bin/thehive"
}
