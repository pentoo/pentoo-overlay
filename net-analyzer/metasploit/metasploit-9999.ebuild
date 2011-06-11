# Copyright 1998-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/metasploit/metasploit-3.1_p5699-r1.ebuild,v 1.3 2008/11/09 14:52:13 nixnut Exp $

EAPI="4"

MY_P=${PN/metasploit/framework}-${PV}

# Metasploit uses subversion as a *normal* update mechanism for stable branches
# of the package. This ebuild uses _p<number> inside $PV to install updated up
# to revision <number> version of framework. For more information, take a look
# at bug #195924.
inherit subversion

MTSLPT_REV=${BASH_REMATCH[2]}
ESVN_REPO_URI="https://metasploit.com/svn/framework3/trunk"

# Temporary section for vbsmem patch
# AV payload bypass written by Blair Strang from security-assesstment.com
# see more details at https://dev.metasploit.com/redmine/issues/3894
if use unstable; then
    ESVN_PATCHES="vbsmem-1.2.1.patch"
fi
SRC_URI="https://dev.metasploit.com/redmine/attachments/download/906/vbsmem-1.2.1.patch
	http://dev.metasploit.com/redmine/attachments/download/690/dns_fuzzer.rb"

DESCRIPTION="Advanced open-source framework for developing, testing, and using vulnerability exploit code"
HOMEPAGE="http://www.metasploit.org/"

LICENSE="BSD"
SLOT="3"
KEYWORDS="amd64 arm ppc ~sparc x86"
IUSE="armitage unstable mysql postgres"

REQUIRED_USE="armitage? ( || ( mysql postgres ) )"

# blocker on ruby-1.8.7:
# http://spool.metasploit.com/pipermail/framework/2008-September/003671.html
RDEPEND="dev-lang/ruby
	dev-ruby/rubygems
	virtual/jdk
	dev-ruby/rjb
	dev-ruby/hpricot
	mysql? ( dev-ruby/mysql-ruby
		dev-ruby/activerecord )
	postgres? ( dev-ruby/pg
		dev-db/postgresql-server
		dev-ruby/activerecord )
	armitage? ( net-analyzer/nmap
		!net-analyzer/armitage )"
DEPEND=""

QA_PRESTRIPPED="
	usr/lib/${PN}${SLOT}/data/msflinker_linux_x86.bin
	usr/lib/${PN}${SLOT}/data/templates/template_armle_linux.bin
	usr/lib/${PN}${SLOT}/data/templates/template_x86_linux.bin
	usr/lib/${PN}${SLOT}/data/meterpreter/msflinker_linux_x86.bin
	"

QA_EXECSTACK="
	usr/lib/${PN}${SLOT}/data/msflinker_linux_x86.bin"

QA_WX_LOAD="
	usr/lib/${PN}${SLOT}/data/templates/template_*_linux.bin"

S=${WORKDIR}/${MY_P}

# Temporary section for vbsmem patch
subversion_src_prepare() {
	if use unstable; then
	    cp "${DISTDIR}"/vbsmem-1.2.1.patch "${S}/" || die "patch not found"
	fi
	subversion_bootstrap || die "${ESVN}: unknown problem occurred in subversion_bootstrap."
}

