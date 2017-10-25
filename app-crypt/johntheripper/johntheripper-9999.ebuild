# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic toolchain-funcs pax-utils

DESCRIPTION="fast password cracker"
HOMEPAGE="http://www.openwall.com/john/"

MY_PN="JohnTheRipper"
MY_P="${MY_PN}-${PV}"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/magnumripper/${MY_PN}.git"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="https://github.com/magnumripper/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="commoncrypto -cuda custom-cflags kerberos -minimal mpi opencl openmp +openssl pcap rexgen"
REQUIRED_USE="!minimal ^^ ( openssl commoncrypto ) !commoncrypto !cuda !rexgen"

DEPEND="openssl? ( >=dev-libs/openssl-1.0.1:0 )
	mpi? ( virtual/mpi )
	opencl? ( virtual/opencl )
	kerberos? ( virtual/krb5 )
	pcap? ( net-libs/libpcap )
	dev-libs/gmp:*
	sys-libs/zlib
	app-arch/bzip2"

RDEPEND="${DEPEND}"

pkg_setup() {
	if use openmp && [[ ${MERGE_TYPE} != binary ]]; then
		tc-has-openmp || die "Please switch to an openmp compatible compiler"
	fi
}

src_configure() {
	cd src

	use custom-cflags || strip-flags
	append-cppflags -DJOHN_SYSTEMWIDE_HOME="'\"${EPREFIX}/etc/john\"'"

	econf \
		--disable-native-march \
		--disable-native-tests \
		--with-systemwide \
		$(use_enable mpi) \
		$(use_enable opencl) \
		$(use_enable openmp) \
		$(use_enable pcap) \
		$(use_enable rexgen) \
		$(use_with commoncrypto) \
		$(use_with openssl)
}

src_compile() {
	emake -C src
}

src_test() {
	pax-mark -mr run/john
	make -C src check
}

src_install() {
	# executables
	dosbin run/john
	newsbin run/mailer john-mailer

	pax-mark -mr "${ED}usr/sbin/john"

	# grep '$(LN)' Makefile.in | head -n-3 | tail -n+2 | cut -d' ' -f3 | cut -d/ -f3
	for s in \
		unshadow unafs undrop unique ssh2john putty2john pfx2john keepass2john keyring2john \
		zip2john gpg2john rar2john racf2john keychain2john kwallet2john pwsafe2john dmg2john \
		hccap2john base64conv truecrypt_volume2john keystore2john
	do
		dosym john /usr/sbin/$s
	done

	insinto /usr/share/john
	doins run/*.py

	if use opencl; then
		insinto /usr/share/john/kernels
		doins run/kernels/*
	fi

	# config files
	insinto /etc/john
	doins run/*.chr run/password.lst
	doins run/*.conf

	# documentation
	dodoc doc/*
}
