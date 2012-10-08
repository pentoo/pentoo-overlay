# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/net-snmp/net-snmp-5.7.2_rc1.ebuild,v 1.11 2012/10/05 17:04:55 ranger Exp $

EAPI=4
PYTHON_DEPEND="python? 2"

WANT_AUTOMAKE=none

inherit eutils perl-module python autotools

MY_P="${P/_rc/.rc}"

DESCRIPTION="Software for generating and retrieving SNMP data"
HOMEPAGE="http://net-snmp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
#	http://dev.gentoo.org/~flameeyes/${PN}/net-snmp-5.7.2.rc1-patches-3.tar.xz"

# GPL-2 for the init scripts
LICENSE="as-is BSD GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE="bzip2 doc elf ipv6 mfd-rewrites minimal perl python rpm selinux ssl tcpd X zlib lm_sensors ucd-compat"

COMMON="ssl? ( >=dev-libs/openssl-0.9.6d )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	rpm? (
		app-arch/rpm
		dev-libs/popt
	)
	bzip2? ( app-arch/bzip2 )
	zlib? ( >=sys-libs/zlib-1.1.4 )
	elf? ( dev-libs/elfutils )
	python? ( dev-python/setuptools )
	sys-apps/pciutils
	lm_sensors? ( sys-apps/lm_sensors )"

RDEPEND="${COMMON}
	perl? (
		X? ( dev-perl/perl-tk )
		!minimal? ( dev-perl/TermReadKey )
	)
	selinux? ( sec-policy/selinux-snmp )
	sys-apps/openrc"

# Dependency on autoconf due to bug #225893
DEPEND="${COMMON}
	>=sys-apps/sed-4
	doc? ( app-doc/doxygen )"

REQUIRED_USE="rpm? ( bzip2 zlib )"

RESTRICT=test

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	# snmpconf generates config files with proper selinux context
	use selinux && epatch "${FILESDIR}"/${PN}-5.1.2-snmpconf-selinux.patch

	epatch "${FILESDIR}"/000*.patch
	eautoconf
}

src_configure() {
	# keep this in the same line, configure.ac arguments are passed down to config.h
	local mibs="host ucd-snmp/dlmod ucd-snmp/diskio ucd-snmp/extensible mibII/mta_sendmail smux"
	use lm_sensors && mibs="${mibs} ucd-snmp/lmsensorsMib"

	use python && export PYTHON_DIR="$(python_get_sitedir)"

	econf \
		--with-install-prefix="${D}" \
		--with-sys-location="Unknown" \
		--with-sys-contact="root@Unknown" \
		--with-default-snmp-version="3" \
		--with-mib-modules="${mibs}" \
		--with-logfile="/var/log/net-snmpd.log" \
		--with-persistent-directory="/var/lib/net-snmp" \
		$(use_enable ucd-compat ucd-snmp-compatibility) \
		--enable-shared --disable-static \
		--with-ldflags="${LDFLAGS}" \
		$(use_enable ipv6) \
		$(use_enable mfd-rewrites) \
		$(use_enable perl embedded-perl) \
		$(use_enable !ssl internal-md5) \
		$(use_with elf) \
		$(use_with perl perl-modules INSTALLDIRS=vendor) \
		$(use_with python python-modules) \
		$(use_with ssl openssl) \
		$(use_with tcpd libwrap) \
		$(use_with bzip2) \
		$(use_with zlib) \
		$(use_with rpm) \
		--without-nl \
		--with-pci
}

src_compile() {
	emake OTHERLDFLAGS="${LDFLAGS}"

	if use doc ; then
		einfo "Building HTML Documentation"
		emake docsdox
	fi
}

src_install () {
	# bug #317965
	emake -j1 DESTDIR="${D}" install

	if use perl ; then
		fixlocalpod
		use X || rm -f "${D}"/usr/bin/tkmib
	else
		rm -f "${D}"/usr/bin/mib2c "${D}"/usr/bin/snmpcheck "${D}"/usr/bin/tkmib
	fi

	dodoc AGENT.txt ChangeLog FAQ INSTALL NEWS PORTING README* TODO
	newdoc EXAMPLE.conf.def EXAMPLE.conf

	use doc && dohtml docs/html/*

	keepdir /var/lib/net-snmp

	newinitd "${FILESDIR}"/snmpd.init.2 snmpd
	newconfd "${FILESDIR}"/snmpd.conf snmpd

	newinitd "${FILESDIR}"/snmptrapd.init.2 snmptrapd
	newconfd "${FILESDIR}"/snmptrapd.conf snmptrapd

	insinto /etc/snmp
	newins "${S}"/EXAMPLE.conf snmpd.conf.example

	# Remove everything not required for an agent.
	# Keep only the snmpd, snmptrapd, MIBs, headers and libraries.
	if use minimal; then
		rm -rf \
			"${D}"/usr/bin/{encode_keychange,snmp{get,getnext,set,usm,walk,bulkwalk,table,trap,bulkget,translate,status,delta,test,df,vacm,netstat,inform,check,conf},fixproc,traptoemail} \
			"${D}"/usr/share/snmp/snmpconf-data \
			"${D}"/usr/share/snmp/*.conf \
			"${D}"/**/*.pl
	fi
}

pkg_postinst() {
	if use python; then
		python_mod_optimize netsnmp
	fi

	elog "An example configuration file has been installed in"
	elog "/etc/snmp/snmpd.conf.example."
}

pkg_postrm() {
	if use python; then
		python_mod_cleanup netsnmp
	fi
}
