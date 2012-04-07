# Copyright 1998-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/metasploit/metasploit-3.1_p5699-r1.ebuild,v 1.3 2008/11/09 14:52:13 nixnut Exp $

EAPI="4"
inherit eutils subversion

MY_P=${PN/metasploit/framework}-${PV}

MTSLPT_REV=${BASH_REMATCH[2]}
ESVN_REPO_URI="https://metasploit.com/svn/framework3/trunk"

SRC_URI="https://dev.metasploit.com/redmine/attachments/download/906/vbsmem-1.2.1.patch
	https://dev.metasploit.com/redmine/attachments/1200/jboss_seam_remote_command_rb"

DESCRIPTION="Advanced open-source framework for developing, testing, and using vulnerability exploit code"
HOMEPAGE="http://www.metasploit.org/"
SLOT="9999"
LICENSE="BSD"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="+armitage +kissfft unstable lorcon lorcon2 +pcaprub +postgres serialport"

REQUIRED_USE="armitage? ( postgres )"

# Note we use bundled gems (see data/msfweb/vendor/rails/) as upstream voted for
# such solution, bug #247787
RDEPEND="dev-lang/ruby
	dev-ruby/rubygems
	>=app-crypt/johntheripper-1.7.9-r1[-minimal]
	!arm? ( dev-ruby/hpricot
		virtual/jdk
		dev-ruby/rjb
		dev-ruby/msgpack )
	postgres? ( dev-db/postgresql-server
		!arm? ( dev-ruby/pg
		dev-ruby/activerecord[postgres] ) )
	pcaprub? ( net-libs/libpcap )
	armitage? ( net-analyzer/nmap )
	lorcon? ( net-wireless/lorcon-old )
	lorcon2? ( net-wireless/lorcon )"
DEPEND=""

RESTRICT="strip"

QA_EXECSTACK="
	usr/$(get_libdir)/${PN}${SLOT}/data/meterpreter/msflinker_linux_x86.bin"
QA_WX_LOAD="
	usr/$(get_libdir)/${PN}${SLOT}/data/templates/template_*_linux.bin"

S=${WORKDIR}/${MY_P}

