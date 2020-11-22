# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#never ever ever have more than one ruby in here
#TODO: use ruby-single instead?
USE_RUBY="ruby26"
inherit eutils ruby-ng

##Tags https://github.com/rapid7/metasploit-framework/releases
MY_PV=${PV/_p/-}
SRC_URI="https://github.com/rapid7/metasploit-framework/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
RUBY_S="${PN}-framework-${MY_PV}"
SLOT="$(ver_cut 1).$(ver_cut 2)"

DESCRIPTION="Advanced framework for developing, testing, and using vulnerability exploit code"
HOMEPAGE="http://www.metasploit.org/"
LICENSE="BSD"
IUSE="development +java nexpose oracle +pcap test"

#multiple known bugs with tests reported upstream and ignored
#http://dev.metasploit.com/redmine/issues/8418 - worked around (fix user creation when possible)
RESTRICT="test"

#grep spec.add_runtime_dependency metasploit-framework.gemspec | sort
RUBY_COMMON_DEPEND="virtual/ruby-ssl
	>=dev-ruby/actionpack-5.2.2:5.2
	>=dev-ruby/activerecord-5.2.2:5.2
	>=dev-ruby/activesupport-5.2.2:5.2
	dev-ruby/bcrypt-ruby
	dev-ruby/bcrypt_pbkdf
	dev-ruby/bit-struct
	dev-ruby/bson
	dev-ruby/bundler:2
	dev-ruby/concurrent-ruby
	dev-ruby/dnsruby
	dev-ruby/ed25519
	dev-ruby/em-http-request
	dev-ruby/eventmachine
	dev-ruby/faker:2
	dev-ruby/faraday
	dev-ruby/faye-websocket
	dev-ruby/filesize:*
	dev-ruby/hrr_rb_ssh
	dev-ruby/irb
	dev-ruby/jsobfu:*
	dev-ruby/json:*
	dev-ruby/metasm:*
	dev-ruby/metasploit-concern
	dev-ruby/metasploit-credential
	dev-ruby/metasploit_data_models
	dev-ruby/metasploit-model
	dev-ruby/metasploit-payloads:2.0.12
	dev-ruby/metasploit_payloads-mettle:1.0.2
	dev-ruby/mqtt
	dev-ruby/msgpack
	dev-ruby/ruby-net-ldap
	dev-ruby/net-ssh:*
	dev-ruby/network_interface
	dev-ruby/nokogiri
	dev-ruby/octokit
	dev-ruby/openssl-ccm
	dev-ruby/packetfu
	dev-ruby/patch_finder
	dev-ruby/pcaprub
	dev-ruby/pdf-reader:*
	dev-ruby/pg:*
	dev-ruby/railties:5.2
	dev-ruby/rb-readline
	dev-ruby/recog:*
	dev-ruby/redcarpet
	dev-ruby/rex-arch
	dev-ruby/rex-bin_tools
	dev-ruby/rex-core
	dev-ruby/rex-encoder
	dev-ruby/rex-exploitation
	dev-ruby/rex-java
	dev-ruby/rex-mime
	dev-ruby/rex-nop
	dev-ruby/rex-ole
	dev-ruby/rex-powershell
	dev-ruby/rex-random_identifier
	dev-ruby/rex-registry
	dev-ruby/rex-rop_builder
	dev-ruby/rex-socket
	dev-ruby/rex-sslscan
	dev-ruby/rex-struct2
	dev-ruby/rex-text
	dev-ruby/rex-zip
	dev-ruby/ruby-macho
	dev-ruby/rubyntlm
	>=dev-ruby/ruby_smb-2.0.0
	dev-ruby/rubyzip:*
	dev-ruby/sinatra
	=dev-ruby/sqlite3-1.3*
	dev-ruby/sshkey
	www-servers/thin
	dev-ruby/tzinfo:*
	dev-ruby/warden
	dev-ruby/windows_error
	dev-ruby/xdr
	dev-ruby/xmlrpc
	java? ( dev-ruby/rjb )
	nexpose? ( dev-ruby/nexpose )
	oracle? ( dev-ruby/ruby-oci8 )
	pcap? ( dev-ruby/pcaprub:*
		dev-ruby/network_interface )
	development? ( dev-ruby/fivemat
			dev-ruby/pry
			dev-ruby/redcarpet
			dev-ruby/yard
			>=dev-ruby/rake-10.0.0
			>=dev-ruby/factory_girl-4.1.0 )"
	#lorcon doesn't support ruby21
	#lorcon? ( net-wireless/lorcon[ruby] )
ruby_add_bdepend "${RUBY_COMMON_DEPEND}
		test? ( >=dev-ruby/factory_girl-4.1.0
			dev-ruby/fivemat
			dev-ruby/database_cleaner
			>=dev-ruby/rspec-2.12
			dev-ruby/shoulda-matchers
			dev-ruby/timecop
			>=dev-ruby/rake-10.0.0 )

