# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/v8/Attic/v8-3.16.14.9-r1.ebuild,v 1.7 2013/05/24 18:28:14 ago dead $

EAPI="5"
PYTHON_COMPAT=( python2_{6,7} )

inherit eutils multilib pax-utils python-any-r1 toolchain-funcs versionator

DESCRIPTION="Google's open source JavaScript engine"
HOMEPAGE="http://code.google.com/p/v8"
SRC_URI="http://commondatastorage.googleapis.com/chromium-browser-official/${P}.tar.bz2"
LICENSE="BSD"

soname_version="${PV}"
SLOT="0/${soname_version}"
KEYWORDS="amd64 ~arm x86 ~x86-fbsd ~x64-macos ~x86-macos"
IUSE=""

DEPEND="${PYTHON_DEPS}"

src_configure() {
	tc-export AR CC CXX RANLIB
	export LINK=${CXX}

	local hardfp=off

	# Use target arch detection logic from bug #354601.
	case ${CHOST} in
		i?86-*) myarch=ia32 ;;
		x86_64-*)
			if [[ $ABI = x86 ]] ; then
				myarch=ia32
			else
				myarch=x64
			fi ;;
		arm*-hardfloat-*)
			hardfp=on
			myarch=arm ;;
		arm*-*) myarch=arm ;;
		*) die "Unrecognized CHOST: ${CHOST}"
	esac
	mytarget=${myarch}.release

	# TODO: Add console=readline option once implemented upstream
	# http://code.google.com/p/v8/issues/detail?id=1781

	# Generate the real Makefile.
	emake V=1 \
		library=shared \
		werror=no \
		soname_version=${soname_version} \
		snapshot=on \
		hardfp=${hardfp} \
		out/Makefile.${myarch} || die
}

src_compile() {
	local makeargs=(
		-C out
		-f Makefile.${myarch}
		V=1
		BUILDTYPE=Release
		builddir="${S}/out/${mytarget}"
	)

	# Build mksnapshot so we can pax-mark it.
	emake "${makeargs[@]}" mksnapshot
	pax-mark m out/${mytarget}/mksnapshot

	# Build everything else.
	emake "${makeargs[@]}"
	pax-mark m out/${mytarget}/{cctest,d8,shell}
}

src_test() {
	local arg testjobs
	for arg in ${MAKEOPTS}; do
		case ${arg} in
			-j*) testjobs=${arg#-j} ;;
			--jobs=*) testjobs=${arg#--jobs=} ;;
		esac
	done

	tools/test-wrapper-gypbuild.py \
		-j${testjobs:-1} \
		--arch-and-mode=${mytarget} \
		--no-presubmit \
		--progress=dots || die
}

src_install() {
	insinto /usr
	doins -r include || die

	if [[ ${CHOST} == *-darwin* ]] ; then
		# buildsystem is too horrific to get this built correctly
		mkdir -p out/${mytarget}/lib.target
		mv out/${mytarget}/libv8.so.${soname_version} \
			out/${mytarget}/lib.target/libv8$(get_libname ${soname_version}) || die
		install_name_tool \
			-id "${EPREFIX}"/usr/$(get_libdir)/libv8$(get_libname) \
			out/${mytarget}/lib.target/libv8$(get_libname ${soname_version}) \
			|| die
		install_name_tool \
			-change \
			/usr/local/lib/libv8.so.${soname_version} \
			"${EPREFIX}"/usr/$(get_libdir)/libv8$(get_libname) \
			out/${mytarget}/d8 || die
	fi

	dobin out/${mytarget}/d8 || die
	pax-mark m "${ED}usr/bin/d8"

	dolib out/${mytarget}/lib.target/libv8$(get_libname ${soname_version}) || die
	dosym libv8$(get_libname ${soname_version}) /usr/$(get_libdir)/libv8$(get_libname) || die

	dodoc AUTHORS ChangeLog || die
}
