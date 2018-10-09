# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils flag-o-matic toolchain-funcs multilib multilib-minimal
# git-r3

DESCRIPTION="Snapshot for testssl.sh >2.8 from PM's fork, ready to compile"
HOMEPAGE="https://github.com/drwetter/openssl-1.0.2.bad"
#EGIT_REPO_URI="https://github.com/drwetter/openssl.git"
#https://github.com/drwetter/openssl-1.0.2.bad.git
#EGIT_BRANCH="1.0.2-chacha"
#EGIT_COMMIT="07c3c3b51a290337bf56605c6604c00d4a174a15"

MY_COMMIT="07c3c3b51a290337bf56605c6604c00d4a174a15"
SRC_URI="https://github.com/drwetter/openssl-1.0.2.bad/archive/${MY_COMMIT}.zip -> ${P}.zip"

LICENSE="openssl"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~arm-linux ~x86-linux"
IUSE="+asm bindist gmp kerberos rfc3779 sctp cpu_flags_x86_sse2 +sslv2 +sslv3 +static-libs test +tls-heartbeat vanilla zlib"
RESTRICT="!bindist? ( bindist )"

RDEPEND=">=app-misc/c_rehash-1.7-r1
	gmp? ( >=dev-libs/gmp-5.1.3-r1[static-libs(+)?,${MULTILIB_USEDEP}] )
	zlib? ( >=sys-libs/zlib-1.2.8-r1[static-libs(+)?,${MULTILIB_USEDEP}] )
	kerberos? ( >=app-crypt/mit-krb5-1.11.4[${MULTILIB_USEDEP}] )"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	sctp? ( >=net-misc/lksctp-tools-1.0.12 )
	test? (
		sys-apps/diffutils
		sys-devel/bc
	)"
PDEPEND="app-misc/ca-certificates"

S="${WORKDIR}/openssl-1.0.2.bad-${MY_COMMIT}"

MULTILIB_WRAPPED_HEADERS=(
	usr/include/openssl/opensslconf.h
)

src_prepare() {
	# keep this in sync with app-misc/c_rehash
	SSL_CNF_DIR="/etc/ssl"

	# Make sure we only ever touch Makefile.org and avoid patching a file
	# that gets blown away anyways by the Configure script in src_configure
	rm -f Makefile

	if ! use vanilla ; then
		epatch "${FILESDIR}"/openssl-1.0.0a-ldflags.patch #327421
#		epatch "${FILESDIR}"/openssl-1.0.2i-parallel-build.patch
		epatch "${FILESDIR}"/openssl-1.0.2a-parallel-obj-headers.patch
		epatch "${FILESDIR}"/openssl-1.0.2a-parallel-install-dirs.patch
		epatch "${FILESDIR}"/openssl-1.0.2a-parallel-symlinking.patch #545028
#		epatch "${FILESDIR}"/openssl-1.0.2-ipv6.patch
		epatch "${FILESDIR}"/openssl-1.0.2a-x32-asm.patch #542618
		epatch "${FILESDIR}"/openssl-1.0.1p-default-source.patch #554338
	fi

	eapply_user

	# disable fips in the build
	# make sure the man pages are suffixed #302165
	# don't bother building man pages if they're disabled
	sed -i \
		-e '/DIRS/s: fips : :g' \
		-e '/^MANSUFFIX/s:=.*:=ssl:' \
		-e '/^MAKEDEPPROG/s:=.*:=$(CC):' \
		-e $(has noman FEATURES \
			&& echo '/^install:/s:install_docs::' \
			|| echo '/^MANDIR=/s:=.*:='${EPREFIX%/}'/usr/share/man:') \
		Makefile.org \
		|| die
	# show the actual commands in the log
	sed -i '/^SET_X/s:=.*:=set -x:' Makefile.shared

	# since we're forcing $(CC) as makedep anyway, just fix
	# the conditional as always-on
	# helps clang (#417795), and versioned gcc (#499818)
	# this breaks build with 1.0.2p, not sure if it is needed anymore
	#sed -i 's/expr.*MAKEDEPEND.*;/true;/' util/domd || die

	# quiet out unknown driver argument warnings since openssl
	# doesn't have well-split CFLAGS and we're making it even worse
	# and 'make depend' uses -Werror for added fun (#417795 again)
	[[ ${CC} == *clang* ]] && append-flags -Qunused-arguments

	# allow openssl to be cross-compiled
	cp "${FILESDIR}"/gentoo.config-1.0.2 gentoo.config || die
	chmod a+rx gentoo.config || die

	append-flags -fno-strict-aliasing
	append-flags $(test-flags-CC -Wa,--noexecstack)
	append-cppflags -DOPENSSL_NO_BUF_FREELISTS

	sed -i '1s,^:$,#!'${EPREFIX%/}'/usr/bin/perl,' Configure #141906
	# The config script does stupid stuff to prompt the user.  Kill it.
	sed -i '/stty -icanon min 0 time 50; read waste/d' config || die
	./config --test-sanity || die "I AM NOT SANE"

	multilib_copy_sources
}

