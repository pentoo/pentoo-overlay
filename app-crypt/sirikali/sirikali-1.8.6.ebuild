# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake optfeature xdg

DESCRIPTION="A Qt/C++ GUI front end to some encrypted filesystems and sshfs"
HOMEPAGE="
	https://mhogomchungu.github.io/sirikali/
	https://github.com/mhogomchungu/sirikali
"
SRC_URI="https://github.com/mhogomchungu/sirikali/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+keyring +pwquality system-wallet"

DEPEND="
	dev-qt/qtbase:6[dbus,gui,network,widgets]
	dev-libs/libgcrypt:0=
	pwquality? ( dev-libs/libpwquality )
	system-wallet? ( >=app-crypt/lxqt-wallet-4.0.2[keyring=] )
	!system-wallet? ( keyring? ( app-crypt/libsecret ) )
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

pkg_pretend() {
	if use system-wallet; then
		ewarn "USE=system-wallet links against the system app-crypt/lxqt-wallet,"
		ewarn "which currently fails at link time ('protected symbol ... isn't"
		ewarn "defined'), see https://github.com/mhogomchungu/sirikali/issues/300"
		ewarn "Expect this build to fail; the flag exists so the fix is testable."
	fi
}

src_prepare() {
	# there is no CMake switch for pwquality; without this, an installed
	# dev-libs/libpwquality gets linked regardless of USE (automagic dep)
	if ! use pwquality; then
		sed -i '/^pkg_check_modules( PWQUALITY pwquality )/d' CMakeLists.txt \
			|| die "failed to disable automagic pwquality detection"
	fi

	# install man pages uncompressed and let portage handle compression
	sed -i 's/\.1\.gz/\.1/g' CMakeLists.txt \
		|| die "failed to adjust man page install rules"
	gunzip src/sirikali.1.gz src/sirikali.pkexec.1.gz || die

	cmake_src_prepare
}

src_configure() {
	# INTERNAL_LXQT_WALLET=false (external app-crypt/lxqt-wallet) currently
	# fails to link, see https://github.com/mhogomchungu/sirikali/issues/300,
	# so the bundled copy is the default.
	#
	# Upstream has no KWallet 6 support and KWallet 5 is gone from the tree,
	# so the KDE backend is unconditionally disabled.
	local mycmakeargs=(
		-DBUILD_WITH_QT6=true
		-DINTERNAL_LXQT_WALLET=$(usex system-wallet false true)
		-DNOSECRETSUPPORT=$(usex keyring false true)
		-DNOKDESUPPORT=true
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst

	# eCryptfs (needs ecryptfs-simple), EncFS, securefs and cryptomator-cli
	# backends are not suggested because none of them is currently packaged
	elog "SiriKali is a front end only; install at least one backend:"
	optfeature "CryFS volumes" sys-fs/cryfs
	optfeature "gocryptfs volumes" app-crypt/gocryptfs
	optfeature "sshfs volumes" net-fs/sshfs
	optfeature "fscrypt volumes" sys-fs/fscrypt
	optfeature "mounting volumes as root (sirikali.pkexec helper)" sys-auth/polkit
}
