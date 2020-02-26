# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_PN=github.com/hashicorp/${PN}

if [[ ${PV} = *9999* ]]; then
	inherit golang-vcs
else
	KEYWORDS="~amd64 ~x86 ~arm ~arm64"
	EGIT_COMMIT="3d5d8f294aa03d8e98859feac328afbdf1ae0703"
	SRC_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
	inherit golang-vcs-snapshot
fi

inherit golang-build

DESCRIPTION="A Go (golang) package for representing a list of errors as a single error"
HOMEPAGE="https://github.com/hashicorp/go-multierror"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/go-1.10"
DEPEND="${RDEPEND}"
