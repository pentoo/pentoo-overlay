# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )

inherit eutils autotools python-r1

#EGIT_REPO_URI="https://github.com/libimobiledevice/libimobiledevice.git"
HASH_COMMIT="98ac7da5255a69fa4620e325228a1c7d79ba42d7"

DESCRIPTION="Support library to communicate with Apple iPhone/iPod Touch devices"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="https://github.com/libimobiledevice/libimobiledevice/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"

# While COPYING* doesn't mention 'or any later version', all the headers do, hence use +
LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0/6" # based on SONAME of libimobiledevice.so
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="debug gnutls python static-libs"

RDEPEND=">=app-pda/libplist-1.12:=
	>=app-pda/libusbmuxd-1.1.0_pre20190118:=
	gnutls? (
		dev-libs/libgcrypt:0
		>=dev-libs/libtasn1-1.1
		>=net-libs/gnutls-2.2.0
		)
	!gnutls? ( dev-libs/openssl:0 )
	python? (
		${PYTHON_DEPS}
		app-pda/libplist[python(-),${PYTHON_USEDEP}]
		)"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	python? ( >=dev-python/cython-0.17[${PYTHON_USEDEP}] )"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DOCS=( AUTHORS NEWS README )

BUILD_DIR="${S}_build"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

src_prepare() {
	eautoreconf
	eapply_user
}

src_configure() {
	local ECONF_SOURCE=${S}

	local myeconfargs=( $(use_enable static-libs static) )
	use gnutls && myeconfargs+=( --disable-openssl )
	use debug && myeconfargs+=( --enable-debug-code )

	do_configure() {
		mkdir -p "${BUILD_DIR}" || die
		pushd "${BUILD_DIR}" >/dev/null || die
		econf "${myeconfargs[@]}" "${@}"
		popd >/dev/null || die
	}

	do_configure_python() {
		# Bug 567916
		PYTHON_LDFLAGS="$(python_get_LIBS)" do_configure "$@"
	}

	do_configure --without-cython
	use python && python_foreach_impl do_configure_python
}

src_compile() {
	python_compile() {
		emake -C "${BUILD_DIR}"/cython -j1 \
			VPATH="${S}/cython:${native_builddir}/cython" \
			imobiledevice_la_LIBADD="${native_builddir}/src/libimobiledevice.la"
	}

	local native_builddir=${BUILD_DIR}
	pushd "${BUILD_DIR}" >/dev/null || die
	emake -j1
	use python && python_foreach_impl python_compile
	popd >/dev/null || die
}

src_install() {
	python_install() {
		emake -C "${BUILD_DIR}/cython" -j1 \
			VPATH="${S}/cython:${native_builddir}/cython" \
			DESTDIR="${D}" install
	}

	local native_builddir=${BUILD_DIR}
	pushd "${BUILD_DIR}" >/dev/null || die
	emake -j1 DESTDIR="${D}" install
	use python && python_foreach_impl python_install
	popd >/dev/null || die

#	dodoc docs/html/*
	if use python; then
		insinto /usr/include/${PN}/cython
		doins cython/imobiledevice.pxd
	fi
	find "${D}" -xtype f -name '*.la' -delete || die
}
