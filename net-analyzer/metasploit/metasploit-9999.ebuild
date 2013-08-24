# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit eutils

MY_P=${PN/metasploit/framework}-${PV}

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/rapid7/metasploit-framework.git"
	inherit git-2
	KEYWORDS=""
	S="${WORKDIR}/${MY_P}"
else
	#https://github.com/rapid7/metasploit-framework/wiki/Downloads-by-Version
	SRC_URI="http://downloads.metasploit.com/data/releases/archive/framework-${PV}.tar.bz2"
	KEYWORDS="~amd64 ~arm ~x86"
	S="${WORKDIR}"/msf3
fi

DESCRIPTION="Advanced open-source framework for developing, testing, and using vulnerability exploit code"
HOMEPAGE="http://www.metasploit.org/"
SLOT="9999"
LICENSE="BSD"
IUSE="development +java lorcon +pcap test"

COMMON_DEPEND="dev-db/postgresql-server
	dev-lang/ruby:1.9[ssl]
	>=dev-ruby/activesupport-3.0.0[ruby_targets_ruby19]
	>=dev-ruby/activerecord-3.2.11[ruby_targets_ruby19]
	dev-ruby/json[ruby_targets_ruby19]
	>=dev-ruby/metasploit_data_models-0.16.6[ruby_targets_ruby19]
	dev-ruby/msgpack[ruby_targets_ruby19]
	dev-ruby/nokogiri[ruby_targets_ruby19]
	dev-ruby/builder:3[ruby_targets_ruby19]
	>=dev-ruby/pg-0.11[ruby_targets_ruby19]
	>=dev-ruby/packetfu-1.1.8[ruby_targets_ruby19]
	dev-ruby/robots[ruby_targets_ruby19]
	dev-ruby/kissfft[ruby_targets_ruby19]
	>=app-crypt/johntheripper-1.7.9-r1[-minimal]
	net-analyzer/nmap
	!arm? ( java? ( dev-ruby/rjb[ruby_targets_ruby19] ) )
	pcap? ( dev-ruby/pcaprub[ruby_targets_ruby19]
		dev-ruby/network_interface[ruby_targets_ruby19] )
	lorcon? ( net-wireless/lorcon[ruby] )
	dev-ruby/bundler[ruby_targets_ruby19]
	development? ( dev-ruby/redcarpet[ruby_targets_ruby19]
			dev-ruby/yard[ruby_targets_ruby19]
			dev-ruby/rake[ruby_targets_ruby19]
			>=dev-ruby/factory_girl-4.1.0[ruby_targets_ruby19] )"
DEPEND="${COMMON_DEPEND}
	test? (	>=dev-ruby/factory_girl-4.1.0[ruby_targets_ruby19]
		dev-ruby/rake[ruby_targets_ruby19]
		dev-ruby/database_cleaner[ruby_targets_ruby19]
		>=dev-ruby/rspec-2.12[ruby_targets_ruby19]
		dev-ruby/shoulda-matchers[ruby_targets_ruby19]
		dev-ruby/timecop[ruby_targets_ruby19] )
		=dev-ruby/simplecov-0.5.4
	"

RDEPEND="${COMMON_DEPEND}
	>=app-admin/eselect-metasploit-0.10"

RESTRICT="strip"

QA_PREBUILT="
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_x86_linux.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_armle_linux.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_x86_solaris.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_x64_linux.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_x86_bsd.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_mipsbe_linux.bin
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_mipsle_linux.bin
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
	usr/$(get_libdir)/${PN}${SLOT}/data/exploits/CVE-2013-2171.bin
	"

