# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

DESCRIPTION="NRC7292 Software Package for Host mode"
HOMEPAGE="https://newracom.com/products"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	#EGIT_REPO_URI="https://github.com/Gateworks/nrc7292.git"
	#S="${WORKDIR}/${P}/package/host/nrc_driver/source/nrc_driver/nrc"
	EGIT_REPO_URI="https://github.com/newracom/nrc7292_sw_pkg.git"
	#EGIT_REPO_URI="https://github.com/teledatics/nrc7292_sw_pkg.git"
	S="${WORKDIR}/${P}/package/src/nrc"
else
	SRC_URI="https://github.com/newracom/nrc7292_sw_pkg/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	#KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/nrc7292_sw_pkg-${PV}/package/src/nrc"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="kernel_linux"

DEPEND=""

# compile against selected (not running) target
pkg_setup() {
	if use kernel_linux; then
		linux-mod-r1_pkg_setup
	else
		die "Could not determine proper ${PN} package"
	fi
}

src_prepare() {
	sed -i 's#-Werror#-Wno-error=incompatible-pointer-types#' Makefile || die
	# prebuilt things we do not want
	rm ../../evk/binary/nrc.ko || die
	rm ../../evk/sw_pkg/nrc_pkg/sw/driver/nrc.ko || die
	rm ../../evk/sw_pkg/nrc_pkg/script/cli_app || die
	# things we do not need
	rm -r ../../evk/sw_pkg/nrc_pkg/script/sniffer || die
	default
}

src_compile() {
	local modlist=( nrc=misc )
	local modargs=( KVER="${KV_FULL}" KSRC="${KERNEL_DIR}" KDIR="${KERNEL_DIR}" )
	emake clean
	linux-mod-r1_src_compile
	emake -C ../cli_app
}
src_install() {
	insinto  /lib/firmware
	doins ../../evk/sw_pkg/nrc_pkg/sw/firmware/nrc7292_bd.dat
	newins ../../evk/sw_pkg/nrc_pkg/sw/firmware/nrc7292_cspi.bin uni_s1g.bin
	rm -r ../../evk/sw_pkg/nrc_pkg/sw/firmware || die

	insinto /opt/nrc_pkg
	doins -r ../../evk/sw_pkg/nrc_pkg/*

	linux-mod-r1_src_install
	insinto /opt/nrc_pkg/sw/driver
	doins nrc.ko

	exeinto /opt/nrc_pkg/script
	newexe ../cli_app/cli_app cli_app
	#sed -i '#sudo /opt/nrc_pkg/sw/firmware/copy#d' "${ED}/opt/nrc_pkg/script/start.py" || die
	sed -i 's#home/pi#opt#' "${ED}/opt/nrc_pkg/script/start.py" || die
	sed -i 's#wlan1#wlan2#g' "${ED}/opt/nrc_pkg/script/start.py" || die
	sed -i 's#wlan0#wlan1#g' "${ED}/opt/nrc_pkg/script/start.py" || die
	sed -i 's#home/pi#opt#' "${ED}/opt/nrc_pkg/script/stop.py" || die
	sed -i 's#wlan0#wlan1#g' "${ED}/opt/nrc_pkg/script/stop.py" || die
	sed -i 's#home/pi#opt#' "${ED}/opt/nrc_pkg/script/run_recovery.py" || die
	sed -i 's#wlan0#wlan1#g' "${ED}/opt/nrc_pkg/script/run_recovery.py" || die
	fperms +x "/opt/nrc_pkg/script/start.py" || die
	fperms +x "/opt/nrc_pkg/script/stop.py" || die
	fperms +x "/opt/nrc_pkg/script/mesh.py" || die
	fperms +x "/opt/nrc_pkg/script/mesh_add_peer.py" || die
	fperms +x "/opt/nrc_pkg/script/run_recovery.py" || die
	fperms +x "/opt/nrc_pkg/script/ps_resume.sh" || die
	fperms +x "/opt/nrc_pkg/script/ps_suspend.sh" || die
}
