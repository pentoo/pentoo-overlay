# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_PN=github.com/PuerkitoBio/${PN}

# git clone -> checkout proper version -> `get-ego-vendor`
EGO_SUM=(
	"github.com/PuerkitoBio/goquery v1.5.1"
	"github.com/PuerkitoBio/goquery v1.5.1/go.mod"
	"github.com/andybalholm/cascadia v1.1.0"
	"github.com/andybalholm/cascadia v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.0"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.3.0"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/temoto/robotstxt v1.1.1"
	"github.com/temoto/robotstxt v1.1.1/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/net v0.0.0-20180218175443-cbe0f9307d01/go.mod"
	"golang.org/x/net v0.0.0-20200202094626-16171245cfb2"
	"golang.org/x/net v0.0.0-20200202094626-16171245cfb2/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	)
go-module_set_globals

SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"
DESCRIPTION="Simple, flexible web crawler that follows robots.txt policies and crawl delays"
HOMEPAGE="https://github.com/PuerkitoBio/fetchbot"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
