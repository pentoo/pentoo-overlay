# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_PN=github.com/sensepost/ruler

# use dev-go/get-ego-vendor to generate EGO_SUM
EGO_SUM=(
	"github.com/BurntSushi/toml v0.3.1/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.0-20190314233015-f79a8a8ca69d"
	"github.com/cpuguy83/go-md2man/v2 v2.0.0-20190314233015-f79a8a8ca69d/go.mod"
	"github.com/howeyc/gopass v0.0.0-20190910152052-7cb4b85ec19c"
	"github.com/howeyc/gopass v0.0.0-20190910152052-7cb4b85ec19c/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/russross/blackfriday/v2 v2.0.1"
	"github.com/russross/blackfriday/v2 v2.0.1/go.mod"
	"github.com/shurcooL/sanitized_anchor_name v1.0.0"
	"github.com/shurcooL/sanitized_anchor_name v1.0.0/go.mod"
	"github.com/staaldraad/go-ntlm v0.0.0-20200612175713-cd032d41aa8c"
	"github.com/staaldraad/go-ntlm v0.0.0-20200612175713-cd032d41aa8c/go.mod"
	"github.com/urfave/cli v1.22.5"
	"github.com/urfave/cli v1.22.5/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/net v0.0.0-20210119194325-5f4716e94777"
	"golang.org/x/net v0.0.0-20210119194325-5f4716e94777/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v2 v2.4.0"
	"gopkg.in/yaml.v2 v2.4.0/go.mod"
	)
go-module_set_globals

DESCRIPTION="A tool to abuse Exchange services"
HOMEPAGE="https://github.com/sensepost/ruler"
SRC_URI="https://${EGO_PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="CC-BY-NC-SA-4.0"
SLOT=0
IUSE=""
KEYWORDS="amd64 ~arm arm64"

DEPEND=""
RDEPEND=""

src_compile() {
	env GOBIN="${S}/bin" go install ./... ||
		die "compile failed"
}

src_install(){
	dobin bin/ruler
	newbin bin/webdav ruler_webdav
}
