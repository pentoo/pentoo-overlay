# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit mozilla-addon

MOZ_FILEID="283972"
DESCRIPTION="OpenPGP message encryption and authentication for Thunderbird and SeaMonkey."
HOMEPAGE="http://www.enigmail.net"
# SRC_URI="http://www.enigmail.net/download/release/1.7/enigmail-1.7.2-tb+sm.xpi -> ${P}.xpi"
SRC_URI="
	binary? ( http://www.enigmail.net/download/release/1.7/enigmail-1.7.2-tb+sm.xpi -> ${P}.xpi )
	!binary? ( http://www.enigmail.net/download/source/${P}.tar.gz )"

LICENSE="MPL-2.0 GPL-2.0+"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+symlink_all_targets target_thunderbird target_seamonkey target_thunderbird-bin target_seamonkey-bin +binary"

# symlink all possible target paths if this is set
if use symlink_all_targets; then
	MZA_TARGETS="thunderbird seamonkey thunderbird-bin seamonkey-bin"
else
	use target_thunderbird && MZA_TARGETS+=" thunderbird"
	use target_thunderbird-bin && MZA_TARGETS+=" thunderbird-bin"
	use target_seamonkey && MZA_TARGETS+=" seamonkey"
	use target_seamonkey-bin && MZA_TARGETS+=" seamonkey-bin"
fi

RDEPEND="
	!symlink_all_targets? (
		target_seamonkey? ( www-client/seamonkey[-crypt] )
		target_seamonkey-bin? ( www-client/seamonkey-bin )
		target_thunderbird? ( mail-client/thunderbird[-crypt] )
		target_thunderbird-bin? ( mail-client/thunderbird-bin )
	)
	!www-client/seamonkey[crypt]
	!mail-client/thunderbird[crypt]
	|| (
		( >=app-crypt/gnupg-2.0
			|| (
				app-crypt/pinentry[gtk]
				app-crypt/pinentry[qt4]
			)
		)
		=app-crypt/gnupg-1.4* )"

if use !binary; then
	S="${WORKDIR}/${PN}"
	MZA_XPI_PATH="${WORKDIR}/${PN}/build/dist"
fi

src_unpack() {
	if use binary; then
		mozilla-addon_src_unpack
	else
		unpack ${A} || die 'unpack failed'
	fi
}

src_compile() {
	if use !binary; then
		# fails without -j1
		emake -j1
		emake -j1 xpi
	fi
}

pkg_postinst() {
	local peimpl=$(eselect --brief --colour=no pinentry show)
	case "${peimpl}" in
		*gtk*|*qt*) ;;
		*)	ewarn "The pinentry front-end currently selected is not one supported by thunderbird."
			ewarn "You may be prompted for your password in an inaccessible shell!!"
			ewarn "Please use 'eselect pinentry' to select either the gtk or qt front-end" ;;
	esac
}