"
ruby_add_rdepend "${RUBY_COMMON_DEPEND}"

COMMON_DEPEND="dev-db/postgresql:*[server]
	|| ( app-crypt/johntheripper-jumbo >=app-crypt/johntheripper-1.7.9-r1[-minimal(-)] )
	dev-libs/libxml2
	dev-libs/libxslt
	dev-libs/openssl
	net-analyzer/nmap
	net-libs/libpcap
	sys-libs/zlib"
RDEPEND+=" ${COMMON_DEPEND}
	>=app-eselect/eselect-metasploit-0.16"

RESTRICT="strip"

QA_PREBUILT="
	usr/lib*/${PN}${SLOT}/data/templates/template_x86_linux.bin
	usr/lib*/${PN}${SLOT}/data/templates/template_armle_linux.bin
	usr/lib*/${PN}${SLOT}/data/templates/template_x86_solaris.bin
	usr/lib*/${PN}${SLOT}/data/templates/template_x64_linux.bin
	usr/lib*/${PN}${SLOT}/data/templates/template_x64_linux_dll.bin
	usr/lib*/${PN}${SLOT}/data/templates/template_x86_bsd.bin
	usr/lib*/${PN}${SLOT}/data/templates/template_x64_bsd.bin
	usr/lib*/${PN}${SLOT}/data/templates/template_mipsbe_linux.bin
	usr/lib*/${PN}${SLOT}/data/templates/template_mipsle_linux.bin
	usr/lib*/${PN}${SLOT}/data/meterpreter/msflinker_linux_x86.bin
	usr/lib*/${PN}${SLOT}/data/meterpreter/ext_server_sniffer.lso
	usr/lib*/${PN}${SLOT}/data/meterpreter/ext_server_networkpug.lso
	usr/lib*/${PN}${SLOT}/data/meterpreter/ext_server_stdapi.lso
	usr/lib*/${PN}${SLOT}/data/exploits/CVE-2013-2171.bin
	usr/lib*/${PN}${SLOT}/data/exploits/CVE-2014-3153.elf
	usr/lib*/${PN}${SLOT}/data/exploits/mysql/lib_mysqludf_sys_32.so
	usr/lib*/${PN}${SLOT}/data/exploits/*
	usr/lib*/${PN}${SLOT}/data/exploits/CVE-2012-6636/armeabi/libndkstager.so
	usr/lib*/${PN}${SLOT}/data/exploits/CVE-2012-6636/mips/libndkstager.so
	usr/lib*/${PN}${SLOT}/data/exploits/CVE-2012-6636/x86/libndkstager.so
	usr/lib*/${PN}${SLOT}/data/exploits/CVE-2013-2171.bin
	usr/lib*/${PN}${SLOT}/data/exploits/CVE-2013-6282.so
	usr/lib*/${PN}${SLOT}/data/exploits/CVE-2014-3153.so
	usr/lib*/${PN}${SLOT}/data/exploits/CVE-2016-4557/hello
	usr/lib*/${PN}${SLOT}/data/exploits/CVE-2019-2215/exploit
	usr/lib*/${PN}${SLOT}/data/templates/template_x86_linux_dll.bin
	usr/lib*/${PN}${SLOT}/data/templates/template_armle_linux_dll.bin
	usr/lib*/${PN}${SLOT}/data/templates/template_aarch64_linux.bin
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/*/*/*
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/aarch64-linux-musl/bin/mettle
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/aarch64-linux-musl/bin/mettle.bin
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/aarch64-linux-musl/bin/sniffer
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/armv5b-linux-musleabi/bin/mettle
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/armv5b-linux-musleabi/bin/mettle.bin
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/armv5b-linux-musleabi/bin/sniffer
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/armv5l-linux-musleabi/bin/mettle
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/armv5l-linux-musleabi/bin/mettle.bin
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/armv5l-linux-musleabi/bin/sniffer
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/i486-linux-musl/bin/mettle
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/i486-linux-musl/bin/mettle.bin
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/mips64-linux-muslsf/bin/mettle
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/mips64-linux-muslsf/bin/mettle.bin
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/mips64-linux-muslsf/bin/sniffer
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/mips64-linux-muslsf/bin/sniffer.bin
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/mipsel-linux-muslsf/bin/mettle
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/mipsel-linux-muslsf/bin/mettle.bin
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/mipsel-linux-muslsf/bin/sniffer
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/mipsel-linux-muslsf/bin/sniffer.bin
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/mips-linux-muslsf/bin/mettle
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/mips-linux-muslsf/bin/mettle.bin
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/mips-linux-muslsf/bin/sniffer
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/mips-linux-muslsf/bin/sniffer.bin
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/powerpc64le-linux-musl/bin/mettle
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/powerpc64le-linux-musl/bin/mettle.bin
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/powerpc-linux-muslsf/bin/mettle
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/powerpc-linux-muslsf/bin/mettle.bin
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/s390x-linux-musl/bin/mettle
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/s390x-linux-musl/bin/mettle.bin
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/x86_64-linux-musl/bin/mettle
	usr/lib*/${PN}${SLOT}/vendor/ruby/*/gems/metasploit_payloads-mettle-*/build/x86_64-linux-musl/bin/mettle.bin
	"