src_install() {
	# should be as simple as copying everything into the target...
	dodir /usr/lib/${PN}${SLOT} || die
	cp -R "${S}"/* "${D}"/usr/lib/${PN}${SLOT} || die "Copy files failed"
	rm -Rf "${D}"/usr/lib/${PN}${SLOT}/documentation "${D}"/usr/lib/${PN}${SLOT}/README || die

	# do not remove LICENSE, bug #238137
	dodir /usr/share/doc/${PF} || die
	cp -R "${S}"/{documentation,README} "${D}"/usr/share/doc/${PF} || die
	dosym /usr/share/doc/${PF}/documentation /usr/lib/${PN}${SLOT}/documentation || die

	dodir /usr/bin/ || die
	for file in `ls msf*`; do
		dosym /usr/lib/${PN}${SLOT}/${file} /usr/bin/${file}${SLOT} || die
		dosym /usr/lib/${PN}${SLOT}/${file} /usr/bin/${file} || die
	done

	fowners -R root:0 / || die

	newinitd "${FILESDIR}"/msfrpcd${SLOT}.initd msfrpcd${SLOT} \
		|| die "newinitd failed"
	newconfd "${FILESDIR}"/msfrpcd${SLOT}.confd msfrpcd${SLOT} \
		|| die "newconfd failed"

	if use armitage; then
		echo -e "#!/bin/sh \n\njava -Xmx256m -jar /usr/lib/${PN}${SLOT}/data/armitage/armitage.jar \$*\n" > armitage
		dobin armitage
	fi

	#Add new modules from metasploit bug report system not in the main tree yet
	if use unstable; then

	#smart hasdump from http://www.darkoperator.com/blog/2011/5/19/metasploit-post-module-smart_hashdump.html
	#https://download.github.com/darkoperator-Meterpreter-Scripts-82d2446.tar.gz
	cp "${FILESDIR}"/smart_hasdump_script_82d2446.rb "${D}"/usr/lib/${PN}${SLOT}/scripts/meterpreter/smart_hasdump.rb || die "Copy files failed"
	cp "${FILESDIR}"/smart_hashdump_post_82d2446.rb "${D}"/usr/lib/${PN}${SLOT}/modules/post/windows/gather/smart_hashdump.rb || die "Copy files failed"

	#dnz fuzzing
	#http://dev.metasploit.com/redmine/issues/3289
	dodir /usr/lib/"${PN}""${SLOT}"/modules/auxiliary/fuzzers/dns/
	cp "${DISTDIR}"/dns_fuzzer.rb "${D}"/usr/lib/${PN}${SLOT}/modules/auxiliary/fuzzers/dns/dns_fuzzer.rb || die "Copy files failed"

	#Slow HTTP POST Denial Of Service
	#https://dev.metasploit.com/redmine/issues/3638

	#EAP-MD5 offline dictionary attack
	#https://dev.metasploit.com/redmine/issues/4439

	#JBoss remote command execution exploit
	#https://dev.metasploit.com/redmine/issues/4585

	fi
}

pkg_postinst() {
	if use postgres||mysql; then
		elog "You need to prepare a database as described on the following page:"
		elog "http://dev.metasploit.com/redmine/projects/framework/wiki/Setting_Up_a_Database"
		elog
	fi
	if [[ "${SRC_URI}" == "" ]] ; then
		elog "If you wish to update ${PN} manually simply run:"
		elog
		elog "ESVN_REVISION=<rev> emerge =${PF}"
		elog
		elog "where <rev> is either HEAD (in case you wish to get all updates)"
		elog "or specific revision number. But NOTE, this update will vanish"
		elog "next time you reemerge ${PN}. To make update permanent either"
		elog "create ebuild with specific revision number inside your overlay"
		elog "or report revision bump bug at http://bugs.gentoo.org ."
		elog
		elog "In case you use portage it's also possible to create"
		elog "/etc/portage/env/${CATEGORY}/${PN} file with ESVN_REVISION=<rev>"
		elog "content. Then each time you run emerge ${PN} you'll have said"
		elog "<rev> installed. For example, if you run"
		elog " # mkdir -p /etc/portage/env/${CATEGORY}"
		elog " # echo ESVN_REVISION=HEAD >> /etc/portage/env/${CATEGORY}/${PN}"
		elog "each time you reemerge ${PN} it'll be updated to get all possible"
		elog "updates for framework-${PV%_p*} branch."
		elog "You can do similar things in paludis using /etc/paludis/bashrc."
	else
		ewarn "${PN} version you installed is for testing purposes only"
		ewarn "as it's impossible to update it. For day by day work use"
		ewarn "different version."
	fi
}
