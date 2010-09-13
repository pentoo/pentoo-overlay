# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/smstools/smstools-2.2.20.ebuild,v 1.3 2008/10/31 16:28:50 chainsaw Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Send and receive short messages through GSM modems"
HOMEPAGE="http://smstools3.kekekasvi.com/"
SRC_URI="http://smstools3.kekekasvi.com/packages/${PN}3-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="stats"

RDEPEND="sys-process/procps
	 stats? ( >=dev-libs/mm-1.4.0 )"

S="${WORKDIR}"/smstools3

pkg_setup() {
	enewgroup sms
	enewuser smsd -1 -1 /var/spool/sms sms
}

src_prepare() {
	if use stats; then
		sed -i -e "s:CFLAGS += -D NOSTATS:#CFLAGS += -D NOSTATS:" src/Makefile
	fi
}

src_compile() {
	emake CC="$(tc-getCC)" compile || die "emake failed"
}

src_install() {
	dobin src/smsd || die
	cd "${S}"/scripts
	dobin sendsms sms2html sms2unicode unicode2sms || die
	dobin hex2bin hex2dec email2sms || die
	dodoc mysmsd smsevent smsresend sms2xml sql_demo || die

	keepdir /var/spool/sms/incoming
	keepdir /var/spool/sms/outgoing
	keepdir /var/spool/sms/checked
	chown -R smsd:sms "${D}"/var/spool/sms || die
	chmod g+s "${D}"/var/spool/sms/incoming || die

	newinitd "${FILESDIR}"/smsd.initd smsd || die
	insopts -o smsd -g sms -m0644
	insinto /etc
	newins "${S}"/examples/smsd.conf.easy smsd.conf || die

	dohtml "${S}"/doc/* || die
}

pkg_postinst() {
	touch "${ROOT}"/var/log/smsd.log
	chown -f smsd:sms "${ROOT}"/var/log/smsd.log
}
