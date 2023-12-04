# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PHP_EXT_NAME=evalhook
USE_PHP="php5-6"
PHP_EXT_S="${PN}"
inherit php-ext-source-r3

DESCRIPTION="Decode/Deobfuscate PHP Scripts"
HOMEPAGE="http://php-security.org/2010/05/13/article-decoding-a-user-space-encoded-php-script/"
SRC_URI="http://php-security.org/downloads/${P}.tar.gz"

LICENSE="Unknown"
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
