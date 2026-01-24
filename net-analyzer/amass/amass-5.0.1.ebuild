# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
IUSE="ae-isready amass-engine oam-assoc oam-enum oam-i2y oam-subs oam-track +oam-viz"

inherit go-module

DESCRIPTION="Subdomain OSINT Enumeration"
HOMEPAGE="https://github.com/owasp-amass/amass"

SRC_URI="https://github.com/owasp-amass/amass/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz ${P}-deps.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 x86"

BDEPEND=">=dev-lang/go-1.24.4"

src_compile() {
	einfo "Building amass"
	CGO_ENABLED=0 ego build -trimpath -o amass ./cmd/amass || die "Failed to build amass"

	if use ae-isready; then
		einfo "Building ae_isready"
		CGO_ENABLED=0 ego build -trimpath -o ae_isready ./cmd/ae_isready || die "Failed to build ae_isready"
  	fi

	if use amass-engine; then
		einfo "Building amass_engine"
		CGO_ENABLED=0 ego build -trimpath -o amass_engine ./cmd/amass_engine || die "Failed to build amass_engine"
	fi

	if use oam-assoc; then
		einfo "Building oam_assoc"
		CGO_ENABLED=0 ego build -trimpath -o oam_assoc ./cmd/oam_assoc || die "Failed to build oam_assoc"
	fi

	if use oam-enum; then
		einfo "Building oam_enum"
		CGO_ENABLED=0 ego build -trimpath -o oam_enum ./cmd/oam_enum || die "Failed to build oam_enum"
	fi

	if use oam-i2y; then
		einfo "Building oam_i2y"
		CGO_ENABLED=0 ego build -trimpath -o oam_i2y ./cmd/oam_i2y || die "Failed to build oam_i2y"
	fi

	if use oam-subs; then
		einfo "Building oam_subs"
		CGO_ENABLED=0 ego build -trimpath -o oam_subs ./cmd/oam_subs || die "Failed to build oam_subs"
	fi

	if use oam-track; then
		einfo "Building oam_track"
		CGO_ENABLED=0 ego build -trimpath -o oam_track ./cmd/oam_track || die "Failed to build oam_track"
	fi

	if use oam-viz; then
		einfo "Building oam_viz"
		CGO_ENABLED=0 ego build -trimpath -o oam_viz ./cmd/oam_viz || die "Failed to build oam_viz"
	fi
}

src_install() {
	dobin amass

	use ae-isready    && dobin ae_isready
	use amass-engine  && dobin amass_engine
	use oam-assoc     && dobin oam_assoc
	use oam-enum      && dobin oam_enum
	use oam-i2y       && dobin oam_i2y
	use oam-subs      && dobin oam_subs
	use oam-track     && dobin oam_track
	use oam-viz       && dobin oam_viz
}

