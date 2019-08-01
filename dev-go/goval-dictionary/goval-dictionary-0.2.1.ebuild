# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/kotakanbe/goval-dictionary"
EGO_VENDOR=(
	"github.com/BurntSushi/toml v0.3.1"
	"github.com/Shopify/sarama v1.19.0"
	"github.com/Shopify/toxiproxy v2.1.4"
	"github.com/alecthomas/template a0175ee"
	"github.com/alecthomas/units 2efee85"
	"github.com/apache/thrift v0.12.0"
	"github.com/asaskevich/govalidator f61b66f"
	"github.com/beorn7/perks 3a771d9"
	"github.com/client9/misspell v0.3.4"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/denisenkom/go-mssqldb eb9f6a1"
	"github.com/dgrijalva/jwt-go v3.2.0"
	"github.com/eapache/go-resiliency v1.1.0"
	"github.com/eapache/go-xerial-snappy 776d571"
	"github.com/eapache/queue v1.1.0"
	"github.com/erikstmartin/go-testdb 8d10e4a"
	"github.com/fsnotify/fsnotify v1.4.7"
	"github.com/go-kit/kit v0.8.0"
	"github.com/go-logfmt/logfmt v0.3.0"
	"github.com/go-redis/redis v6.15.2"
	"github.com/go-sql-driver/mysql v1.4.1"
	"github.com/go-stack/stack v1.8.0"
	"github.com/gogo/protobuf v1.2.0"
	"github.com/golang/glog 23def4e"
	"github.com/golang/mock v1.2.0"
	"github.com/golang/protobuf v1.2.0"
	"github.com/golang/snappy 2e65f85"
	"github.com/google/btree 4030bb1"
	"github.com/google/go-cmp v0.2.0"
	"github.com/google/martian v2.1.0"
	"github.com/google/pprof 3ea8567"
	"github.com/google/subcommands v1.0.1"
	"github.com/googleapis/gax-go v2.0.4"
	"github.com/gorilla/context v1.1.1"
	"github.com/gorilla/mux v1.6.2"
	"github.com/hashicorp/golang-lru v0.5.0"
	"github.com/hpcloud/tail v1.0.0"
	"github.com/htcat/htcat v1.0.2"
	"github.com/inconshreveable/log15 67afb5e"
	"github.com/jinzhu/gorm v1.9.10"
	"github.com/jinzhu/inflection v1.0.0"
	"github.com/jinzhu/now v1.0.1"
	"github.com/jstemmer/go-junit-report af01ea7"
	"github.com/julienschmidt/httprouter v1.2.0"
	"github.com/k0kubun/pp v3.0.1"
	"github.com/kisielk/gotool v1.0.0"
	"github.com/konsorten/go-windows-terminal-sequences v1.0.1"
	"github.com/kr/logfmt b84e30a"
	"github.com/labstack/echo v3.3.10"
	"github.com/labstack/gommon v0.2.9"
	"github.com/lib/pq v1.1.1"
	"github.com/mattn/go-colorable v0.1.2"
	"github.com/mattn/go-isatty v0.0.8"
	"github.com/mattn/go-sqlite3 v1.11.0"
	"github.com/matttproud/golang_protobuf_extensions v1.0.1"
	"github.com/mwitkow/go-conntrack cc309e4"
	"github.com/onsi/ginkgo v1.7.0"
	"github.com/onsi/gomega v1.4.3"
	"github.com/openzipkin/zipkin-go v0.1.6"
	"github.com/pierrec/lz4 v2.0.5"
	"github.com/pkg/errors v0.8.0"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/prometheus/client_golang v0.9.3"
	"github.com/prometheus/client_model 5672610"
	"github.com/prometheus/common v0.2.0"
	"github.com/prometheus/procfs bf6a532"
	"github.com/rcrowley/go-metrics 3113b84"
	"github.com/sirupsen/logrus v1.2.0"
	"github.com/stretchr/objx v0.2.0"
	"github.com/stretchr/testify v1.3.0"
	"github.com/valyala/bytebufferpool v1.0.0"
	"github.com/valyala/fasttemplate v1.0.1"
	"github.com/ymomoi/goval-parser 0a0be1d"
	"go.opencensus.io v0.20.1 github.com/census-instrumentation/opencensus-go"
	"golang.org/x/sync e225da7 github.com/golang/sync"
	"google.golang.org/api v0.3.1 github.com/googleapis/google-api-go-client"
	"google.golang.org/appengine v1.4.0 github.com/golang/appengine"
	"google.golang.org/genproto 64821d5 github.com/googleapis/go-genproto"
	"google.golang.org/grpc v1.19.0 github.com/grpc/grpc-go"
	"gopkg.in/alecthomas/kingpin.v2 v2.2.6 github.com/alecthomas/kingpin"
	"gopkg.in/check.v1 788fd78 github.com/go-check/check"
	"gopkg.in/fsnotify.v1 v1.4.7 github.com/fsnotify/fsnotify"
	"gopkg.in/tomb.v1 dd63297 github.com/go-tomb/tomb"
	"gopkg.in/yaml.v2 v2.2.2 github.com/go-yaml/yaml"
	"honnef.co/go/tools 3f1c825 github.com/dominikh/go-tools"
)

inherit golang-vcs-snapshot user

DESCRIPTION="Build a local copy of OVAL. Server mode for easy querying"
HOMEPAGE="https://vuls.io/ https://github.com/kotakanbe/goval-dictionary"

SRC_URI="https://github.com/kotakanbe/goval-dictionary/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
IUSE="policykit"
SLOT=0

RDEPEND="policykit? ( sys-auth/polkit )"
DEPEND="
	dev-go/go-sqlite3:=
	dev-go/go-sys:=
	dev-go/go-text:=
	dev-go/go-oauth2:=
	dev-go/go-crypto:=
	dev-go/go-tools:=
	>=dev-lang/go-1.12"

pkg_setup() {
	if use policykit; then
		enewgroup vuls
		enewuser vuls -1 -1 "/var/lib/vuls" vuls
	fi
}

src_prepare() {
	cp "${FILESDIR}"/goval-dictionary.initd "${T}" || die

	if ! use policykit; then
		sed -e "s/^USER=\"vuls\"/USER=\"root\"/" \
			-e "s/^GROUP=\"vuls\"/GROUP=\"root\"/" \
			-i "${T}"/goval-dictionary.initd || die
	fi

	default
}

src_compile() {
	# You may get some errors using distcc
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go build -v -work -x -ldflags="-X main.version=${PV} -s -w" ./... "${EGO_PN}" || die
}

src_install() {
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
		GOCACHE="${T}/go-cache" \
		go install -v -work -x -ldflags="-X main.version=${PV} -s -w" ./... "${EGO_PN}" || die

	rm -rf "${S}/src/${EGO_PN}/vendor" || die
	golang_install_pkgs

	exeinto "$(get_golibdir_gopath)"/bin
	doexe bin/${PN}

	newinitd "${T}"/goval-dictionary.initd goval-dictionary
	newconfd "${FILESDIR}"/goval-dictionary.confd goval-dictionary

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