multilib_src_configure() {
	unset APPS #197996
	unset SCRIPTS #312551
	unset CROSS_COMPILE #311473

	tc-export CC AR RANLIB RC

	# Clean out patent-or-otherwise-encumbered code
	# Camellia: Royalty Free            https://en.wikipedia.org/wiki/Camellia_(cipher)
	# IDEA:     Expired                 https://en.wikipedia.org/wiki/International_Data_Encryption_Algorithm
	# EC:       ????????? ??/??/2015    https://en.wikipedia.org/wiki/Elliptic_Curve_Cryptography
	# MDC2:     Expired                 https://en.wikipedia.org/wiki/MDC-2
	# RC5:      Expired                 https://en.wikipedia.org/wiki/RC5

	use_ssl() { usex $1 "enable-${2:-$1}" "no-${2:-$1}" " ${*:3}" ; }
	echoit() { echo "$@" ; "$@" ; }

	local krb5=$(has_version app-crypt/mit-krb5 && echo "MIT" || echo "Heimdal")

	# See if our toolchain supports __uint128_t.  If so, it's 64bit
	# friendly and can use the nicely optimized code paths. #460790
	local ec_nistp_64_gcc_128
	# Disable it for now though #469976
	#if ! use bindist ; then
	#	echo "__uint128_t i;" > "${T}"/128.c
	#	if ${CC} ${CFLAGS} -c "${T}"/128.c -o /dev/null >&/dev/null ; then
	#		ec_nistp_64_gcc_128="enable-ec_nistp_64_gcc_128"
	#	fi
	#fi

	# https://github.com/openssl/openssl/issues/2286
#	if use ia64 ; then
#		replace-flags -g3 -g2
#		replace-flags -ggdb3 -ggdb2
#	fi

	local sslout=$(./gentoo.config)
	einfo "Use configuration ${sslout:-(openssl knows best)}"
	local config="Configure"
	[[ -z ${sslout} ]] && config="config"

	STDOPTIONS="--prefix=/usr/ --openssldir=/etc/ssl -DOPENSSL_USE_BUILD_DATE enable-zlib \
	enable-ssl2 enable-ssl3 enable-ssl-trace enable-rc5 enable-rc2 \
	enable-gost enable-cms enable-md2 enable-mdc2 enable-ec enable-ec2m enable-ecdh enable-ecdsa \
	enable-seed enable-camellia enable-idea enable-rfc3779 experimental-jpake"

	# Fedora hobbled-EC needs 'no-ec2m', 'no-srp'
	echoit \
	./${config} \
		${sslout} \
		$(use cpu_flags_x86_sse2 || echo "no-sse2") \
		enable-camellia \
		enable-ec \
		$(use_ssl !bindist ec2m) \
		$(use_ssl !bindist srp) \
		${ec_nistp_64_gcc_128} \
		enable-idea \
		enable-mdc2 \
		enable-rc5 \
		enable-tlsext \
		enable-cast \
		enable-ripemd \
		$(use_ssl asm) \
		$(use_ssl gmp gmp -lgmp) \
		$(use_ssl kerberos krb5 --with-krb5-flavor=${krb5}) \
		$(use_ssl rfc3779) \
		$(use_ssl sctp) \
		$(use_ssl sslv2 ssl2) \
		$(use_ssl sslv3 ssl3) \
		$(use_ssl tls-heartbeat heartbeats) \
		$(use_ssl zlib) \
		--prefix="${EPREFIX%/}"/usr \
		--openssldir="${EPREFIX%/}"${SSL_CNF_DIR} \
		--libdir=$(get_libdir) \
		-static threads $STDOPTIONS  \
		|| die

	# Clean out hardcoded flags that openssl uses
	local CFLAG=$(grep ^CFLAG= Makefile | LC_ALL=C sed \
		-e 's:^CFLAG=::' \
		-e 's:-fomit-frame-pointer ::g' \
		-e 's:-O[0-9] ::g' \
		-e 's:-march=[-a-z0-9]* ::g' \
		-e 's:-mcpu=[-a-z0-9]* ::g' \
		-e 's:-m[a-z0-9]* ::g' \
	)
	sed -i \
		-e "/^CFLAG/s|=.*|=${CFLAG} ${CFLAGS}|" \
		-e "/^SHARED_LDFLAGS=/s|$| ${LDFLAGS}|" \
		Makefile || die

	einfo "config is completed ==========="
	emake -j1 depend
}

multilib_src_compile() {
	# depend is needed to use $confopts; it also doesn't matter
	# that it's -j1 as the code itself serializes subdirs
	emake -j1 V=1 depend
	emake all
	# rehash is needed to prep the certs/ dir; do this
	# separately to avoid parallel build issues.
	#emake rehash
}

multilib_src_test() {
	emake -j1 test
}

multilib_src_install() {
	newbin apps/openssl openssl-bad
}

