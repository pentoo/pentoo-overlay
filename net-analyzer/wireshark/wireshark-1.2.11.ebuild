# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/wireshark/wireshark-1.2.10.ebuild,v 1.7 2010/08/10 17:36:58 ranger Exp $

EAPI=2
inherit autotools libtool flag-o-matic eutils toolchain-funcs

DESCRIPTION="A network protocol analyzer formerly known as ethereal"
HOMEPAGE="http://www.wireshark.org/"

# _rc versions has different download location.
[[ -n ${PV#*_rc} && ${PV#*_rc} != ${PV} ]] && {
SRC_URI="http://www.wireshark.org/download/prerelease/${PN}-${PV/_rc/pre}.tar.gz";
S=${WORKDIR}/${PN}-${PV/_rc/pre} ; } || \
SRC_URI="http://www.wireshark.org/download/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="adns ares gtk ipv6 lua portaudio gnutls gcrypt geoip zlib kerberos threads profile smi +pcap pcre +caps selinux"

RDEPEND=">=dev-libs/glib-2.4.0:2
	zlib? ( sys-libs/zlib
		!=sys-libs/zlib-1.2.4 )
	smi? ( net-libs/libsmi )
	gtk? ( >=x11-libs/gtk+-2.4.0:2
		x11-libs/pango
		dev-libs/atk )
	gnutls? ( net-libs/gnutls )
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
	>=dev-util/pkgconfig-0.15.0
	dev-lang/perl
	sys-devel/bison
	sys-devel/flex"

pkg_setup() {
	if ! use gtk; then
		ewarn "USE=-gtk will means no gui called wireshark will be created and"
		ewarn "only command line utils are available"
	fi

	# Add group for users allowed to sniff.
	enewgroup wireshark
}

src_prepare() {
	cd "${S}"/epan # our hardened toolchain bug...
	epatch "${FILESDIR}/wireshark-except-double-free.diff"

	cd "${S}"
	epatch "${FILESDIR}/${PN}-1.1.2--as-needed.patch"
	eautoreconf
}

src_configure() {
	local myconf

	# optimization bug, see bug #165340, bug #40660
	if [[ $(gcc-version) == 3.4 ]] ; then
		elog "Found gcc 3.4, forcing -O3 into CFLAGS"
		replace-flags -O? -O3
	elif [[ $(gcc-version) == 3.3 || $(gcc-version) == 3.2 ]] ; then
		elog "Found <=gcc-3.3, forcing -O into CFLAGS"
		replace-flags -O? -O
	fi

	if use ares && use adns; then
		einfo "You asked for both, ares and adns, but we can use only one of them."
		einfo "c-ares supersedes adns resolver thus using c-ares (ares USE flag)."
		myconf="$(use_with ares c-ares) --without-adns"
	else
		myconf="$(use_with adns) $(use_with ares c-ares)"
	fi

	# see bug #133092; bugs.wireshark.org/bugzilla/show_bug.cgi?id=1001
	# our hardened toolchain bug
	filter-flags -fstack-protector

	# profile and pie are incompatible #215806, #292991
	if use profile; then
		ewarn "You've enabled the 'profile' USE flag, building PIE binaries is disabled."
		append-flags $(test-flags-CC -nopie)
	fi

	# Workaround bug #213705. If krb5-config --libs has -lcrypto then pass
	# --with-ssl to ./configure. (Mimics code from acinclude.m4).
	if use kerberos; then
		case `krb5-config --libs` in
			*-lcrypto*) myconf="${myconf} --with-ssl" ;;
		esac
	fi

	# dumpcap requires libcap, setuid-install requires dumpcap
	econf $(use_enable gtk wireshark) \
		$(use_enable profile profile-build) \
		$(use_with gnutls) \
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
		$(use_with caps libcap) \
		$(use_enable pcap setuid-install) \
		--sysconfdir=/etc/wireshark \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	use pcap && fowners 0:wireshark /usr/bin/dumpcap
	use pcap && fperms 6550 /usr/bin/dumpcap

	insinto /usr/include/wiretap
	doins wiretap/wtap.h

	# FAQ is not required as is installed from help/faq.txt
	dodoc AUTHORS ChangeLog NEWS README{,.bsd,.linux,.macos,.vmware} doc/randpkt.txt

	if use gtk; then
		for c in hi lo; do
			for d in 16 32 48; do
				insinto /usr/share/icons/${c}color/${d}x${d}/apps
				newins image/${c}${d}-app-wireshark.png wireshark.png
			done
		done
		insinto /usr/share/applications
		doins wireshark.desktop
	fi
}

pkg_postinst() {
	echo
	ewarn "NOTE: To run wireshark as normal user you have to add yourself into"
	ewarn "wireshark group. This security measure ensures that only trusted"
	ewarn "users allowed to sniff your traffic."
	echo
}
