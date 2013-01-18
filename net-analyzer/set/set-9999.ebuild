# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"
MY_P=${PN/set/social_engineering_toolkit}

inherit git-2 multilib
SRC_URI=""
EGIT_REPO_URI="https://github.com/trustedsec/social-engineer-toolkit.git"
DESCRIPTION="A social engineering framework"
HOMEPAGE="https://www.trustedsec.com/downloads/social-engineer-toolkit/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="ettercap"

QA_PREBUILT="
	usr/$(get_libdir)/set/src/payloads/ratte/ratteserver
	usr/$(get_libdir)/set/src/payloads/set_payloads/shell.linux
"

# blocker on ruby-1.8.7:
# http://spool.metasploit.com/pipermail/framework/2008-September/003671.html
RDEPEND="virtual/jdk
	net-analyzer/metasploit
	dev-python/pexpect
	net-misc/wget
	dev-python/pyopenssl
	ettercap? ( net-analyzer/ettercap )
	|| ( mail-mta/postfix
	     mail-mta/sendmail
	     mail-mta/ssmtp )"
DEPEND=""

S=${WORKDIR}/${MY_P}

src_compile() {
	if has_version mail-mta/postfix
	then
		sed -e 's:/etc/init.d/sendmail:/etc/init.d/postfix:g' \
					-i src/smtp/client/smtp_web.py \
					   src/smtp/client/smtp_client.py
	fi
	# We forced postfix or sendmail anyway
	sed -e 's:SENDMAIL=OFF:SENDMAIL=ON:' -i config/set_config
	sed -e 's:METASPLOIT_PATH=.*:METASPLOIT_PATH=/usr/lib/metasploit/:' -i config/set_config
}

src_install() {
	# We have global agreement
	touch "${S}"/src/agreement4

	# should be as simple as copying everything into the target...
	dodir /usr/$(get_libdir)/${PN}
	cp -R "${S}"/* "${D}"/usr/$(get_libdir)/${PN} || die "Copy files failed"
	rm -Rf "${D}"/usr/$(get_libdir)/${PN}/readme

	#we don't need a dynamically compiled wget, we have that
	rm -rf "${D}"/usr/$(get_libdir)/set/src/webattack/web_clone/linux
	#especially not for MacOSX
	rm -rf "${D}"/usr/$(get_libdir)/set/src/webattack/web_clone/osx

	#remove more broken staticly compiled crap
	rm -rf "${D}"/usr/$(get_libdir)/set/src/wireless/airbase-ng
	rm -rf "${D}"/usr/$(get_libdir)/set/src/wireless/airmon-ng

	dodir /usr/share/doc/${PF}
	cp -R "${S}"/readme/* "${D}"/usr/share/doc/${PF}
	dosym /usr/share/doc/${PF} /usr/$(get_libdir)/${PN}/readme

	newsbin "${FILESDIR}"/set ${MY_P}

	chown -R root:0 "${D}"
}

pkg_postinst() {
	elog "If you wish to update ${PN} simply run:"
	elog
	elog "emerge ${PF}"
	elog
}
