# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

HASH_COMMIT="25e4e2a9b84b4f4c45f3d2dfa35121ed7938b889"

PHP_EXT_NAME="evalhook"
USE_PHP="php8-2"
inherit php-ext-source-r3

DESCRIPTION="Decode/Deobfuscate PHP Scripts by hooking eval()"
HOMEPAGE="https://github.com/extremecoders-re/php-eval-hook"
SRC_URI="https://github.com/extremecoders-re/php-eval-hook/archive/${HASH_COMMIT}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/php-eval-hook-${HASH_COMMIT}"
PHP_EXT_S="${S}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

pkg_postinst() {
	ewarn "This extention hooks PHP calls and requires user's interaction"
	ewarn "Do not use in production env"
}
