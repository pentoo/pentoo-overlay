# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-1.4.11.ebuild,v 1.7 2010/12/15 22:12:01 maekke Exp $

EAPI="3"

inherit eutils flag-o-matic toolchain-funcs

ECCVER="0.2.0"
ECCVER_GNUPG="1.4.9"
ECC_PATCH="${PN}-${ECCVER_GNUPG}-ecc${ECCVER}.diff"
MY_P=${P/_/}

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="mirror://gnupg/gnupg/${P}.tar.bz2
	!bindist? (
		idea? ( mirror://gentoo/idea.c.gz )
		)"
#		ecc? ( http://www.calcurco.cat/eccGnuPG/src/${ECC_PATCH}.bz2 )

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="bzip2 bindist curl idea ldap nls readline selinux smartcard static usb zlib linguas_ru"
#IUSE="bzip2 bindist curl ecc idea ldap nls readline selinux smartcard static usb zlib linguas_ru"

COMMON_DEPEND="
	ldap? ( net-nds/openldap )
	bzip2? ( app-arch/bzip2 )
	zlib? ( sys-libs/zlib )
	curl? ( net-misc/curl )
	virtual/mta
	readline? ( sys-libs/readline )
	smartcard? ( =virtual/libusb-0* )
	usb? ( =virtual/libusb-0* )"

RDEPEND="!static? ( ${COMMON_DEPEND} )
	selinux? ( sec-policy/selinux-gnupg )
	nls? ( virtual/libintl )"

DEPEND="${COMMON_DEPEND}
	dev-lang/perl
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	if use idea; then
		if use bindist; then
			einfo "Skipping IDEA support to comply with binary distribution (bug #148907)."
		else
			ewarn "Please read http://www.gnupg.org/(en)/faq/why-not-idea.html"
			mv "${WORKDIR}"/idea.c "${S}"/cipher/idea.c || \
			ewarn "failed to insert IDEA module"
		fi
	fi

#	if use ecc; then
#		if use bindist; then
#			einfo "Skipping ECC patch to comply with binary distribution (bug #148907)."
#		else
#			sed -i \
#				"s/- VERSION='${ECCVER_GNUPG}'/- VERSION='${PV}'/" \
#				"${WORKDIR}/${ECC_PATCH}"
#			sed -i \
#				"s/+ VERSION='${ECCVER_GNUPG}-ecc${ECCVER}'/+ VERSION='${PV}-ecc${ECCVER}'/" \
#				"${WORKDIR}/${ECC_PATCH}"
#
#			epatch "${WORKDIR}/${ECC_PATCH}"
#		fi
#	fi

	# Install RU man page in right location
	sed -e "/^man_MANS =/s/ gpg\.ru\.1//" -i doc/Makefile.in || die "sed doc/Makefile.in failed"

	# Fix PIC definitions
	sed -i -e 's:PIC:__PIC__:' mpi/i386/mpih-{add,sub}1.S intl/relocatable.c \
		|| die "sed PIC failed"
	sed -i -e 's:if PIC:ifdef __PIC__:' mpi/sparc32v8/mpih-mul{1,2}.S || \
		die"Sed PIC failed"
}

src_configure() {
	# Certain sparc32 machines seem to have trouble building correctly with
	# -mcpu enabled.  While this is not a gnupg problem, it is a temporary
	# fix until the gcc problem can be tracked down.
	if [ "${ARCH}" == "sparc" ] && [ "${PROFILE_ARCH}" == "sparc" ]; then
		filter-flags -mcpu=supersparc -mcpu=v8 -mcpu=v7
	fi

	# 'USE=static' support was requested in #29299
	use static &&append-ldflags -static

	econf \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		$(use_enable ldap) \
		--enable-mailto \
		--enable-hkp \
		--enable-finger \
		$(use_with !zlib included-zlib) \
		$(use_with curl libcurl /usr) \
		$(use_enable nls) \
		$(use_enable bzip2) \
		$(use_enable smartcard card-support) \
		$(use_enable selinux selinux-support) \
		--without-capabilities \
		$(use_with readline) \
		$(use_with usb libusb /usr) \
		--enable-static-rnd=linux \
		--libexecdir="${EPREFIX}/usr/libexec" \
		--enable-noexecstack \
		CC_FOR_BUILD=$(tc-getBUILD_CC) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# keep the documentation in /usr/share/doc/...
	rm -rf "${ED}usr/share/gnupg/FAQ" "${ED}usr/share/gnupg/faq.html" || die

	dodoc AUTHORS BUGS ChangeLog NEWS PROJECTS README THANKS \
		TODO VERSION doc/{FAQ,HACKING,DETAILS,OpenPGP} || die

	exeinto /usr/libexec/gnupg
	doexe tools/make-dns-cert || die

	# install RU documentation in right location
	if use linguas_ru; then
		cp doc/gpg.ru.1 "${T}/gpg.1" || die
		doman -i18n=ru "${T}/gpg.1" || die
	fi
}

pkg_postinst() {
	ewarn "If you are using a non-Linux system, or a kernel older than 2.6.9,"
	ewarn "you MUST make the gpg binary setuid."
	echo
	if use !bindist && use idea; then
		elog
		elog "IDEA"
		elog "you have compiled ${PN} with support for the IDEA algorithm, this code"
		elog "is distributed under the GPL in countries where it is permitted to do so"
		elog "by law."
		elog
		elog "Please read http://www.gnupg.org/(en)/faq/why-not-idea.html for more information."
		elog
		ewarn "If you are in a country where the IDEA algorithm is patented, you are permitted"
		ewarn "to use it at no cost for 'non revenue generating data transfer between private"
		ewarn "individuals'."
		ewarn
		ewarn "Countries where the patent applies are listed here"
		ewarn "http://en.wikipedia.org/wiki/International_Data_Encryption_Algorithm#Security"
		ewarn
		ewarn "Further information and other licenses are availble from http://www.mediacrypt.com/"
		ewarn
	fi
#	if use !bindist && use ecc; then
#		ewarn
#		ewarn "The elliptical curves patch is experimental"
#		ewarn "Further info available at http://alumnes.eps.udl.es/%7Ed4372211/index.en.html"
#	fi
	elog
	elog "See http://www.gentoo.org/doc/en/gnupg-user.xml for documentation on gnupg"
	elog
	elog "If you wish to view images emerge:"
	elog "media-gfx/xloadimage, media-gfx/xli or any other viewer"
	elog "Remember to use photo-viewer option in configuration file to activate the right viewer"
}
