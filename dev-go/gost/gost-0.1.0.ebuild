# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/knqyf263/gost"
EGO_VENDOR=( # see Gopkg.lock file before bump it
	"github.com/BurntSushi/toml             v0.3.0"
	"github.com/cenkalti/backoff            v2.0.0"
	"github.com/dgrijalva/jwt-go            v3.2.0"
	"github.com/fsnotify/fsnotify           v1.4.7"
	"github.com/go-redis/redis              v6.12.0"
	"github.com/go-sql-driver/mysql         v1.4.0"
	"github.com/go-stack/stack              v1.7.0"
	"github.com/hashicorp/hcl               ef8a98b0bbce4a65b5aa4c368430a80ddc533168"
	"github.com/inconshreveable/log15       v2.13"
	"github.com/inconshreveable/mousetrap   v1.0"
	"github.com/jinzhu/gorm                 v1.9.1"
	"github.com/jinzhu/inflection           04140366298a54a039076d798123ffa108fff46c"
	"github.com/labstack/echo               v2.2.0"
	"github.com/labstack/gommon             0.2.6"
	"github.com/lib/pq                      90697d60dd844d5ef6ff15135d0203f65d2f53b8"
	"github.com/magiconair/properties       v1.8.0"
	"github.com/mattn/go-colorable          v0.0.9"
	"github.com/mattn/go-isatty             v0.0.3"
	"github.com/mattn/go-runewidth          v0.0.2"
	"github.com/mitchellh/go-homedir        3864e76763d94a6df2f9960b16a20a33da9f9a66"
	"github.com/mitchellh/mapstructure      bb74f1db0675b241733089d5a1faa5dd8b0ef57b"
	"github.com/moul/http2curl              9ac6cf4d929b2fa8fd2d2e6dec5bb0feb4f4911d"
	"github.com/parnurzeal/gorequest        v0.2.15"
	"github.com/pelletier/go-toml           v1.2.0"
	"github.com/pkg/errors                  v0.8.0"
	"github.com/spf13/afero                 v1.1.1"
	"github.com/spf13/cast                  v1.2.0"
	"github.com/spf13/cobra                 v0.0.3"
	"github.com/spf13/jwalterweatherman     7c0cea34c8ece3fbeb2b27ab9b59511d360fb394"
	"github.com/spf13/pflag                 v1.0.1"
	"github.com/spf13/viper                 v1.0.2"
	"github.com/valyala/bytebufferpool      e746df99fe4a3986f4d4f79e13c1e0117ce9c2f7"
	"github.com/valyala/fasttemplate        dcecefd839c4193db0d35b88ec65b4c12d360ab0"
	"gopkg.in/cheggaaa/pb.v1                v1.0.25 github.com/cheggaaa/pb"
	"gopkg.in/yaml.v2                       v2.2.1 github.com/go-yaml/yaml"
)

inherit golang-vcs-snapshot user

DESCRIPTION="Build a local copy of Security Tracker. Notify via Email/Slack if there is an update"
HOMEPAGE="https://vuls.io/ https://github.com/knqyf263/gost"

SRC_URI="https://github.com/knqyf263/gost/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
IUSE="policykit"
SLOT=0

RDEPEND="policykit? ( sys-auth/polkit )"
DEPEND="
	dev-go/go-net:=
	dev-go/go-sqlite3:=
	dev-go/go-text:=
	dev-go/go-sys:=
	>=dev-lang/go-1.12"

pkg_setup() {
	if use policykit; then
		enewgroup vuls
		enewuser vuls -1 -1 "/var/lib/vuls" vuls
	fi
}

src_prepare() {
	cp "${FILESDIR}"/gost-daemon.initd "${T}" || die

	if ! use policykit; then
		sed -e "s/^USER=\"vuls\"/USER=\"root\"/" \
			-e "s/^GROUP=\"vuls\"/GROUP=\"root\"/" \
			-i "${T}"/gost-daemon.initd || die
	fi

	default
}

src_compile() {
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go build -v -work -x -ldflags="-X main.revision=${PV} -s -w" ./... "${EGO_PN}" || die
}

src_install() {
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go install -v -work -x -ldflags="-X main.revision=${PV} -s -w" ./... "${EGO_PN}" || die

	rm -rf "${S}/src/${EGO_PN}/vendor" || die
	golang_install_pkgs

	exeinto "$(get_golibdir_gopath)"/bin
	doexe bin/${PN}

	newinitd "${T}"/gost-daemon.initd gost-daemon
	newconfd "${FILESDIR}"/gost-daemon.confd gost-daemon

	if use policykit; then
		insinto "/usr/share/polkit-1/rules.d"
		doins "${FILESDIR}"/polkit/10-${PN}.rules

		insinto "/usr/share/polkit-1/actions"
		doins "${FILESDIR}"/polkit/io.vuls.pkexec.${PN}.policy

		dodir "/usr/bin"
		cat > "${D}/usr/bin/${PN}" <<-_EOF_ || die
			#!/bin/sh
			pkexec --user vuls "$(get_golibdir_gopath)/bin/${PN}" "\$@"
		_EOF_

		fperms 0755 "/usr/bin/${PN}"
	else
		dosym "$(get_golibdir_gopath)/bin/${PN}" "/usr/bin/${PN}"
	fi

	keepdir "/var/log/vuls" "/var/lib/vuls"

	dodoc src/"${EGO_PN}"/{README.md,Dockerfile}
}

pkg_postinst() {
	if use policykit; then
		# enewuser is not support "--no-create-home"
		chown -R vuls:vuls \
			"${EROOT%/}/var/lib/vuls" \
			"${EROOT%/}/var/log/vuls" || die

		chmod 0750 \
			"${EROOT%/}/var/lib/vuls" \
			"${EROOT%/}/var/log/vuls" || die
	fi
}
