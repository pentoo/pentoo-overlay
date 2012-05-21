# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/nvidia-drivers/nvidia-drivers-295.49.ebuild,v 1.3 2012/05/16 15:22:33 aballier Exp $

EAPI="2"

inherit eutils unpacker multilib portability versionator linux-mod flag-o-matic nvidia-driver

X86_NV_PACKAGE="NVIDIA-Linux-x86-${PV}"
AMD64_NV_PACKAGE="NVIDIA-Linux-x86_64-${PV}"
X86_FBSD_NV_PACKAGE="NVIDIA-FreeBSD-x86-${PV}"
AMD64_FBSD_NV_PACKAGE="NVIDIA-FreeBSD-x86_64-${PV}"

DESCRIPTION="NVIDIA X11 driver and GLX libraries"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="x86? ( http://us.download.nvidia.com/XFree86/Linux-x86/${PV}/${X86_NV_PACKAGE}.run )
	 amd64? ( http://us.download.nvidia.com/XFree86/Linux-x86_64/${PV}/${AMD64_NV_PACKAGE}.run )
	 amd64-fbsd? ( http://us.download.nvidia.com/XFree86/FreeBSD-x86_64/${PV}/${AMD64_FBSD_NV_PACKAGE}.tar.gz )
	 x86-fbsd? ( http://us.download.nvidia.com/XFree86/FreeBSD-x86/${PV}/${X86_FBSD_NV_PACKAGE}.tar.gz )"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="acpi custom-cflags multilib kernel_FreeBSD kernel_linux +tools"
RESTRICT="strip"
EMULTILIB_PKG="true"

COMMON="<x11-base/xorg-server-1.12.99
	kernel_linux? ( >=sys-libs/glibc-2.6.1 )
	multilib? ( app-emulation/emul-linux-x86-xlibs )
	>=app-admin/eselect-opengl-1.0.9
	app-admin/eselect-opencl"
DEPEND="${COMMON}
	kernel_linux? ( virtual/linux-sources )"
RDEPEND="${COMMON}
	x11-libs/libXvMC
	acpi? ( sys-power/acpid )"
PDEPEND=">=x11-libs/libvdpau-0.3-r1"

QA_TEXTRELS_x86="
	usr/lib/OpenCL/vendors/nvidia/libOpenCL.so.1.0.0
	usr/lib/libXvMCNVIDIA.so.${PV}
	usr/lib/libcuda.so.${PV}
	usr/lib/libnvcuvid.so.${PV}
	usr/lib/libnvidia-cfg.so.${PV}
	usr/lib/libnvidia-compiler.so.${PV}
	usr/lib/libnvidia-glcore.so.${PV}
	usr/lib/libnvidia-ml.so.${PV}
	usr/lib/libvdpau_nvidia.so.${PV}
	usr/lib/opengl/nvidia/extensions/libglx.so.${PV}
	usr/lib/opengl/nvidia/lib/libGL.so.${PV}
	usr/lib/opengl/nvidia/lib/libnvidia-tls.so.${PV}
	usr/lib/xorg/modules/drivers/nvidia_drv.so"

QA_TEXTRELS_x86_fbsd="boot/modules/nvidia.ko
	usr/lib/opengl/nvidia/lib/libGL.so.1
	usr/lib/libnvidia-glcore.so.1
	usr/lib/libvdpau_nvidia.so.1
	usr/lib/libnvidia-cfg.so.1
	usr/lib/opengl/nvidia/extensions/libglx.so.1
	usr/lib/xorg/modules/drivers/nvidia_drv.so"

QA_TEXTRELS_amd64="usr/lib32/opengl/nvidia/lib/libnvidia-tls.so.${PV}
	usr/lib32/libnvidia-glcore.so.${PV}
	usr/lib32/libvdpau_nvidia.so.${PV}
	usr/lib32/opengl/nvidia/lib/libGL.so.${PV}
	usr/lib32/libcuda.so.${PV}
	usr/lib32/OpenCL/vendors/nvidia/libOpenCL.so.1.0.0
	usr/lib32/libnvidia-compiler.so.${PV}"

QA_EXECSTACK_x86="usr/lib/opengl/nvidia/lib/libGL.so.${PV}
	usr/lib/libnvidia-glcore.so.${PV}
	usr/lib/opengl/nvidia/extensions/libglx.so.${PV}
	usr/lib64/libXvMCNVIDIA.so.${PV}
	usr/lib/libXvMCNVIDIA.a:NVXVMC.o
	usr/lib/libvdpau_nvidia.so.${PV}
	usr/lib/libnvidia-compiler.so.${PV}
	usr/lib/libcuda.so.${PV}
	usr/lib/OpenCL/vendors/nvidia/libOpenCL.so.1.0.0"

QA_EXECSTACK_amd64="usr/lib32/libnvidia-glcore.so.${PV}
	usr/lib32/opengl/nvidia/lib/libGL.so.${PV}
	usr/lib32/opengl/nvidia/lib/libnvidia-tls.so.${PV}
	usr/lib32/libvdpau_nvidia.so.${PV}
	usr/lib32/libcuda.so.${PV}
	usr/lib32/OpenCL/vendors/nvidia/libOpenCL.so.1.0.0
	usr/lib32/libnvidia-compiler.so.${PV}
	usr/lib64/libXvMCNVIDIA.a:NVXVMC.o
	usr/lib64/libnvidia-cfg.so.${PV}
	usr/lib64/libnvidia-ml.so.${PV}
	usr/lib64/libvdpau_nvidia.so.${PV}
	usr/lib64/opengl/nvidia/lib/libnvidia-tls.so.${PV}
	usr/lib64/opengl/nvidia/lib/libGL.so.${PV}
	usr/lib64/libnvidia-glcore.so.${PV}
	usr/lib64/opengl/nvidia/extensions/libglx.so.${PV}
	usr/lib64/libXvMCNVIDIA.so.${PV}
	usr/lib64/libcuda.so.${PV}
	usr/lib64/OpenCL/vendors/nvidia/libOpenCL.so.1.0.0
	usr/lib64/libnvidia-compiler.so.${PV}
	usr/lib64/xorg/modules/drivers/nvidia_drv.so
	opt/bin/nvidia-smi
	opt/bin/nvidia-xconfig
	opt/bin/nvidia-debugdump
	opt/bin/nvidia-settings"

QA_WX_LOAD_x86="usr/lib/libnvidia-glcore.so.${PV}
	usr/lib/opengl/nvidia/lib/libGL.so.${PV}
	usr/lib/opengl/nvidia/extensions/libglx.so.${PV}
	usr/lib/libXvMCNVIDIA.a
	usr/lib64/libXvMCNVIDIA.so.${PV}"

QA_WX_LOAD_amd64="usr/lib32/opengl/nvidia/lib/libGL.so.${PV}
	usr/lib32/libnvidia-glcore.so.${PV}
	usr/lib64/opengl/nvidia/lib/libGL.so.${PV}
	usr/lib64/libnvidia-glcore.so.${PV}
	usr/lib64/opengl/nvidia/extensions/libglx.so.${PV}
	usr/lib64/libXvMCNVIDIA.so.${PV}"

QA_SONAME_x86="usr/lib/libnvidia-compiler.so.${PV}"

QA_SONAME_amd64="usr/lib64/libnvidia-compiler.so.${PV}
	usr/lib32/libnvidia-compiler.so.${PV}"

QA_DT_HASH_amd64="usr/lib32/libcuda.so.${PV}
	usr/lib32/opengl/nvidia/lib/libGL.so.${PV}
	usr/lib32/libnvidia-glcore.so.${PV}
	usr/lib32/opengl/nvidia/lib/libnvidia-tls.so.${PV}
	usr/lib32/libvdpau_nvidia.so.${PV}
	usr/lib32/OpenCL/vendors/nvidia/libOpenCL.so.1.0.0
	usr/lib32/libnvidia-compiler.so.${PV}
	usr/lib64/libXvMCNVIDIA.so.${PV}
	usr/lib64/libcuda.so.${PV}
	usr/lib64/libnvidia-cfg.so.${PV}
	usr/lib64/libnvidia-glcore.so.${PV}
	usr/lib64/libnvidia-ml.so.${PV}
	usr/lib64/opengl/nvidia/lib/libGL.so.${PV}
	usr/lib64/opengl/nvidia/lib/libnvidia-tls.so.${PV}
	usr/lib64/opengl/nvidia/extensions/libglx.so.${PV}
	usr/lib64/xorg/modules/drivers/nvidia_drv.so
	usr/lib64/libvdpau_nvidia.so.${PV}
	usr/lib64/OpenCL/vendors/nvidia/libOpenCL.so.1.0.0
	usr/lib64/libnvidia-compiler.so.${PV}
	usr/lib64/libnvcuvid.so.${PV}
	opt/bin/nvidia-smi
	opt/bin/nvidia-xconfig
	opt/bin/nvidia-debugdump
	opt/bin/nvidia-settings"

QA_DT_HASH_x86="usr/lib/libcuda.so.${PV}
	usr/lib/libnvidia-cfg.so.${PV}
	usr/lib/libnvidia-glcore.so.${PV}
	usr/lib/libnvidia-ml.so.${PV}
	usr/lib/opengl/nvidia/lib/libGL.so.${PV}
	usr/lib/opengl/nvidia/lib/libnvidia-tls.so.${PV}
	usr/lib/opengl/nvidia/extensions/libglx.so.${PV}
	usr/lib/xorg/modules/drivers/nvidia_drv.so
	usr/lib/libXvMCNVIDIA.so.${PV}
	usr/lib/libvdpau_nvidia.so.${PV}
	usr/lib/OpenCL/vendors/nvidia/libOpenCL.so.1.0.0
	usr/lib/libnvidia-compiler.so.${PV}
	usr/lib/libnvcuvid.so.${PV}
	opt/bin/nvidia-smi
	opt/bin/nvidia-xconfig
	opt/bin/nvidia-debugdump
	opt/bin/nvidia-settings"

S=${WORKDIR}/

mtrr_check() {
	ebegin "Checking for MTRR support"
	linux_chkconfig_present MTRR
	eend $?

	if [[ $? -ne 0 ]] ; then
		eerror "Please enable MTRR support in your kernel config, found at:"
		eerror
		eerror "  Processor type and features"
		eerror "    [*] MTRR (Memory Type Range Register) support"
		eerror
		eerror "and recompile your kernel ..."
		die "MTRR support not detected!"
	fi
}

lockdep_check() {
	if linux_chkconfig_present LOCKDEP; then
		eerror "You've enabled LOCKDEP -- lock tracking -- in the kernel."
		eerror "Unfortunately, this option exports the symbol "
		eerror "'lockdep_init_map' as GPL-only which will prevent "
		eerror "${P} from compiling."
		eerror "Please make sure the following options have been unset:"
		eerror
		eerror "    Kernel hacking  --->"
		eerror "        [ ] Lock debugging: detect incorrect freeing of live locks"
		eerror "        [ ] Lock debugging: prove locking correctness"
		eerror "        [ ] Lock usage statistics"
		eerror "in 'menuconfig'"
		die "LOCKDEP enabled"
	fi
}

pkg_setup() {
	# try to turn off distcc and ccache for people that have a problem with it
	export DISTCC_DISABLE=1
	export CCACHE_DISABLE=1

	if use amd64 && has_multilib_profile && [ "${DEFAULT_ABI}" != "amd64" ]; then
		eerror "This ebuild doesn't currently support changing your default abi."
		die "Unexpected \${DEFAULT_ABI} = ${DEFAULT_ABI}"
	fi

	if use kernel_linux; then
		linux-mod_pkg_setup
		MODULE_NAMES="nvidia(video:${S}/kernel)"
		BUILD_PARAMS="IGNORE_CC_MISMATCH=yes V=1 SYSSRC=${KV_DIR} \
		SYSOUT=${KV_OUT_DIR} CC=$(tc-getBUILD_CC)"
		# linux-mod_src_compile calls set_arch_to_kernel, which
		# sets the ARCH to x86 but NVIDIA's wrapping Makefile
		# expects x86_64 or i386 and then converts it to x86
		# later on in the build process
		BUILD_FIXES="ARCH=$(uname -m | sed -e 's/i.86/i386/')"
		mtrr_check
		lockdep_check
	fi

	# On BSD userland it wants real make command
	use userland_BSD && MAKE="$(get_bmake)"

	export _POSIX2_VERSION="199209"

	# Since Nvidia ships 3 different series of drivers, we need to give the user
	# some kind of guidance as to what version they should install. This tries
	# to point the user in the right direction but can't be perfect. check
	# nvidia-driver.eclass
	nvidia-driver-check-warning

	# set variables to where files are in the package structure
	if use kernel_FreeBSD; then
		use x86-fbsd   && S="${WORKDIR}/${X86_FBSD_NV_PACKAGE}"
		use amd64-fbsd && S="${WORKDIR}/${AMD64_FBSD_NV_PACKAGE}"
		NV_DOC="${S}/doc"
		NV_EXEC="${S}/obj"
		NV_LIB="${S}/obj"
		NV_SRC="${S}/src"
		NV_MAN="${S}/x11/man"
		NV_X11="${S}/obj"
		NV_X11_DRV="${NV_X11}"
		NV_X11_EXT="${NV_X11}"
		NV_SOVER=1
	elif use kernel_linux; then
		NV_DOC="${S}"
		NV_EXEC="${S}"
		NV_LIB="${S}"
		NV_SRC="${S}/kernel"
		NV_MAN="${S}"
		NV_X11="${S}"
		NV_X11_DRV="${NV_X11}"
		NV_X11_EXT="${NV_X11}"
		NV_SOVER=${PV}
	else
		die "Could not determine proper NVIDIA package"
	fi
}

src_unpack() {
	if use kernel_linux && kernel_is lt 2 6 7; then
		echo
		ewarn "Your kernel version is ${KV_MAJOR}.${KV_MINOR}.${KV_PATCH}"
		ewarn "This is not officially supported for ${P}. It is likely you"
		ewarn "will not be able to compile or use the kernel module."
		ewarn "It is recommended that you upgrade your kernel to a version >= 2.6.7"
		echo
		ewarn "DO NOT file bug reports for kernel versions less than 2.6.7 as they will be ignored."
	fi

	if ! use kernel_FreeBSD; then
		cd "${S}"
		unpack_makeself
	else
		unpack ${A}
	fi
}

src_prepare() {
	# Please add a brief description for every added patch
	use kernel_FreeBSD && cd doc

	if use kernel_linux; then
		# Quiet down warnings the user does not need to see
		sed -i \
			-e 's:-Wsign-compare::g' \
			"${NV_SRC}"/Makefile.kbuild

		# Fix building with Linux 3.3.x wrt #408841
		sed -i \
			-e '/CFLAGS="$CFLAGS/s:-I$SOURCES/arch/x86/include:& -I$OUTPUT/arch/x86/include/generated:' \
			kernel/conftest.sh || die

		# If you set this then it's your own fault when stuff breaks :)
		use custom-cflags && sed -i "s:-O:${CFLAGS}:" "${NV_SRC}"/Makefile.*

		# If greater than 2.6.5 use M= instead of SUBDIR=
		convert_to_m "${NV_SRC}"/Makefile.kbuild
	fi
	cat <<- EOF > "${S}"/nvidia.icd
		/usr/$(get_libdir)/libcuda.so
	EOF
}

src_compile() {
	# This is already the default on Linux, as there's no toplevel Makefile, but
	# on FreeBSD there's one and triggers the kernel module build, as we install
	# it by itself, pass this.

	cd "${NV_SRC}"
	if use kernel_FreeBSD; then
		MAKE="$(get_bmake)" CFLAGS="-Wno-sign-compare" emake CC="$(tc-getCC)" \
			LD="$(tc-getLD)" LDFLAGS="$(raw-ldflags)" || die
	elif use kernel_linux; then
		linux-mod_src_compile
	fi
}

src_install() {
	if use kernel_linux; then
		linux-mod_src_install

		VIDEOGROUP="$(egetent group video | cut -d ':' -f 3)"
		if [ -z "$VIDEOGROUP" ]; then
			eerror "Failed to determine the video group gid."
			die "Failed to determine the video group gid."
		fi

		# Add the aliases
		[ -f "${FILESDIR}/nvidia-169.07" ] || die "nvidia missing in FILESDIR"
		sed -e 's:PACKAGE:'${PF}':g' \
			-e 's:VIDEOGID:'${VIDEOGROUP}':' "${FILESDIR}"/nvidia-169.07 > \
			"${WORKDIR}"/nvidia
		insinto /etc/modprobe.d
		newins "${WORKDIR}"/nvidia nvidia.conf || die

		# Ensures that our device nodes are created when not using X
		exeinto /$(get_libdir)/udev
		doexe "${FILESDIR}"/nvidia-udev.sh

		insinto /$(get_libdir)/udev/rules.d
		newins "${FILESDIR}"/nvidia.udev-rule 99-nvidia.rules
	elif use kernel_FreeBSD; then
		if use x86-fbsd; then
			insinto /boot/modules
			doins "${S}/src/nvidia.kld" || die
		fi

		exeinto /boot/modules
		doexe "${S}/src/nvidia.ko" || die
	fi

	# NVIDIA kernel <-> userspace driver config lib
	dolib.so ${NV_LIB}/libnvidia-cfg.so.${NV_SOVER} || \
		die "failed to install libnvidia-cfg"
	dosym libnvidia-cfg.so.${NV_SOVER} \
		/usr/$(get_libdir)/libnvidia-cfg.so.1 || \
		die "failed to create libnvidia-cfg.so symlink"
	dosym libnvidia-cfg.so.1 \
		/usr/$(get_libdir)/libnvidia-cfg.so || \
		die "failed to create libnvidia-cfg.so symlink"

	if use kernel_linux; then
		# NVIDIA monitoring library
		dolib.so ${NV_LIB}/libnvidia-ml.so.${NV_SOVER} || \
			die "failed to install libnvidia-ml"
		dosym libnvidia-ml.so.${NV_SOVER} \
			/usr/$(get_libdir)/libnvidia-ml.so.1 || \
			die "failed to create libnvidia-ml.so symlink"
		dosym libnvidia-ml.so.1 \
			/usr/$(get_libdir)/libnvidia-ml.so || \
			die "failed to create libnvidia-ml.so symlink"

		# NVIDIA video decode <-> CUDA
		dolib.so ${NV_LIB}/libnvcuvid.so.${NV_SOVER} || \
			die "failed to install libnvcuvid.so"
		dosym libnvcuvid.so.${NV_SOVER} \
			/usr/$(get_libdir)/libnvcuvid.so.1 || \
			die "failed to create libnvcuvid.so symlink"
		dosym libnvcuvid.so.1 \
			/usr/$(get_libdir)/libnvcuvid.so || \
			die "failed to create libnvcuvid.so symlink"
	fi

	# Xorg DDX driver
	insinto /usr/$(get_libdir)/xorg/modules/drivers
	doins ${NV_X11_DRV}/nvidia_drv.so || die "failed to install nvidia_drv.so"

	# Xorg GLX driver
	insinto /usr/$(get_libdir)/opengl/nvidia/extensions
	doins ${NV_X11_EXT}/libglx.so.${NV_SOVER} || \
		die "failed to install libglx.so"
	dosym libglx.so.${NV_SOVER} \
		/usr/$(get_libdir)/opengl/nvidia/extensions/libglx.so || \
		die "failed to create libglx.so symlink"

	# XvMC driver
	dolib.a ${NV_X11}/libXvMCNVIDIA.a || \
		die "failed to install libXvMCNVIDIA.so"
	dolib.so ${NV_X11}/libXvMCNVIDIA.so.${NV_SOVER} || \
		die "failed to install libXvMCNVIDIA.so"
	dosym libXvMCNVIDIA.so.${NV_SOVER} \
		/usr/$(get_libdir)/libXvMCNVIDIA.so.1 || \
		die "failed to create libXvMCNVIDIA.so symlink"
	dosym libXvMCNVIDIA.so.1 /usr/$(get_libdir)/libXvMCNVIDIA.so || \
		die "failed to create libXvMCNVIDIA.so symlink"
	dosym libXvMCNVIDIA.so.${NV_SOVER} \
		/usr/$(get_libdir)/libXvMCNVIDIA_dynamic.so.1 || \
		die "failed to create libXvMCNVIDIA_dynamic.so symlink"

	# OpenCL ICD for NVIDIA
	if use kernel_linux; then
		insinto /etc/OpenCL/vendors
		doins nvidia.icd
	fi

	# Documentation
	dohtml ${NV_DOC}/html/*
	if use kernel_FreeBSD; then
		dodoc "${NV_DOC}/README"
		doman "${NV_MAN}/nvidia-xconfig.1"
		doman "${NV_MAN}/nvidia-settings.1"
	else
		# Docs
		newdoc "${NV_DOC}/README.txt" README
		dodoc "${NV_DOC}/NVIDIA_Changelog"
		doman "${NV_MAN}/nvidia-smi.1.gz"
		doman "${NV_MAN}/nvidia-xconfig.1.gz"
		doman "${NV_MAN}/nvidia-settings.1.gz"
	fi

	# Helper Apps
	exeinto /opt/bin/
	doexe ${NV_EXEC}/nvidia-xconfig || die
	use kernel_linux && { doexe ${NV_EXEC}/nvidia-debugdump || die ; }
	if use tools; then
		doexe ${NV_EXEC}/nvidia-settings || die
	fi
	doexe ${NV_EXEC}/nvidia-bug-report.sh || die
	if use kernel_linux; then
		doexe ${NV_EXEC}/nvidia-smi || die
	fi

	# Desktop entries for nvidia-settings
	if use tools && use kernel_linux ; then
		sed -e 's:__UTILS_PATH__:/opt/bin:' \
			-e 's:__PIXMAP_PATH__:/usr/share/pixmaps:' \
			-i "${NV_EXEC}/nvidia-settings.desktop"
		newmenu ${NV_EXEC}/nvidia-settings.desktop nvidia-settings-opt.desktop
	fi

	doicon ${NV_EXEC}/nvidia-settings.png

	if has_multilib_profile && use multilib ; then
		local OABI=${ABI}
		for ABI in $(get_install_abis) ; do
			src_install-libs
		done
		ABI=${OABI}
		unset OABI
	else
		src_install-libs
	fi

	is_final_abi || die "failed to iterate through all ABIs"
}

# Install nvidia library:
# the first parameter is the place where to install it
# the second parameter is the base name of the library
# the third parameter is the provided soversion
donvidia() {
	dodir $1
	exeinto $1

	libname=$(basename $2)

	doexe $2.$3 || die "failed to install $2"
	dosym ${libname}.$3 $1/${libname} || die "failed to symlink $2"
	[[ $3 != "1" ]] && dosym ${libname}.$3 $1/${libname}.1
}

src_install-libs() {
	local inslibdir=$(get_libdir)
	local NV_ROOT="/usr/${inslibdir}/opengl/nvidia"
	local CL_ROOT=/usr/${inslibdir}/OpenCL/vendors/nvidia
	local libdir= sover=

	if use kernel_linux; then
		if has_multilib_profile && [[ ${ABI} == "x86" ]] ; then
			libdir=32
		else
			libdir=.
		fi
		sover=${PV}
	else
		libdir=obj
		# on FreeBSD it has just .1 suffix
		sover=1
	fi

	# The GLX libraries
	donvidia ${NV_ROOT}/lib ${libdir}/libGL.so ${sover}
	donvidia /usr/${inslibdir} ${libdir}/libnvidia-glcore.so ${sover}
	if use kernel_FreeBSD; then
		donvidia ${NV_ROOT}/lib ${libdir}/libnvidia-tls.so ${sover}
	else
		donvidia ${NV_ROOT}/lib ${libdir}/tls/libnvidia-tls.so ${sover}
	fi

	# VDPAU
	donvidia /usr/${inslibdir} ${libdir}/libvdpau_nvidia.so ${sover}

	# CUDA & OpenCL
	if use kernel_linux; then
		donvidia /usr/${inslibdir} ${libdir}/libcuda.so ${sover}
		donvidia /usr/${inslibdir} ${libdir}/libnvidia-compiler.so ${sover}
		donvidia ${CL_ROOT} ${libdir}/libOpenCL.so 1.0.0
		#dosym libOpenCL.so.1 ${CL_ROOT}/libOpenCL.so
	fi
}

pkg_preinst() {
	use kernel_linux && linux-mod_pkg_preinst

	# Clean the dynamic libGL stuff's home to ensure
	# we dont have stale libs floating around
	if [ -d "${ROOT}"/usr/lib/opengl/nvidia ] ; then
		rm -rf "${ROOT}"/usr/lib/opengl/nvidia/*
	fi
	# Make sure we nuke the old nvidia-glx's env.d file
	if [ -e "${ROOT}"/etc/env.d/09nvidia ] ; then
		rm -f "${ROOT}"/etc/env.d/09nvidia
	fi
}

pkg_postinst() {
	use kernel_linux && linux-mod_pkg_postinst

	# Switch to the nvidia implementation
	"${ROOT}"/usr/bin/eselect opengl set --use-old nvidia
	"${ROOT}"/usr/bin/eselect opencl set --use-old nvidia

	echo
	elog "You must be in the video group to use the NVIDIA device"
	elog "For more info, read the docs at"
	elog "http://www.gentoo.org/doc/en/nvidia-guide.xml#doc_chap3_sect6"
	elog

	elog "This ebuild installs a kernel module and X driver. Both must"
	elog "match explicitly in their version. This means, if you restart"
	elog "X, you must modprobe -r nvidia before starting it back up"
	elog

	elog "To use the NVIDIA GLX, run \"eselect opengl set nvidia\""
	elog
	elog "To use the NVIDIA CUDA/OpenCL, run \"eselect opencl set nvidia\""
	elog
	elog "NVIDIA has requested that any bug reports submitted have the"
	elog "output of /opt/bin/nvidia-bug-report.sh included."
	elog
	elog "To work with compiz, you must enable the AddARGBGLXVisuals option."
	elog
	elog "If you are having resolution problems, try disabling DynamicTwinView."
	elog

	if ! use tools; then
		elog "USE=tools controls whether the nvidia-settings application"
		elog "is installed. If you would like to use it, enable that"
		elog "flag and re-emerge this ebuild. Optionally you can install"
		elog "media-video/nvidia-settings"
	fi
}

pkg_prerm() {
	"${ROOT}"/usr/bin/eselect opengl set --use-old xorg-x11
}

pkg_postrm() {
	use kernel_linux && linux-mod_pkg_postrm
	"${ROOT}"/usr/bin/eselect opengl set --use-old xorg-x11
}
