# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8


DESCRIPTION="Engine used by jnitrace to intercept JNI API calls."
HOMEPAGE="https://github.com/chame1eon/jnitrace-engine"
HASH_COMMIT="1d1233c4c9f2bf197b94406dd4fa64a7adadb717"
SRC_URI="https://github.com/chame1eon/jnitrace-engine/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz
	https://dev.pentoo.ch/~blshkv/distfiles/${P}-node_modules.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="net-libs/nodejs[npm]"
RDEPEND="net-libs/nodejs"

S="${WORKDIR}/${PN}-${HASH_COMMIT}"

NPM_FLAGS=(
	--audit false
	--color false
	--foreground-scripts
	--global
	--offline
	--progress false
	--save false
	--verbose
)

src_compile() {
	npm "${NPM_FLAGS[@]}" pack || die
}

#FIXME: where jnitrace can find it?
#src_install() {
#	npm "${NPM_FLAGS[@]}" \
#		--prefix "${ED}"/usr \
#		install \
#		jnitrace-engine-${PV}.tgz || die
#}
