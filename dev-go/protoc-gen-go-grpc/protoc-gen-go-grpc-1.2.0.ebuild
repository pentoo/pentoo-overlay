# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_PN="github.com/grpc/grpc-go/cmd/protoc-gen-go-grpc"

EGO_SUM=(
        "github.com/golang/protobuf v1.5.0/go.mod"
        "github.com/google/go-cmp v0.5.5"
        "github.com/google/go-cmp v0.5.5/go.mod"
        "golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543"
        "golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
        "google.golang.org/protobuf v1.26.0-rc.1/go.mod"
        "google.golang.org/protobuf v1.27.1"
        "google.golang.org/protobuf v1.27.1/go.mod"
        )
go-module_set_globals


DESCRIPTION="This tool generates Go language bindings of services in protobuf definition files for gRPC"
HOMEPAGE="https://pkg.go.dev/google.golang.org/grpc/cmd/protoc-gen-go-grpc"
SRC_URI="https://github.com/grpc/grpc-go/archive/refs/tags/cmd/protoc-gen-go-grpc/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"
LICENSE="BSD"
SLOT="0/${PVR}"
KEYWORDS="amd64 x86"
IUSE="test"
DEPEND="test? ( dev-libs/protobuf )"
RDEPEND=""
RESTRICT="!test? ( test )"

S="${WORKDIR}/grpc-go-cmd-protoc-gen-go-grpc-v${PV}/cmd/protoc-gen-go-grpc"
src_compile() {
	env GOBIN="${S}/bin" go install ./... ||
		die "compile failed"
}

src_install() {
	dobin bin/protoc-gen-go-grpc
}
