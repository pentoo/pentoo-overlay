# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/future-architect/vuls"
EGO_VENDOR=(
	"contrib.go.opencensus.io/exporter/ocagent v0.4.11 github.com/census-ecosystem/opencensus-go-exporter-ocagent"
	"github.com/Azure/azure-sdk-for-go         v27.0.0"
	"github.com/Azure/go-autorest              v11.7.0"
	"github.com/BurntSushi/toml                v0.3.1"
	"github.com/RackSec/srslog                 a4725f04ec91af1a91b380da679d6e0c2f061e59"
	"github.com/asaskevich/govalidator         v9"
	"github.com/aws/aws-sdk-go                 v1.19.11"
	"github.com/boltdb/bolt                    v1.3.1"
	"github.com/cenkalti/backoff               v2.1.1"
	"github.com/census-instrumentation/opencensus-proto v0.2.0"
	"github.com/cheggaaa/pb                    v2.0.6"
	"github.com/dgrijalva/jwt-go               v3.2.0"
	"github.com/fatih/color                    v1.5.0"
	"github.com/fsnotify/fsnotify              v1.4.7"
	"github.com/go-redis/redis                 v6.15.2"
	"github.com/go-sql-driver/mysql            v1.4.1"
	"github.com/go-stack/stack                 v1.8.0"
	"github.com/golang/protobuf                v1.3.1"
	"github.com/google/subcommands             1.0.1"
	"github.com/gorilla/websocket              v1.4.0"
	"github.com/gosuri/uitable                 36ee7e946282a3fb1cfecd476ddc9b35d8847e42"
	"github.com/grokify/html-strip-tags-go     e9e44961e26f513866063f54bf85070db95600f7"
	"github.com/grpc-ecosystem/grpc-gateway    v1.8.5"
	"github.com/hashicorp/go-version           v1.1.0"
	"github.com/hashicorp/golang-lru           v0.5.1"
	"github.com/hashicorp/hcl                  v1.0.0"
	"github.com/hashicorp/uuid                 ebb0a03e909c9c642a36d2527729104324c44fdb"
	"github.com/howeyc/gopass                  bf9dde6d0d2c004a008c27aaee91170c786f6db8"
	"github.com/inconshreveable/log15          v2.14"
	"github.com/jinzhu/gorm                    v1.9.2"
	"github.com/jinzhu/inflection              04140366298a54a039076d798123ffa108fff46c"
	"github.com/jmespath/go-jmespath           c2b33e84"
	"github.com/jroimartin/gocui               v0.4.0"
	"github.com/k0kubun/pp                     v3.0.1"
	"github.com/knqyf263/go-cpe                659663f6eca2ff32258e282557e7808115ea498a"
	"github.com/knqyf263/go-deb-version        9865fe14d09b1c729188ac810466dde90f897ee3"
	"github.com/knqyf263/go-rpm-version        74609b86c936dff800c69ec89fcf4bc52d5f13a4"
	"github.com/knqyf263/gost                  39175c0da9e325ae7260df93ad14b0343d7d5559"
	"github.com/konsorten/go-windows-terminal-sequences v1.0.2"
	"github.com/kotakanbe/go-cve-dictionary    5fe52611f0b8dff9f95374d9cd7bdb23cc5fc67a"
	"github.com/kotakanbe/go-pingscanner       v0.1.0"
	"github.com/kotakanbe/goval-dictionary     v0.1.1"
	"github.com/kotakanbe/logrus-prefixed-formatter 928f7356cb964637e2489a6ef37eee55181676c5"
	"github.com/labstack/gommon                v0.2.8"
	"github.com/lib/pq                         v1.0.0"
	"github.com/magiconair/properties          v1.8.0"
	"github.com/marstr/guid                    v1.1.0"
	"github.com/mattn/go-colorable             v0.1.1"
	"github.com/mattn/go-isatty                v0.0.7"
	"github.com/mattn/go-runewidth             v0.0.4"
	"github.com/mgutz/ansi                     9520e82c474b0a04dd04f8a40959027271bab992"
	"github.com/mitchellh/go-homedir           v1.1.0"
	"github.com/mitchellh/mapstructure         v1.1.2"
	"github.com/moul/http2curl                 v1.0.0"
	"github.com/mozqnet/go-exploitdb           812d09910e5c7cace0807618a6cb99c0f5a9d7d8"
	"github.com/nlopes/slack                   v0.4.0"
	"github.com/nsf/termbox-go                 288510b9734e30e7966ec2f22b87c5f8e67345e3"
	"github.com/olekukonko/tablewriter         v0.0.1"
	"github.com/parnurzeal/gorequest           v0.2.15"
	"github.com/pelletier/go-toml              v1.3.0"
	"github.com/pkg/errors                     v0.8.1"
	"github.com/rifflock/lfshook               v2.4"
	"github.com/satori/go.uuid                 v1.2.0"
	"github.com/sirupsen/logrus                9b3cdde74fbe9443d704467498a7dcb61a79de9b"
	"github.com/spf13/afero                    v1.2.2"
	"github.com/spf13/cast                     v1.3.0"
	"github.com/spf13/jwalterweatherman        v1.1.0"
	"github.com/spf13/pflag                    v1.0.3"
	"github.com/spf13/viper                    v1.3.2"
	"github.com/valyala/bytebufferpool         v1.0.0"
	"github.com/valyala/fasttemplate           v1.0.1"
	"github.com/ymomoi/goval-parser            0a0be1dd9d0855b50be0be5a10ad3085382b6d59"
	"go.opencensus.io                          v0.19.3 github.com/census-instrumentation/opencensus-go"
	"golang.org/x/sync                         e225da77a7e68af35c70ccbf71af2b83e6acac3c github.com/golang/sync"
	"golang.org/x/xerrors                      d61658bd2e18010be0e21349cc92b1b706e35146 github.com/golang/xerrors"
	"google.golang.org/api                     v0.3.0 github.com/googleapis/google-api-go-client"
	"google.golang.org/genproto                64821d5d210748c883cd2b809589555ae4654203 github.com/google/go-genproto"
	"google.golang.org/grpc                    v1.19.1 github.com/grpc/grpc-go"
	"gopkg.in/VividCortex/ewma.v1              v1.1.1 github.com/VividCortex/ewma"
	"gopkg.in/cheggaaa/pb.v1                   v1.0.28 github.com/cheggaaa/pb"
	"gopkg.in/cheggaaa/pb.v2                   v2.0.6 github.com/cheggaaa/pb"
	"gopkg.in/fatih/color.v1                   v1.5.0 github.com/fatih/color"
	"gopkg.in/mattn/go-colorable.v0            v0.0.9 github.com/mattn/go-colorable"
	"gopkg.in/mattn/go-isatty.v0               v0.0.7 github.com/mattn/go-isatty"
	"gopkg.in/mattn/go-runewidth.v0            v0.0.4 github.com/mattn/go-runewidth"
	"gopkg.in/yaml.v2                          v2.2.2 github.com/go-yaml/yaml"
)

