# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_P="LanguageTool-${PV}"

OFFICE_REQ_USE="java"
#OFFICE_IMPLEMENTATIONS=( "libreoffice-bin" "libreoffice" )

OFFICE_EXTENSIONS=(
	"${MY_P}.oxt"
)

inherit office-ext-r1

DESCRIPTION="Style and Grammar Checker for libreoffice"
HOMEPAGE="https://www.languagetool.org/"
SRC_URI="https://www.languagetool.org/download/${MY_P}.oxt"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.8"
