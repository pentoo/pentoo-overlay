# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Description: kernel-builder.eclass is an extention of kernel-2.eclass to include the ability to
#	actually build the kernel during merge.
#
# WARNING: Please don't inherit kernel-2 or mount-boot, all of that is already handled
#
# Maintainer: Zero_Chaos <zerochaos@gentoo.org>

inherit kernel-2 mount-boot

EXPORT_FUNCTIONS pkg_setup src_unpack src_compile src_test src_install pkg_preinst pkg_postinst pkg_prerm pkg_postrm

IUSE="dracut genkernel make"

REQUIRED_USE="^^ ( dracut genkernel make )"

DEPEND="dracut? ( sys-kernel/dracut )
	genkernel? ( sys-kernel/genkernel )"

GENKERNEL_OPTS="--kerneldir="${S}" --logfile=/dev/null --no-symlink --no-mountboot --bootdir="${ED}"/boot --module-prefix="${ED}" --tempdir="${T}" \
		--no-save-config --makeopts="${MAKEOPTS}" --bootloader=none"

kernel-builder_pkg_setup() {
	kernel-2_pkg_setup
}

kernel-builder_src_unpack() {
	kernel-2_src_unpack
}

kernel-builder_src_compile() {
	kernel-2_src_compile
	if use dracut; then
		echo "make dracut compile the kernel"
	fi
	if use genkernel; then
		dodir /boot
		dodir /lib/modules
		#build out of tree with --kernel-outputdir=
		genkernel all "${GENKERNEL_OPTS}"
		#--install from src_install?
	fi
	if use make; then
		echo "make the kernel compile with make"
	fi
}

kernel-builder_src_test() {
	kernel-2_src_test
}

kernel-builder_src_install() {
	kernel-2_src_install
}

kernel-builder_pkg_preinst() {
	kernel-2_pkg_preinst
	mount-boot_pkg_preinst
}

kernel-builder_pkg_postinst() {
	kernel-2_pkg_postinst
	mount-boot_pkg_postinst
}

kernel-builder_pkg_prerm() {
	mount-boot_pkg_prerm
}

kernel-builder_pkg_postrm() {
	kernel-2_pkg_postrm
	mount-boot_pkg_postrm
}
