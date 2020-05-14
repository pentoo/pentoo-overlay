# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_MAKEFILE_GENERATOR="emake"
inherit cmake-utils flag-o-matic systemd toolchain-funcs

DESCRIPTION="Greenbone vulnerability manager, previously named openvas-manager"
HOMEPAGE="https://www.greenbone.net/en/"
SRC_URI="https://github.com/greenbone/gvmd/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2+"
KEYWORDS="~amd64 ~x86"
IUSE="extras"

DEPEND="dev-libs/libgcrypt:0=
	dev-libs/libical
	>=net-analyzer/gvm-libs-11.0.0
	net-libs/gnutls:=[tools]
	dev-db/postgresql:*[uuid]
	extras?	( app-text/xmlstarlet
		dev-texlive/texlive-latexextra
	)"

RDEPEND="
	${DEPEND}
	!net-analyzer/openvas-manager
	>=net-analyzer/openvas-scanner-7.0.0
	!~net-analyzer/openvas-9.0.0"

BDEPEND="
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
	extras? ( app-doc/doxygen[dot]
		  app-doc/xmltoman
		  app-text/htmldoc
		  dev-libs/libxslt
	)"

PATCHES=(
	# Install exec. to /usr/bin instead of /usr/sbin
	"${FILESDIR}/${PN}-9.0.0-sbin.patch"
	# Fix permissions for user gvm.
	"${FILESDIR}/${PN}-9.0.0-tmplock.patch"
	#https://github.com/greenbone/gsa/issues/1258
#	"${FILESDIR}/${P}-git.patch"
)

src_prepare() {
#	sed -i -e "s|/tmp/ospd.sock|/var/run/ospd/ospd.sock|g" "$S"/src/manage_sql.c || die

	cmake-utils_src_prepare
	# QA-Fix | Use correct FHS/Gentoo policy paths for 8.0.1
	sed -i -e "s*share/doc/gvm/html/*share/doc/gvmd-${PV}/html/*g" "$S"/doc/CMakeLists.txt || die
	sed -i -e "s*/doc/gvm/*/doc/gvmd-${PV}/*g" "$S"/CMakeLists.txt || die
	# QA-Fix | Remove !CLANG Doxygen warnings for 8.0.1
	if use extras; then
		if ! tc-is-clang; then
		   local f
		   for f in doc/*.in
		   do
			sed -i \
				-e "s*CLANG_ASSISTED_PARSING = NO*#CLANG_ASSISTED_PARSING = NO*g" \
				-e "s*CLANG_OPTIONS*#CLANG_OPTIONS*g" \
				"${f}" || die "couldn't disable CLANG parsing"
		   done
		fi
	fi
}

src_configure() {
	local mycmakeargs=(
		"-DCMAKE_INSTALL_PREFIX=${EPREFIX}/usr"
		"-DLOCALSTATEDIR=${EPREFIX}/var"
		"-DSYSCONFDIR=${EPREFIX}/etc"
		"-DLIBDIR=${EPREFIX}/usr/$(get_libdir)"
	)
	# Add release hardening flags for 8.0.1
	append-cflags -Wno-nonnull -Wformat -Wformat-security -D_FORTIFY_SOURCE=2 -fstack-protector
	append-ldflags -Wl,-z,relro -Wl,-z,now
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	if use extras; then
		cmake-utils_src_make -C "${BUILD_DIR}" doc
		cmake-utils_src_make doc-full -C "${BUILD_DIR}" doc
		HTML_DOCS=( "${BUILD_DIR}"/doc/generated/html/. )
	fi
	cmake-utils_src_make rebuild_cache
}

src_install() {
	cmake-utils_src_install

	dodir /etc/gvm
	insinto /etc/gvm
	doins -r "${FILESDIR}"/*sync*

	dodir /etc/gvm/sysconfig
	insinto /etc/gvm/sysconfig
	doins "${FILESDIR}/${PN}-daemon9.conf"

	exeinto /etc/gvm
	doexe "${FILESDIR}"/gvmd-startpre.sh

	fowners -R gvm:gvm /etc/gvm

	newinitd "${FILESDIR}/${PN}.init9" "${PN}"
	newconfd "${FILESDIR}/${PN}-daemon9.conf" "${PN}"

	insinto /etc/logrotate.d
	newins "${FILESDIR}/${PN}.logrotate" "${PN}"

	systemd_dounit "${FILESDIR}/${PN}.service"

	# Set proper permissions on required files/directories
	keepdir /var/lib/gvm/gvmd
	fowners -R gvm:gvm /var/lib/gvm
}
