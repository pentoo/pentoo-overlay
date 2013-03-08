# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/metasploit/metasploit-3.1_p5699-r1.ebuild,v 1.3 2008/11/09 14:52:13 nixnut Exp $

EAPI="5"
inherit eutils git-2

MY_P=${PN/metasploit/framework}-${PV}

EGIT_REPO_URI="https://github.com/rapid7/metasploit-framework.git"

SRC_URI="https://dev.metasploit.com/redmine/attachments/download/906/vbsmem-1.2.1.patch
	https://dev.metasploit.com/redmine/attachments/1200/jboss_seam_remote_command_rb"

DESCRIPTION="Advanced open-source framework for developing, testing, and using vulnerability exploit code"
HOMEPAGE="http://www.metasploit.org/"
SLOT="9999"
LICENSE="BSD"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+armitage +java gui unstable lorcon +pcaprub serialport"

#Note: we no longer use bundled gems.
RDEPEND="dev-lang/ruby[ssl]
	>=dev-ruby/activesupport-3.0.0
	>=dev-ruby/activerecord-3.2.11
	dev-ruby/json
	=dev-ruby/metasploit_data_models-0.6.1
	dev-ruby/msgpack
	dev-ruby/nokogiri
	dev-ruby/builder:3
	>=dev-ruby/pg-0.11
	dev-ruby/robots
	dev-ruby/kissfft
	app-admin/eselect-metasploit
	>=app-crypt/johntheripper-1.7.9-r1[-minimal]
	!arm? ( gui? ( virtual/jre )
		java? ( dev-ruby/rjb ) )
	dev-db/postgresql-server
	pcaprub? ( net-libs/libpcap )
	armitage? ( net-analyzer/nmap
			virtual/jre )
	lorcon? ( net-wireless/lorcon[ruby] )"
DEPEND=""

RESTRICT="strip"

QA_PREBUILT="
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_x86_linux.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_armle_linux.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_x86_solaris.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_x64_linux.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_x86_bsd.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/meterpreter/msflinker_linux_x86.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/meterpreter/ext_server_sniffer.lso
	usr/$(get_libdir)/${PN}${SLOT}/data/meterpreter/ext_server_networkpug.lso
	usr/$(get_libdir)/${PN}${SLOT}/data/meterpreter/ext_server_stdapi.lso
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_x86_linux.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_armle_linux.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_x86_solaris.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_x64_linux.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_x86_bsd.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/meterpreter/msflinker_linux_x86.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/meterpreter/ext_server_sniffer.lso
	usr/$(get_libdir)/${PN}${SLOT}/data/meterpreter/ext_server_networkpug.lso
	usr/$(get_libdir)/${PN}${SLOT}/data/meterpreter/ext_server_stdapi.lso
	"

S=${WORKDIR}/${MY_P}

