# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit firefox-plugin

FFP_XPI_FILE="${P}"
GITHUB_REVISION="71e09a8e0d70928eff205dc933b516b9b5f50884"

DESCRIPTION="FxPnH is a Firefox addon which makes it possible to use Firefox with Plug-n-Hack providers"
HOMEPAGE="https://github.com/mozmark/ringleader"
SRC_URI="https://github.com/mozmark/ringleader/raw/${GITHUB_REVISION}/fx_pnh.xpi -> ${FFP_XPI_FILE}.xpi"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND} || (
	>=www-client/firefox-bin-24.1.1
	>=www-client/firefox-24.1.1
)"
