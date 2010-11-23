# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/wireshark/wireshark-1.4.0_rc2.ebuild,v 1.1 2010/07/30 10:27:15 pva Exp $

EAPI=2
PYTHON_DEPEND="python? 2"
inherit libtool flag-o-matic eutils toolchain-funcs python

[[ -n ${PV#*_rc} && ${PV#*_rc} != ${PV} ]] && MY_P=${PN}-${PV/_} || MY_P=${P}
DESCRIPTION="A network protocol analyzer formerly known as ethereal"
HOMEPAGE="http://www.wireshark.org/"
SRC_URI="http://www.wireshark.org/download/src/all-versions/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="adns ares doc doc-pdf gtk ipv6 lua gcrypt geoip kerberos
profile +pcap pcre portaudio python +caps selinux smi ssl threads zlib"

RDEPEND=">=dev-libs/glib-2.14.0:2
	zlib? ( sys-libs/zlib
		!=sys-libs/zlib-1.2.4 )
	smi? ( net-libs/libsmi )
	x11-misc/xdg-utils
	gtk? ( >=x11-libs/gtk+-2.4.0:2
		x11-libs/pango
		dev-libs/atk )
	ssl? ( net-libs/gnutls )
	gcrypt? ( dev-libs/libgcrypt )
	pcap? ( net-libs/libpcap )
	pcre? ( dev-libs/libpcre )
	caps? ( sys-libs/libcap )
	kerberos? ( virtual/krb5 )
	portaudio? ( media-libs/portaudio )
	ares? ( >=net-dns/c-ares-1.5 )
	!ares? ( adns? ( net-libs/adns ) )
	geoip? ( dev-libs/geoip )
	lua? ( >=dev-lang/lua-5.1 )
	selinux? ( sec-policy/selinux-wireshark )"

DEPEND="${RDEPEND}
	doc? ( dev-libs/libxslt
		dev-libs/libxml2
		www-client/elinks
		app-doc/doxygen
		doc-pdf? ( dev-java/fop ) )
	>=dev-util/pkgconfig-0.15.0
	dev-lang/perl
	sys-devel/bison
	sys-apps/sed
	sys-devel/flex"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	if ! use gtk; then
		ewarn "USE=-gtk disables gtk-based gui called wireshark."
		ewarn "Only command line utils will be built available"
	fi
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
	# Add group for users allowed to sniff.
	enewgroup wireshark
}

src_prepare() {
	cd "${S}"/epan # old hardened toolchain bug...
	epatch "${FILESDIR}/wireshark-except-double-free.diff"
}

src_configure() {
	local myconf

	# optimization bug, see bug #165340, bug #40660
	if [[ $(gcc-version) == 3.4 ]] ; then
		elog "Found gcc 3.4, forcing -O3 into CFLAGS"
		replace-flags -O? -O3
		# see bug #133092; bugs.wireshark.org/bugzilla/show_bug.cgi?id=1001
		# our old hardened toolchain bug
		filter-flags -fstack-protector
	elif [[ $(gcc-version) == 3.3 || $(gcc-version) == 3.2 ]] ; then
		elog "Found <=gcc-3.3, forcing -O into CFLAGS"
		replace-flags -O? -O
	fi

	if use ares && use adns; then
		elog "You asked for both, ares and adns, but we can use only one of them."
		elog "c-ares supersedes adns resolver thus using c-ares (ares USE flag)."
		myconf="$(use_with ares c-ares) --without-adns"
	else
		myconf="$(use_with adns) $(use_with ares c-ares)"
	fi

	# profile and pie are incompatible #215806, #292991
	if use profile; then
		ewarn "You've enabled the 'profile' USE flag, building PIE binaries is disabled."
		append-flags $(test-flags-CC -nopie)
	fi

	# Workaround bug #213705. If krb5-config --libs has -lcrypto then pass
	# --with-ssl to ./configure. (Mimics code from acinclude.m4).
	if use kerberos; then
		case `krb5-config --libs` in
			*-lcrypto*)
				ewarn "Kerberos was built with ssl support: linkage with openssl is enabled."
				ewarn "Note there are annoying license incompatibilities between the OpenSSL"
				ewarn "license and the GPL, so do your check before distributing such package."
				myconf+=" --with-ssl"
				;;
		esac
	fi

	# Hack around inability to disable doxygen/fop doc generation
	use doc || export ac_cv_prog_HAVE_DOXYGEN=false
	use doc-pdf || export ac_cv_prog_HAVE_FOP=false

	# dumpcap requires libcap, setuid-install requires dumpcap
	econf $(use_enable gtk wireshark) \
		$(use_enable profile profile-build) \
		$(use_with ssl gnutls) \
		$(use_with gcrypt) \
		$(use_enable ipv6) \
		$(use_enable threads) \
		$(use_with lua) \
		$(use_with kerberos krb5) \
		$(use_with smi libsmi) \
		$(use_with pcap) \
		$(use_with zlib) \
		$(use_with pcre) \
		$(use_with geoip) \
		$(use_with portaudio) \
		$(use_with python) \
		$(use_with caps libcap) \
		$(use_enable caps setcap-install) \
		$(use caps || use_enable pcap setuid-install) \
		--sysconfdir=/etc/wireshark \
		--with-dumpcap-group=wireshark \
		--disable-extra-gcc-checks \
		${myconf}
}

src_compile() {
	emake || die
	use doc && cd docbook && { emake || die; }
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	if use doc; then
		dohtml -r docbook/{release-notes.html,ws{d,u}g_html{,_chunked}}
#		for dir in ws{d,u}g_html{,_chunked}; do
#			dohtml -p ${dir} -r docbook/${dir}/ || die
#		done
		if use doc-pdf; then
			insinto /usr/share/doc/${PF}/pdf/
			doins docbook/{{developer,user}-guide,release-notes}-{a4,us}.pdf || die
		fi
	fi

	# FAQ is not required as is installed from help/faq.txt
	dodoc AUTHORS ChangeLog NEWS README{,.bsd,.linux,.macos,.vmware} \
		doc/{randpkt.txt,README*}

	insinto /usr/include/wiretap
	doins wiretap/wtap.h || die

	use caps && local perms=550 || local perms=6550
	use pcap && fperms ${perms} /usr/bin/dumpcap

	if use gtk; then
		for c in hi lo; do
			for d in 16 32 48; do
				insinto /usr/share/icons/${c}color/${d}x${d}/apps
				newins image/${c}${d}-app-wireshark.png wireshark.png
			done
		done
		insinto /usr/share/applications
		doins wireshark.desktop || die
	fi
}

pkg_postinst() {
	use caps && setcap cap_net_raw,cap_net_admin+eip "${ROOT}"/usr/bin/dumpcap
	echo
	ewarn "NOTE: To run wireshark as normal user you have to add yourself into"
	ewarn "wireshark group. This security measure ensures that only trusted"
	ewarn "users allowed to sniff your traffic."
	echo
}
