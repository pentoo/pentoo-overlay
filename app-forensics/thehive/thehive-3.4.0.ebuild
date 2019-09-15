# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd unpacker user

DESCRIPTION="A scalable 4-in-1 open source and free Security Incident Response Platform"
HOMEPAGE="https://thehive-project.org"
SRC_URI="https://dl.bintray.com/thehive-project/debian-stable/thehive_${PV}-1_all.deb"
LICENSE="AGPL-3"
SLOT=0
KEYWORDS="~amd64"
IUSE=""

DEPEND="$(unpacker_src_uri_depends)"

# TheHive 3.4.0-RC1 added support to elasticsearch 6, but it's still in Beta
# https://github.com/TheHive-Project/TheHiveDocs/issues/105#issuecomment-501198731
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

pkg_postinst() {
	ewarn "\n1) Before starting please change the line from file \"application.conf\" (/etc/thehive/application.conf):"
	ewarn "    #play.http.secret.key=\"***changeme***\""
	ewarn "  to"
	ewarn "    play.http.secret.key=\"<YoUr_some_Secret_KeY>\""
	ewarn "\n2) Configure search engine. Use a descriptive name for your cluster/node (/etc/elasticsearch/elasticsearch.yml):"
	ewarn "    cluster.name: hive"
	ewarn "    node.name: the_hive"
	einfo "\n3) Start the \"thehive\" service:"
	einfo "    ~$ sudo rc-service thehive start"
	einfo "\n4) Wait a few seconds and open in your browser: http://127.0.0.1:9000\n"
	einfo "See documentation: https://github.com/TheHive-Project/TheHiveDocs\n"
}
