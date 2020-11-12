# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

#inherit distutils-r1

DESCRIPTION="Lightweight static analysis for many languages"
HOMEPAGE="https://github.com/returntocorp/semgrep"
SRC_URI="https://github.com/returntocorp/semgrep/archive/v${PV}.tar.gz -> ${P}-core.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
#WIP
#KEYWORDS="~amd64 ~arm64 ~x86"

RDEPEND="dev-lang/ocaml"
DEPEND="${RDEPEND}"

S=${WORKDIR}/semgrep-${PV}/semgrep-core

#  opam install --deps-only -y .
#  make all
#  make install
