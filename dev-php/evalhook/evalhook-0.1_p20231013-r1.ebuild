# Copyright 2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

HASH_COMMIT="25e4e2a9b84b4f4c45f3d2dfa35121ed7938b889"

MY_S="${WORKDIR}/php-eval-hook-${HASH_COMMIT}"
PHP_EXT_NAME="evalhook"
USE_PHP="php8-2"
PHP_EXT_S="${MY_S}"

inherit php-ext-source-r3

DESCRIPTION="Decode/Deobfuscate PHP Scripts"
HOMEPAGE="https://github.com/extremecoders-re/php-eval-hook"
SRC_URI="https://github.com/extremecoders-re/php-eval-hook/archive/${HASH_COMMIT}.tar.gz -> ${P}-r1.gh.tar.gz"

S="${MY_S}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_configure() {
	local PHP_EXT_ECONF_ARGS="--enable-evalhook=yes"
	php-ext-source-r3_src_configure
}

pkg_postinst() {
	ewarn "This extention hooks PHP calls and requires user's interaction"
	ewarn "Do not use in production env"
}