src_prepare() {
	#so much cruft is bundled with msf that we will fix it in src_prepare to make intentions more clear

	#stop asking about bloody bundler
	#sed -i "/require 'bundler\/setup'/d" lib/msfenv.rb

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

	#remove unneeded ruby bundler versioning files
	#Gemfile.lock contains the versions tested by the msf team but not the hard requirements
	#we regen this file with src_test
	rm -f "${S}"/Gemfile.lock
	#The Gemfile contains real known deps, we keep it for use in src_test
	#rm -f "${S}"/Gemfile
	#now we edit the Gemfile based on use flags
	#even if we pass --without=blah bundler still calculates the deps and messes us up
	if ! use pcap; then
		sed -i -e "/^group :pcap do/,/^end$/d" Gemfile || die
	fi
	if ! use development; then
		sed -i -e "/^group :development do/,/^end$/d" Gemfile || die
	fi
	if ! use test; then
		sed -i -e "/^group :test/,/^end$/d" Gemfile || die
	fi
	if ! use test && ! use development; then
		sed -i -e "/^group :development/,/^end$/d" Gemfile || die
	fi
	bundle install --local || die
	bundle check || die

	#they removed bundled armitage from releases so let's just keep it external
	rm -rf "${S}"/armitage "${S}"/data/armitage

	#whiles we are commiting fixes for filth, let's bogart msfupdate
	rm "${S}"/msfupdate
	echo "#!/bin/sh" > "${S}"/msfupdate
	echo "echo \"[*]\"" >> "${S}"/msfupdate
	echo "echo \"[*] Attempting to update the Metasploit Framework...\"" >> "${S}"/msfupdate
	echo "echo \"[*]\"" >> "${S}"/msfupdate
	echo "echo \"\"" >> "${S}"/msfupdate
	if [[ ${PV} == "9999" ]] ; then
		echo "ESVN_REVISION=HEAD emerge --oneshot \"=${CATEGORY}/${PF}\"" >> "${S}"/msfupdate
	else
		echo "echo \"Unable to update tagged version of metasploit.\"" >> "${S}"/msfupdate
		echo "echo \"If you want the latest please install and eselect the live version (metasploit9999)\"" >> "${S}"/msfupdate
		echo "echo \"emerge metasploit:9999 -vat && eselect metasploit set metasploit9999\"" >> "${S}"/msfupdate
	fi
	#this is set executable in src_install

	#force all metasploit executables to ruby19, ruby18 is not supported anymore and ruby20 is not supported yet
	#https://dev.metasploit.com/redmine/issues/8357
	for file in $(ls -1 "${S}"/msf*)
	do
		#poorly adapted from python.eclass
		sed -e "1s:^#![[:space:]]*\([^[:space:]]*/usr/bin/env[[:space:]]\)\?[[:space:]]*\([^[:space:]]*/\)\?ruby\([[:digit:]]\+\(\.[[:digit:]]\+\)\?\)\?\(\$\|[[:space:]].*\):#!\1\2ruby19:" -i "${file}" || die "Conversion of shebang in '${file}' failed"
	done
}

#serialport does not work with ruby19 at this time
#src_compile() {
#	if use serialport; then
#		cd "${S}"/external/serialport
#		ruby extconf.rb
#		emake
#	fi
#}

src_install() {
	#if ! use test; then
		#remove unneeded testing stuff
		rm -rf "${S}"/spec
		rm -rf "${S}"/test
	#fi

	# should be as simple as copying everything into the target...
	dodir /usr/$(get_libdir)/${PN}${SLOT}
	cp -R "${S}"/* "${ED}"/usr/$(get_libdir)/${PN}${SLOT} || die "Copy files failed"
	rm -Rf "${ED}"/usr/$(get_libdir)/${PN}${SLOT}/documentation "${ED}"/usr/$(get_libdir)/${PN}${SLOT}/README.md
	fowners -R root:0 /

	# do not remove LICENSE, bug #238137
	dodir /usr/share/doc/${PF}
	cp -R "${S}"/{documentation,README.md} "${ED}"/usr/share/doc/${PF} || die
	dosym /usr/share/doc/${PF}/documentation /usr/$(get_libdir)/${PN}${SLOT}/documentation

	#install our database.yml file
	insinto /usr/$(get_libdir)/${PN}${SLOT}/config/
	doins  "${FILESDIR}"/database.yml

	#does not work with ruby19 at this time
	#if use serialport; then
	#	cd "${S}"/external/serialport
	#	emake DESTDIR="${ED}" install
	#fi

	fperms +x /usr/$(get_libdir)/${PN}${SLOT}/msfupdate
}

pkg_postinst() {
	elog "You need to prepare the database by running:"
	elog "emerge --config postgresql-server"
	elog "/etc/init.d/postgresql-<version> start"
	elog "emerge --config =metasploit-${PV}"

	"${EROOT}"/usr/bin/eselect metasploit set --use-old ${PN}${SLOT}

	einfo
	elog "Adjust /usr/lib/${PN}${SLOT}/config/database.yml if necessary"
}

pkg_config() {
	einfo "If the following fails, it is likely because you forgot to start/config postgresql first"
	su postgres -c "createuser msf_user -D -S -R"
	su postgres -c "createdb --owner=msf_user msf_database"
}
