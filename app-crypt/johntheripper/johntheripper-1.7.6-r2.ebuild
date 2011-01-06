# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/johntheripper/johntheripper-1.7.6-r1.ebuild,v 1.1 2010/12/03 19:02:34 c1pher Exp $

EAPI="2"

inherit eutils flag-o-matic toolchain-funcs pax-utils

MY_PN="john"
MY_P="${MY_PN}-${PV}"

JUMBO="jumbo-9"
MPI="mpi8"
OMPV="des-7"

DESCRIPTION="fast password cracker"
HOMEPAGE="http://www.openwall.com/john/"

SRC_URI="http://www.openwall.com/john/g/${MY_P}.tar.gz
	!minimal? ( http://www.openwall.com/john/contrib/${MY_P}-${JUMBO}.diff.gz )
	mpi? ( http://openwall.info/wiki/_media/john/${MY_P}-full${MPI}-after-jumbo3.diff.gz )
	mscache2? (	http://openwall.info/wiki/_media/john/${MY_P}-${JUMBO}-mscash2-1.diff.gz )
	openmp? ( http://openwall.info/wiki/_media/john/${MY_P}-omp-${OMPV}.diff.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="altivec custom-cflags -minimal mmx -mpi mscache2 openmp sse2"

# Seems a bit fussy with other MPI implementations.
RDEPEND="!minimal? ( >=dev-libs/openssl-0.9.7 )
	mpi? ( sys-cluster/openmpi )"
DEPEND="${RDEPEND}
	openmp? ( >=sys-devel/gcc-4.2[openmp] )"

S="${WORKDIR}/${MY_P}"

get_target() {
	if use x86; then
		if use sse2; then
			echo "linux-x86-sse2"
		elif use mmx; then
			echo "linux-x86-mmx"
		else
			echo "linux-x86-any"
		fi
	elif use alpha; then
		echo "linux-alpha"
	elif use sparc; then
		echo "linux-sparc"
	elif use amd64; then
		echo "linux-x86-64"
	elif use ppc64; then
		if use altivec; then
			echo "linux-ppc32-altivec"
		else
			echo "linux-ppc64"
		fi
		# linux-ppc64-altivec is slightly slower than linux-ppc32-altivec for most hash types.
		# as per the Makefile comments
	elif use ppc; then
		if use altivec; then
			echo "linux-ppc32-altivec"
		else
			echo "linux-ppc32"
		fi
	else
		echo "generic"
	fi
}

src_prepare() {
	# It looks like the order of the patches is important, so be carefull if you
	# gonna alter this section.

	if use openmp && use sse2; then
		epatch "${WORKDIR}/${MY_P}-omp-${OMPV}.diff"
		sed -i '/JOHN_VERSION/ s/'${PV}-omp-${OMPV}'/'${PV}'/' "${S}/src/params.h"
	fi

	if ! use minimal; then
		epatch "${WORKDIR}/${MY_P}-${JUMBO}.diff"
		sed -i '/JOHN_VERSION/ s/'${PV}-${JUMBO}'/'${PV}'/' "${S}/src/params.h"
	fi
	
	if use mscache2; then
		epatch "${WORKDIR}/${MY_P}-${JUMBO}-mscash2-1.diff"
	fi
	
	if use mpi; then
		sed -i '/JOHN_VERSION/ s/'${PV}-jumbo-3'/'${PV}'/' "${WORKDIR}/${MY_P}-full${MPI}-after-jumbo3.diff"
		epatch "${WORKDIR}/${MY_P}-full${MPI}-after-jumbo3.diff"
		sed -i '/JOHN_VERSION/ s/'${PV}-full${MPI}'/'${PV}'/' "${S}/src/params.h"
	fi
	
	sed -i '/JOHN_VERSION/ s/'${PV}'/'${PV}-pentoo'/' "${S}/src/params.h"

	local PATCHLIST="${PATCHLIST} 1.7.6-cflags 1.7.3.1-mkdir-sandbox"

	cd src
	for p in ${PATCHLIST}; do
		epatch "${FILESDIR}/${PN}-${p}.patch"
	done

	if ! use minimal; then
		sed -e "s/LDFLAGS  *=  */override LDFLAGS += /" -e "/LDFLAGS/s/-s//" \
			-e "/LDFLAGS/s/-L[^ ]*//g" -e "/CFLAGS/s/-[IL][^ ]*//g" \
			-i Makefile || die "sed Makefile failed"
	fi
}

src_compile() {
	local OMP=''

	use custom-cflags || strip-flags
	append-flags -fPIC -fPIE \
		'-DJOHN_SYSTEMWIDE' \
		'-DJOHN_SYSTEMWIDE_HOME=\\\"/etc/john\\\"' \
		'-DJOHN_SYSTEMWIDE_EXEC=\\\"/usr/libexec/john\\\"'
	gcc-specs-pie && append-ldflags -nopie
	use openmp && OMP="-fopenmp"

	CPP=$(tc-getCXX) CC=$(tc-getCC) AS=$(tc-getCC) LD=$(tc-getCC)
	use mpi && CPP=mpicxx CC=mpicc AS=mpicc LD=mpicc
	emake -C src/\
		CPP=${CPP} CC=${CC} AS=${AS} LD=${LD} \
		CFLAGS="-c -Wall ${CFLAGS} ${OMP}" \
		LDFLAGS="${LDFLAGS}" \
		OPT_NORMAL="" \
		OMPFLAGS="${OMP}" \
		$(get_target) || die "emake failed"
}

src_test() {
	cd run
	if [[ -f "/etc/john/john.conf" || -f "/etc/john/john.ini" ]]; then
		# This requires that MPI is actually 100% online on your system, which might not
		# be the case, depending on which MPI implementation you are using.
		#if use mpi; then
		#	mpirun -np 2 ./john --test || die 'self test failed'
		#else

		./john --test || die 'self test failed'
	else
		ewarn "selftest requires /etc/john/john.conf or /etc/john/john.ini"
	fi
}

src_install() {
	# executables
	dosbin run/john || die
	newsbin run/mailer john-mailer || die

	pax-mark -m "${D}"/usr/sbin/john || die

	dosym john /usr/sbin/unafs || die
	dosym john /usr/sbin/unique || die
	dosym john /usr/sbin/unshadow || die

	# jumbo-patch additions
	if ! use minimal; then
		dosym john /usr/sbin/undrop || die
		dosbin run/calc_stat || die
		dosbin run/genmkvpwd || die
		dosbin run/mkvcalcproba || die
		insinto /etc/john
		doins run/genincstats.rb run/stats || die
		doins run/netscreen.py run/sap_prepare.pl || die
	fi

	# config files
	insinto /etc/john
	doins run/john.conf || die
	doins run/*.chr run/password.lst || die

	# documentation
	dodoc doc/* || die
}
