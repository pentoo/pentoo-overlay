# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils linux-info

DESCRIPTION="A userspace tool to create ext4 encrypted directories"
HOMEPAGE="https://github.com/gdelugre/ext4-crypt"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/gdelugre/ext4-crypt"
else
	# snapshot: 20170216
	HASH_COMMIT="faa14f0176af814de91d1fadd208eb2795ddb19c"

	SRC_URI="https://github.com/gdelugre/ext4-crypt/archive/${HASH_COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~x86"
	S="${WORKDIR}/${PN}-${HASH_COMMIT}"
fi

LICENSE="MIT"
SLOT="0"

DEPEND="
	dev-libs/libsodium:0=
	sys-apps/keyutils:="

RDEPEND="${DEPEND}"

pkg_setup() {
	local CONFIG_CHECK="~EXT4_ENCRYPTION ~EXT4_FS_ENCRYPTION ~EXT4_FS_SECURITY"
	check_extra_config
}

src_prepare() {
	# FIX: QA Notice: Pre-stripped files found
	sed -e "s/set(CMAKE_EXE_LINKER_FLAGS \"-s\")//" \
		-i CMakeLists.txt || die "sed failed!"

	cmake-utils_src_prepare
}

pkg_postinst() {
	ewarn "\nYou also need to do before use it:"
	ewarn "    tune2fs -O encrypt <blockdevice>\n"
}
