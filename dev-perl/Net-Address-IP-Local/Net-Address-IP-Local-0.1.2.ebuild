# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit perl-module

DESCRIPTION="A class for discovering the local system's IP address"
#SRC_URI="https://cpan.metacpan.org/authors/id/J/JM/JMEHNLE/net-address-ip-local/${P}.tar.gz"
SRC_URI="mirror://cpan/authors/id/J/JM/JMEHNLE/net-address-ip-local/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

SRC_TEST="do"

RDEPEND="dev-perl/Error
	dev-perl/IO-Socket-INET6"
#version"
DEPEND="${RDEPEND}"
BDEPEND="dev-perl/Module-Build"
