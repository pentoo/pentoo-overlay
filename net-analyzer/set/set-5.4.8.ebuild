# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"


PYTHON_DEPEND="2"
inherit multilib eutils python

if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/trustedsec/social-engineer-toolkit.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/trustedsec/social-engineer-toolkit/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~x86"
	MY_P=${P/set/social-engineer-toolkit}
	S=${WORKDIR}/${MY_P}
fi

DESCRIPTION="A social engineering framework"
HOMEPAGE="https://www.trustedsec.com/downloads/social-engineer-toolkit/"

LICENSE="BSD"
SLOT="0"
IUSE="+ettercap +wireless"

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
	dev-python/beautifulsoup:python-2
	dev-python/pymssql
	dev-python/pyopenssl
	ettercap? ( net-analyzer/ettercap )
	wireless? ( net-wireless/aircrack-ng
		net-analyzer/dsniff )
	|| ( mail-mta/ssmtp
		mail-mta/postfix
		mail-mta/sendmail )"
DEPEND=""


pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .

	if has_version mail-mta/ssmtp
	then
		epatch "${FILESDIR}"/${PN}-5.3.4-ssmtp.patch
	fi
	if has_version mail-mta/postfix
	then
		sed -e 's:/etc/init.d/sendmail:/etc/init.d/postfix:g' \
					-i src/phishing/smtp/client/smtp_web.py \
					   src/phishing/smtp/client/smtp_client.py
	fi
	# We forced postfix or sendmail anyway
	sed -e 's:SENDMAIL=OFF:SENDMAIL=ON:' -i config/set_config
	sed -e 's:METASPLOIT_PATH=.*:METASPLOIT_PATH=/usr/lib/metasploit/:' -i config/set_config

	# fix paths for airbase, dnsspoof
	sed -e 's|/usr/local/sbin/|/usr/sbin/|' -i config/set_config
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
	rm -rf "${D}"/usr/$(get_libdir)/set/src/wireless/{airbase-ng,airmon-ng}
	#remove other unnecessary files
	rm -rf "${D}"/usr/$(get_libdir)/set/{setup.py,set-update}

	dodir /usr/share/doc/${PF}
	cp -R "${S}"/readme/* "${D}"/usr/share/doc/${PF}
	dosym /usr/share/doc/${PF} /usr/$(get_libdir)/${PN}/readme

	dosbin "${FILESDIR}"/{setoolkit,set-automate,set-proxy,set-web}
	#make all tools start with set-<name>
	dosym /usr/sbin/setoolkit /usr/sbin/set-toolkit
	dosym /usr/sbin/setoolkit /usr/sbin/se-toolkit

	chown -R root:0 "${D}"
}

#It's just to buggy that python_mod_optimize doesn't help.
#pkg_postinst() {
#	python_mod_optimize /usr/$(get_libdir)/set/src/core/set.py \
#		/usr/$(get_libdir)/set/config/update_config.py \
#		/usr/$(get_libdir)/set/src/phishing/smtp/client/smtp_web.py
#}

#pkg_postrm() {
	# Set is not coded properly.
	# We use the workaround below to remove set_config.py and other pyc/pyo files
#	rm -rf "/usr/$(get_libdir)/set"
#}