src_prepare() {
	#so much cruft is bundled with msf that we will fix it in src_prepare to make intentions more clear

	#unbundle johntheripper, at least it now defaults to running the system version
	rm -rf "${S}"/data/john/run.*
	rm -rf "${S}"/data/john/src.tar.bz2
	#remove random "cpuinfo" binaries which a only needed to detect which bundled john to run
	rm -rf "${S}"/data/cpuinfo/*

	#remove random included sources
	rm -rf "${S}"/external/source

	#remove unused "external" modules
	rm -rf "${S}"/external/ruby-kissfft
	rm -rf "${S}"/external/ruby-lorcon
	rm -rf "${S}"/external/ruby-lorcon2

	#remove unneeded developmentish stuff
	rm -rf "${S}"/spec
	rm -rf "${S}"/test

	#unbundle the ruby gems, we now use system gems
	rm -rf "${S}"/lib/gemcache/
	rm -rf "${S}"/Gemfile
	rm -rf "${S}"/Gemfile.lock
	rm -rf "${S}"/Rakefile

	#whiles we are commiting fixes for filth, let's bogart msfupdate
	rm "${S}"/msfupdate
	echo "#!/bin/sh" > "${S}"/msfupdate
	echo "echo \"[*]\"" >> "${S}"/msfupdate
	echo "echo \"[*] Attempting to update the Metasploit Framework...\"" >> "${S}"/msfupdate
	echo "echo \"[*]\"" >> "${S}"/msfupdate
	echo "echo \"\"" >> "${S}"/msfupdate
	echo "ESVN_REVISION=HEAD emerge --oneshot \"=${CATEGORY}/${PF}\"" >> "${S}"/msfupdate
	#this is set executable in src_install
}
src_compile() {
	if use pcaprub; then
		cd "${S}"/external/pcaprub
		ruby extconf.rb
		emake
	fi
	if use serialport; then
		cd "${S}"/external/serialport
		ruby extconf.rb
		emake
	fi
}

src_install() {
	# should be as simple as copying everything into the target...
	dodir /usr/$(get_libdir)/${PN}${SLOT}
	cp -R "${S}"/* "${ED}"/usr/$(get_libdir)/${PN}${SLOT} || die "Copy files failed"
	rm -Rf "${ED}"/usr/$(get_libdir)/${PN}${SLOT}/documentation "${ED}"/usr/$(get_libdir)/${PN}${SLOT}/README.md
	fowners -R root:0 /

	# do not remove LICENSE, bug #238137
	dodir /usr/share/doc/${PF}
	cp -R "${S}"/{documentation,README.md} "${ED}"/usr/share/doc/${PF} || die
	dosym /usr/share/doc/${PF}/documentation /usr/$(get_libdir)/${PN}${SLOT}/documentation

	newinitd "${FILESDIR}"/msfrpcd.initd msfrpcd${SLOT}
	newconfd "${FILESDIR}"/msfrpcd.confd msfrpcd${SLOT}

	if use armitage; then
		insinto /usr/$(get_libdir)/${PN}${SLOT}/
		doins  "${FILESDIR}"/armitage.yml
	fi

	#Add new modules from metasploit bug report system not in the main tree yet
	if use unstable; then

		#smart hasdump from http://www.darkoperator.com/blog/2011/5/19/metasploit-post-module-smart_hashdump.html
		#https://github.com/darkoperator/Meterpreter-Scripts
		cp "${FILESDIR}"/smart_hasdump_script_6ac6c1d.rb "${ED}"/usr/$(get_libdir)/${PN}${SLOT}/scripts/meterpreter/smart_hasdump.rb || die "Copy files failed"
		cp "${FILESDIR}"/hashdump2_script_6ac6c1d.rb "${ED}"/usr/$(get_libdir)/${PN}${SLOT}/scripts/meterpreter/hashdump2.rb || die "Copy files failed"

		#JBoss remote command execution exploit
		#https://dev.metasploit.com/redmine/issues/4585
		cp "${DISTDIR}"/jboss_seam_remote_command_rb "${ED}"/usr/$(get_libdir)/${PN}${SLOT}/modules/exploits/multi/http/jboss_seam_remote_command.rb || die "Copy files failed"

	fi
	#fi unstable

	if use pcaprub; then
		cd "${S}"/external/pcaprub
		emake DESTDIR="${ED}" install
	fi
	if use serialport; then
		cd "${S}"/external/serialport
		emake DESTDIR="${ED}" install
	fi

	#force to use the outdated bundled version of metasm
	doenvd "${FILESDIR}"/91metasploit-${SLOT}

	fperms +x /usr/$(get_libdir)/${PN}${SLOT}/msfupdate

	if use gui; then
		make_desktop_entry msfgui${SLOT} "Metasploit Framework" metasploit 'GNOME;System;Network;'
		doicon "${FILESDIR}"/metasploit.icon
	else
		rm "${ED}"/usr/$(get_libdir)/${PN}${SLOT}/msfgui
	fi
}

pkg_postinst() {
	elog "You need to prepare the database by running:"
	elog "emerge --config postgresql-server"
	elog "/etc/init.d/postgresql-<version> start"
	elog "emerge --config =metasploit-${PV}"

	"${EROOT}"/usr/bin/eselect metasploit set --use-old ${PN}${SLOT}

	elog
	elog "To switch between installed slots, execute as root:"
	elog " # eselect metasploit set [slot number]"
	elog
	elog "Adjust /usr/lib/${PN}/armitage.yml and /etc/conf.d/msfrpcd${PV} files if necessary"
	elog "You might need to run env-update and relogin"
}

pkg_config() {
	einfo "If the following fails, it is likely because you forgot to start/config postgresql first"
	su postgres -c "createuser msf_user -D -S -R"
	su postgres -c "createdb --owner=msf_user msf_database"
}