src_compile() {
	if use pcaprub; then
		cd "${S}"/external/pcaprub
		ruby extconf.rb
		emake
	fi
	if use kissfft; then
		cd "${S}"/external/ruby-kissfft
		ruby extconf.rb
		emake
	fi
	if use lorcon; then
		cd "${S}"/external/ruby-lorcon
		ruby extconf.rb
		emake
	fi
	if use lorcon2; then
		cd "${S}"/external/ruby-lorcon2
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
	rm -Rf "${ED}"/usr/$(get_libdir)/${PN}${SLOT}/documentation "${ED}"/usr/$(get_libdir)/${PN}${SLOT}/README || die
	fowners -R root:0 /

	# do not remove LICENSE, bug #238137
	dodir /usr/share/doc/${PF}
	cp -R "${S}"/{documentation,README} "${ED}"/usr/share/doc/${PF} || die
	dosym /usr/share/doc/${PF}/documentation /usr/$(get_libdir)/${PN}${SLOT}/documentation


	dodir /usr/bin/
	for file in msf*; do
		dosym /usr/$(get_libdir)/${PN}${SLOT}/${file} /usr/bin/${file}
	done

	newinitd "${FILESDIR}"/msfrpcd.initd msfrpcd${SLOT}
	newconfd "${FILESDIR}"/msfrpcd.confd msfrpcd${SLOT}

	# Avoid useless revdep-rebuild trigger #377617
	dodir /etc/revdep-rebuild/
	echo "SEARCH_DIRS_MASK=\"/usr/lib*/${PN}${SLOT}/data/john\"" > \
		"${ED}"/etc/revdep-rebuild/70-${PN}${SLOT}

	if use armitage; then
		echo -e "#!/bin/sh \n\nexport MSF_DATABASE_CONFIG=/usr/$(get_libdir)/${PN}{SLOT}/armitage.yml\n" > armitage
		echo -e "java -Xmx256m -jar /usr/$(get_libdir)/${PN}${SLOT}/data/armitage/armitage.jar \$* &\n" >> armitage
		dobin armitage
		insinto /usr/$(get_libdir)/${PN}${SLOT}/
		doins  "${FILESDIR}"/armitage.yml
	fi

	#Add new modules from metasploit bug report system not in the main tree yet
	if use unstable; then

	#smart hasdump from http://www.darkoperator.com/blog/2011/5/19/metasploit-post-module-smart_hashdump.html
	#https://github.com/darkoperator/Meterpreter-Scripts
	cp "${FILESDIR}"/smart_hasdump_script_6ac6c1d.rb "${ED}"/usr/$(get_libdir)/${PN}${SLOT}/scripts/meterpreter/smart_hasdump.rb || die "Copy files failed"
	cp "${FILESDIR}"/hashdump2_script_6ac6c1d.rb "${ED}"/usr/$(get_libdir)/${PN}${SLOT}/scripts/meterpreter/hashdump2.rb || die "Copy files failed"

	#Slow HTTP POST Denial Of Service
	#https://dev.metasploit.com/redmine/issues/3638

	#EAP-MD5 offline dictionary attack
	#https://dev.metasploit.com/redmine/issues/4439

	#JBoss remote command execution exploit
	#https://dev.metasploit.com/redmine/issues/4585
	cp "${DISTDIR}"/jboss_seam_remote_command_rb "${ED}"/usr/$(get_libdir)/${PN}${SLOT}/modules/exploits/multi/http/jboss_seam_remote_command.rb || die "Copy files failed"

	fi
	#fi unstable

	if use pcaprub; then
		cd "${S}"/external/pcaprub
		emake DESTDIR="${ED}" install
	fi
	if use lorcon; then
		cd "${S}"/external/ruby-lorcon
		emake DESTDIR="${ED}" install
	fi
	if use lorcon2; then
		cd "${S}"/external/ruby-lorcon2
		emake DESTDIR="${ED}" install
	fi
	if use kissfft; then
		cd "${S}"/external/ruby-kissfft
		emake DESTDIR="${ED}" install
	fi
	if use serialport; then
		cd "${S}"/external/serialport
		emake DESTDIR="${ED}" install
	fi

	#unbundle johntheripper, it makes me sick to have to do this...
	rm -rf "${ED}"/usr/$(get_libdir)/${PN}${SLOT}/data/john/run.*
	dodir /usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.any
	for i in $(ls -1 ${ROOT}/etc/john)
	do
		dosym /etc/john/${i} /usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.any/${i}
	done
	dosym /usr/sbin/unique /usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.any/unique
	dosym /usr/sbin/john /usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.any/john
	dosym /usr/sbin/unafs /usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.any/unafs
	dosym /usr/sbin/genmkvpwd /usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.any/genmkvpwd
	dosym /usr/sbin/john-mailer /usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.any/john-mailer
	dosym /usr/sbin/undrop /usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.any/undrop
	dosym /usr/sbin/unshadow /usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.any/unshadow
	dosym /usr/sbin/tgtsnarf /usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.any/tgtsnarf
	dosym /usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.any /usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x64.mmx
	dosym /usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.any /usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.mmx
	dosym /usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.any /usr/$(get_libdir)/${PN}${SLOT}/data/john/run.linux.x86.sse2
}
pkg_postinst() {
	if use postgres; then
		elog "You need to prepare the database as described on the following page:"
		use postgres && elog "https://community.rapid7.com/docs/DOC-1268"
		elog
	fi

	elog "If you wish to update ${PN}${SLOT} manually simply run:"
	elog
	elog "ESVN_REVISION=<rev> emerge =${PF}"
	elog
	elog "where <rev> is either HEAD (in case you wish to get all updates)"
	elog "or specific revision number. But NOTE, this update will vanish"
	elog "next time you reemerge ${PN}${SLOT}. To make update permanent either"
	elog "create ebuild with specific revision number inside your overlay"
	elog "or report revision bump bug at http://bugs.gentoo.org ."
	elog
	elog "In case you use portage it's also possible to create"
	elog "/etc/portage/env/${CATEGORY}/${PN}${SLOT} file with ESVN_REVISION=<rev>"
	elog "content. Then each time you run emerge ${PN}${SLOT} you'll have said"
	elog "<rev> installed. For example, if you run"
	elog " # mkdir -p /etc/portage/env/${CATEGORY}"
	elog " # echo ESVN_REVISION=HEAD >> /etc/portage/env/${CATEGORY}/${PN}${SLOT}"
	elog "each time you reemerge ${PN}${SLOT} it'll be updated to get all possible"
	elog "updates for framework-${PV%_p*} branch."
	elog "You can do similar things in paludis using /etc/paludis/bashrc."
	elog
	elog "Adjust /usr/$(get_libdir)/${PN}{SLOT}/armitage.yml and /etc/conf.d/msfrpcd${PV} files if necessary"
}
