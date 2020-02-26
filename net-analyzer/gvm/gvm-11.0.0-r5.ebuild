# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Greenbone Vulnerability Management, OpenVAS"
HOMEPAGE="https://www.greenbone.net/en/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="cli cron extras +gsa ldap ospd radius"

RDEPEND="
	>=net-analyzer/gvm-libs-11.0.0[extras?,ldap?,radius?]
	>=net-analyzer/gvmd-9.0.0[extras?]
	>=net-analyzer/openvas-scanner-7.0.0
	!~net-analyzer/openvas-9.0.0
	>=net-analyzer/ospd-openvas-1.0.0
	cli? ( >=net-analyzer/gvm-tools-2.0.0 )
	gsa? ( >=net-analyzer/greenbone-security-assistant-8.0.1[extras?] )
	ospd? ( >=net-analyzer/ospd-2.0.0[extras?] )"

pkg_postinst() {
	elog "We run openvas under 'gvm:gvm' user/group"
	elog "Please prepend 'sudo -u gvm' to all cli commands, for example:"
	elog "sudo -u gvm gvmd --create-user admin --password admin"
	elog "sudo -u gvm greenbone-certdata-sync"
	elog
	elog "Please following the following URL to configure:"
	elog "https://wiki.alpinelinux.org/wiki/Setting_up_GVM10"
	elog "In the following manual, replace user 'mattm' with 'gvm'"
	elog "https://github.com/greenbone/gvmd/blob/master/INSTALL.md"
	elog
	elog "Also, change permissions to the following:"
	elog "chown -R gvm /var/lib/gvm"
	elog
	elog "Additional support for extra checks can be get from"
	optfeature "Web server scanning and testing tool" net-analyzer/nikto
	optfeature "Portscanner" net-analyzer/nmap
	optfeature "IPsec VPN scanning, fingerprinting and testing tool" net-analyzer/ike-scan
	optfeature "Application protocol detection tool" net-analyzer/amap
	optfeature "ovaldi (OVAL) — an OVAL Interpreter" app-forensics/ovaldi
	optfeature "Linux-kernel-based portscanner" net-analyzer/portbunny
	optfeature "Web application attack and audit framework" net-analyzer/w3af
}
