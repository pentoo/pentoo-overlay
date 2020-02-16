# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="User for Vuls"
ACCT_USER_ID=-1
ACCT_USER_HOME=/var/lib/vuls
ACCT_USER_HOME_PERMS=0770
ACCT_USER_GROUPS=( ${PN} )

acct-user_add_deps
