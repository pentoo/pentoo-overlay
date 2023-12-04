# Copyright 1999-2023 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHP_EXT_NAME=evalhook
USE_PHP="php5-6"
PHP_EXT_S="${PN}"
inherit php-ext-source-r3

DESCRIPTION="Decode/Deobfuscate PHP Scripts"
HOMEPAGE="https://github.com/extremecoders-re/php-eval-hook"
SRC_URI="https://github.com/extremecoders-re/php-eval-hook/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	local slot orig_s="${PHP_EXT_S}"
	for slot in $(php_get_slots); do
		php_init_slot_env ${slot}
		eapply_user
		php-ext-source-r3_phpize
	done
}

src_configure() {
	local PHP_EXT_EXTRA_ECONF="--enable-evalhook=yes"
	php-ext-source-r3_src_configure
}

pkg_postinst() {
	ewarn "This extention hooks PHP calls and requires user's interaction"
	ewarn "Do not use in production env"
}
