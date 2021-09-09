# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P=${P/set/social-engineer-toolkit}

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{8..9} )

inherit eutils python-single-r1 multilib

#https://github.com/trustedsec/social-engineer-toolkit/issues/622
#inherit distutils-r1

DESCRIPTION="A social engineering framework"
HOMEPAGE="https://www.trustedsec.com/downloads/social-engineer-toolkit/"
SRC_URI="https://github.com/trustedsec/social-engineer-toolkit/archive/${PV}.tar.gz -> ${P}.tar.gz"
#very broken
#KEYWORDS="~amd64 ~arm ~x86"

LICENSE="BSD"
SLOT="0"
IUSE="+ettercap +wireless"

QA_PREBUILT="
	usr/lib/set/src/payloads/ratte/ratteserver
	usr/lib/set/src/payloads/set_payloads/shell.linux
"

RDEPEND="virtual/jdk
	net-analyzer/metasploit
	dev-python/pexpect
	net-misc/wget
	dev-python/beautifulsoup4
	dev-python/pymssql
	dev-python/pyopenssl
	ettercap? ( net-analyzer/ettercap )
	wireless? ( net-wireless/aircrack-ng
		net-analyzer/dsniff )
	|| ( mail-mta/ssmtp
		mail-mta/postfix
		mail-mta/sendmail )"
DEPEND=""

S=${WORKDIR}/${MY_P}

src_prepare() {
	python_fix_shebang .

	if has_version mail-mta/ssmtp
	then
		epatch "${FILESDIR}"/${P}-ssmtp.patch
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

	eapply_user
}

src_install() {
	# We have a global license flag, it is BSD anyway
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
