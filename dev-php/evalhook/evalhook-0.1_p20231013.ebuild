# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

HASH_COMMIT="bf63f72a0ead21a0ffb9c2ed4c791262ed55a07c"

MY_S="${WORKDIR}/php-eval-hook-${HASH_COMMIT}"
PHP_EXT_NAME=evalhook
USE_PHP="php8-2"
PHP_EXT_S="${MY_S}"
inherit php-ext-source-r3

DESCRIPTION="Decode/Deobfuscate PHP Scripts"
HOMEPAGE="https://github.com/extremecoders-re/php-eval-hook"
SRC_URI="https://github.com/extremecoders-re/php-eval-hook/archive/${HASH_COMMIT}.tar.gz -> ${P}.gh.tar.gz"

S="${MY_S}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	php-ext-source-r3_src_prepare

	local slot orig_s="${PHP_EXT_S}"
	for slot in $(php_get_slots); do
		php_init_slot_env ${slot}
		eapply_user
		php-ext-source-r3_phpize
	done
#	eapply_user
}

src_configure() {
	local PHP_EXT_EXTRA_ECONF="--enable-evalhook=yes"
	php-ext-source-r3_src_configure
}

pkg_postinst() {
	ewarn "This extention hooks PHP calls and requires user's interaction"
	ewarn "Do not use in production env"
}
