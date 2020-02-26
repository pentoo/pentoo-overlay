# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="JD-Core is a JAVA decompiler written in JAVA"
HOMEPAGE="http://jd.benow.ca/"
SRC_URI="https://github.com/java-decompiler/jd-core/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/jre"
DEPEND="${RDEPEND}
	>=virtual/jdk-1.8.0"

S="${WORKDIR}/${P}"

JAVA_SRC_DIR="src/main/java/org/jd/core/v1"

#java_prepare() {
#src_prepare() {
#java-utils-2_src_prepare
java-pkg-2_src_prepare(){
	local base_dir="target/classes/"
	[[ ! -d "${base_dir}" ]] && mkdir -p "${base_dir}META-INF"
#Main-Class: ${MAIN_CLASS}" \
	echo "Manifest-Version: 1.0
JD-Core-Version: ${PV}" \
		>> "${base_dir}META-INF/MANIFEST.MF"
	default
}