QA_NO_DEPCHECK="${QA_PREBUILT}"

pkg_setup() {
	if use test; then
		su postgres -c "dropdb msf_test_database" #this is intentionally allowed to fail
		su postgres -c "createuser msf_test_user -d -S -R"
		if [ $? -ne 0 ]; then
			su postgres -c "dropuser msf_test_user" || die
			su postgres -c "createuser msf_test_user -d -S -R" || die
		fi
		su postgres -c "createdb --owner=msf_test_user msf_test_database" || die
	fi
	ruby-ng_pkg_setup
}

all_ruby_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		git-r3_src_unpack
	else
		default_src_unpack
#		mv "${WORKDIR}"/all/msf3/* "${WORKDIR}"/all
#		rm -r msf3
		#msf_version=$(grep --color=never "CURRENT_VERSION =" ${S}/spec/lib/msf/core/framework_spec.rb)
		#msf_version=${msf_version#*=}
	fi
}

all_ruby_prepare() {
	# add psexec patch from pull request 2657 to allow custom exe templates from any files, bypassing most AVs
	#epatch "${FILESDIR}/agix_psexec_pull-2657.patch"
	eapply_user

	#remove random "cpuinfo" binaries which a only needed to detect which bundled john to run
#	rm -r data/cpuinfo

	#remove unneeded ruby bundler versioning files
	#Gemfile.lock contains the versions tested by the msf team but not the hard requirements
	#we regen this file in each_ruby_prepare
	rm Gemfile.lock

	#The Gemfile contains real known deps
	sed -i "/gem 'fivemat'/s/, '1.2.1'//" Gemfile || die
	#use released packetfu
	sed -i "s/1.1.13.pre/1.1.13/" metasploit-framework.gemspec || die
	#use the stable pg
	#https://github.com/rapid7/metasploit-framework/issues/10234
	sed -i "s/dependency 'pg', '0.20.0'/dependency 'pg', '0.21.0'/" metasploit-framework.gemspec || die
	#git gems are only for ruby24 support and we are not there yet
	sed -i "/git:/d" Gemfile || die

	#now we edit the Gemfile based on use flags
	if ! use pcap; then
		sed -i -e "/^group :pcap do/,/^end$/d" Gemfile || die
	fi
	if ! use nexpose; then
		sed -i -e "/nexpose/d" metasploit-framework.gemspec || die
	fi
	#no support for nessus right now
	#if ! use nessus; then
		sed -i -e "/nessus/d" metasploit-framework.gemspec || die
	#fi

	#no support for aws-sdk right now
	#if ! use aws; then
		sed -i -e "/aws-sdk/d" metasploit-framework.gemspec || die
	#fi

	#this version is old, remove it
	sed -i -e "/openvas-omp/d" metasploit-framework.gemspec || die
	#even if we pass --without=blah bundler still calculates the deps and messes us up
	if ! use development; then
		sed -i -e "/^group :development do/,/^end$/d" Gemfile || die
	fi
	if ! use test; then
		sed -i -e "/^group :test/,/^end$/d" Gemfile || die
	fi
	if ! use test && ! use development; then
		sed -i -e "/^group :development/,/^end$/d" Gemfile || die
	fi
	#We don't need simplecov
	sed -i -e "/^group :coverage/,/^end$/d" Gemfile || die
	sed -i -e "s#require 'simplecov'##" spec/spec_helper.rb || die

	#we need to edit the gemspec too, since it tries to call git instead of anything sane
	#probably a better way to fix this... if I care at some point
	sed -i -e "/^  spec.files/,/^  }/d" metasploit-framework.gemspec || die

	#https://bugs.gentoo.org/show_bug.cgi?id=584522 no tzinfo-data by choice in gentoo
	sed -i '/tzinfo-data/d' metasploit-framework.gemspec || die

	#fails without faraday in Gemfile.lock
	#despite activesupport(?) needing it, it doesn't end up there :-(
	sed -i "/'activesupport'/a \ \ spec.add_runtime_dependency 'faraday'" metasploit-framework.gemspec
	sed -i "/spec.add_runtime_dependency 'faraday'/d" metasploit-framework.gemspec

	sed -i "s|'hrr_rb_ssh', '0.3.0.pre2'|'hrr_rb_ssh'|" metasploit-framework.gemspec

	#let's bogart msfupdate
	rm msfupdate
	echo "#!/bin/sh" > msfupdate
	echo "echo \"[*]\"" >> msfupdate
	echo "echo \"[*] Attempting to update the Metasploit Framework...\"" >> msfupdate
	echo "echo \"[*]\"" >> msfupdate
	echo "echo \"\"" >> msfupdate
	if [[ ${PV} == "9999" ]] ; then
		echo "if [ -x /usr/bin/smart-live-rebuild ]; then" >> msfupdate
		echo "	smart-live-rebuild -f net-analyzer/metasploit" >> msfupdate
		echo "else" >> msfupdate
		echo "	echo \"Please install app-portage/smart-live-rebuild for a better experience.\"" >> msfupdate
		echo "emerge --oneshot \"=${CATEGORY}/${PF}\"" >> msfupdate
		echo "fi" >> msfupdate
	else
		echo "echo \"Unable to update tagged version of metasploit.\"" >> msfupdate
		echo "echo \"If you want the latest please install and eselect the live version (metasploit9999)\"" >> msfupdate
		echo "echo \"emerge metasploit:9999 -vat && eselect metasploit set metasploit9999\"" >> msfupdate
	fi
	#this is set executable in src_install

	#install our database.yml file before tests are run
	cp "${FILESDIR}"/database.yml config/

}