inherit eutils golang-vcs-snapshot user

DESCRIPTION="Vulnerability scanner for Linux, agentless, written in golang"
HOMEPAGE="https://vuls.io https://github.com/future-architect/vuls"

SRC_URI="https://github.com/future-architect/vuls/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="~amd64"
LICENSE="GPL-2"
IUSE="webui policykit"
SLOT=0

DEPEND="
	dev-go/go-net:=
	dev-go/go-oauth2:=
	dev-go/go-sqlite3:=
	dev-go/go-crypto:=
	dev-go/go-sys:=
	dev-go/go-text:=
	>=dev-lang/go-1.12"

RDEPEND="
	dev-go/go-cve-dictionary[policykit=]
	dev-go/goval-dictionary[policykit=]
	dev-go/gost[policykit=]
	dev-go/go-exploitdb[policykit=]
	webui? ( www-apps/vulsrepo )
	policykit? ( sys-auth/polkit )
	virtual/ssh"

pkg_setup() {
	if use policykit; then
		enewgroup ${PN}
		enewuser ${PN} -1 -1 "/var/lib/vuls" ${PN}
	fi
}

src_prepare() {
	cp "${FILESDIR}"/vuls-server.initd "${T}" || die

	if ! use policykit; then
		sed -e "s/^USER=\"vuls\"/USER=\"root\"/" \
			-e "s/^GROUP=\"vuls\"/GROUP=\"root\"/" \
			-i "${T}"/vuls-server.initd || die
	fi

	default
}

src_compile() {
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go build -v -work -x -ldflags="-s -w" ./... "${EGO_PN}" || die
}

src_install() {
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go install -v -work -x -ldflags="-s -w" ./... "${EGO_PN}" || die

	rm -rf "${S}/src/${EGO_PN}/vendor" || die
	golang_install_pkgs

	exeinto "$(get_golibdir_gopath)"/bin
	doexe bin/${PN}

	insinto "/etc/${PN}"
	doins "${FILESDIR}"/server-config.toml

	fowners -R ${PN}:${PN} "/etc/${PN}"
	fperms 0750 "/etc/${PN}"

	newinitd "${T}"/vuls-server.initd vuls-server
	newconfd "${FILESDIR}"/vuls-server.confd vuls-server

	if use policykit; then
		insinto "/usr/share/polkit-1/rules.d"
		doins "${FILESDIR}"/polkit/10-${PN}.rules

		insinto "/usr/share/polkit-1/actions"
		doins "${FILESDIR}"/polkit/io.vuls.pkexec.${PN}.policy

		dodir "/usr/bin"
		cat > "${D}/usr/bin/${PN}" <<-_EOF_ || die
			#!/bin/sh
			pkexec --user ${PN} "$(get_golibdir_gopath)/bin/${PN}" "\$@"
		_EOF_

		fperms 0755 "/usr/bin/${PN}"
	else
		dosym "$(get_golibdir_gopath)/bin/${PN}" "/usr/bin/${PN}"
	fi

	keepdir "/var/log/${PN}" "/var/lib/${PN}"

	dodoc \
		src/"${EGO_PN}"/{README.md,Dockerfile} \
		"${FILESDIR}"/config.toml.sample
}

pkg_postinst() {
	if use policykit; then
		# enewuser is not support "--no-create-home"
		chown -R ${PN}:${PN} \
			"${EROOT%/}/var/lib/vuls" \
			"${EROOT%/}/var/log/vuls" || die

		chmod 0770 \
			"${EROOT%/}/var/lib/vuls" \
			"${EROOT%/}/var/log/vuls" || die

		ewarn "\n1) Add youself to \"vuls\" group:"
		ewarn "    ~# gpasswd -a <username> vuls\n"
		ewarn "2) If you want to use remote scan via SSH you need to generate a ssh key using:"
		ewarn "    ~$ pkexec --user ${PN} \"ssh-keygen\""
		ewarn "    ~$ pkexec --user ${PN} \"ssh-copy-id\" \"user@192.168.10.23\"\n"
		ewarn "3) Create a config.toml file in /var/lib/${PN}/:"
		ewarn "    ~$ bzip2 -dc /usr/share/doc/vuls-${PV}/config.toml.sample.bz2 > /var/lib/${PN}/config.toml\n"
	fi
}