each_ruby_prepare() {
	MSF_ROOT="." BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle install --local || die
	MSF_ROOT="." BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle check || die

	#force all metasploit executables to use desired ruby version
	#https://dev.metasploit.com/redmine/issues/8357
	for file in $(ls -1 msf*)
	do
		#poorly adapted from python.eclass
		sed -e "1s:^#![[:space:]]*\([^[:space:]]*/usr/bin/env[[:space:]]\)\?[[:space:]]*\([^[:space:]]*/\)\?ruby\([[:digit:]]\+\(\.[[:digit:]]\+\)\?\)\?\(\$\|[[:space:]].*\):#!\1\2${RUBY}:" -i "${file}" || die "Conversion of shebang in '${file}' failed"
	done
}

each_ruby_test() {
	#review dev-python/pymongo for ways to make the test compatible with FEATURES=network-sandbox

	#we bogart msfupdate so no point in trying to test it
	rm spec/msfupdate_spec.rb || die
	#we don't really want to be uploading to virustotal during the tests
	rm spec/tools/virustotal_spec.rb || die

	# https://dev.metasploit.com/redmine/issues/8425
	BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle exec rake db:create || die
	BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle exec rake db:migrate || die

	MSF_DATABASE_CONFIG=config/database.yml BUNDLE_GEMFILE=Gemfile ${RUBY} -S bundle exec rake  || die
	su postgres -c "dropuser msf_test_user" || die "failed to cleanup msf_test-user"
}

each_ruby_install() {
	#Tests have already been run, we don't need this stuff
	rm -r spec || die
	rm -r test || die
	rm Gemfile.lock || die

	#I'm 99% sure that this will only work for as long as we only support one ruby version.  Creativity will be needed if we wish to support multiple.
	# should be as simple as copying everything into the target...
	dodir /usr/lib/${PN}${SLOT}
	cp -R * "${ED}"/usr/lib/${PN}${SLOT} || die "Copy files failed"
	rm -Rf "${ED}"/usr/lib/${PN}${SLOT}/documentation "${ED}"/usr/lib${PN}${SLOT}/README.md
	fowners -R root:0 /

}

all_ruby_install() {
	# do not remove LICENSE, bug #238137
	dodir /usr/share/doc/${PF}
	cp -R {documentation,README.md} "${ED}"/usr/share/doc/${PF} || die
	ln -s "../../share/doc/${PF}/documentation" "${ED}/usr/lib/${PN}${SLOT}/documentation"

	fperms +x /usr/lib/${PN}${SLOT}/msfupdate

	#tell revdep-rebuild to ignore binaries meant for the target
	dodir /etc/revdep-rebuild
	cat <<-EOF > "${ED}"/etc/revdep-rebuild/99-metasploit${SLOT}
		#These dirs contain prebuilt binaries for running on the TARGET not the HOST
		SEARCH_DIRS_MASK="/usr/lib/${PN}${SLOT}/data/meterpreter"
		SEARCH_DIRS_MASK="/usr/lib/${PN}${SLOT}/data/exploits"
	EOF
}

pkg_postinst() {
	elog "Before use you should run 'env-update' and '. /etc/profile'"
	elog "otherwise you may be missing important environmental variables."

	elog "You need to prepare the database by running:"
	elog "emerge --config postgresql"
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
