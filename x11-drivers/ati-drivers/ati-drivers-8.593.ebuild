# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/ati-drivers/ati-drivers-8.593.ebuild,v 1.1 2009/04/23 03:13:26 je_fro Exp $

IUSE="acpi debug"

inherit eutils multilib linux-mod toolchain-funcs versionator

DESCRIPTION="Ati precompiled drivers for recent chipsets"
HOMEPAGE="http://www.ati.com"
ATI_URL="https://a248.e.akamai.net/f/674/9206/0/www2.ati.com/drivers/linux/"
SRC_URI="${ATI_URL}/ati-driver-installer-9-3-x86.x86_64.run"

LICENSE="AMD GPL-2 QPL-1.0 as-is"
KEYWORDS="~amd64 ~x86"

# The portage dep is for COLON_SEPARATED support in env-update.
# The eselect dep (>=1.0.9) is for COLON_SEPARATED in eselect env update.
RDEPEND=">=x11-base/xorg-server-1.5
	!x11-apps/ati-drivers-extra
	>=app-admin/eselect-1.0.9
	app-admin/eselect-opengl
	sys-libs/libstdc++-v3
	amd64? ( app-emulation/emul-linux-x86-xlibs )
	acpi? (
		x11-apps/xauth
		sys-power/acpid
	)
	x11-libs/libXrandr
	>=sys-apps/portage-2.1.1-r1"

DEPEND="${RDEPEND}
	x11-proto/xf86miscproto
	x11-proto/xf86vidmodeproto
	x11-proto/inputproto
	!<x11-drivers/ati-drivers-8.552-r1"

EMULTILIB_PKG="true"

S="${WORKDIR}"

pkg_setup() {

	# Define module dir.
	MODULE_DIR="${S}/common/lib/modules/fglrx/build_mod"

	#check kernel and sets up KV_OBJ
	MODULE_NAMES="fglrx(video:${S}/common/lib/modules/fglrx/build_mod/2.6.x)"
	BUILD_TARGETS="kmod_build"
	linux-mod_pkg_setup
	BUILD_PARAMS="GCC_VER_MAJ=$(gcc-major-version) KVER=${KV_FULL} KDIR=${KV_DIR}"

	if kernel_is ge 2 6 29; then
		ewarn "${P} is not really compatible with 2.6.29 kernels. See bug #264021."
	fi

	if ! kernel_is 2 6; then
		eerror "Need a 2.6 kernel to compile against!"
		die "Need a 2.6 kernel to compile against!"
	fi

	if kernel_is ge 2 6 25 && linux_chkconfig_present PREEMPT_RCU; then
		die "${P} is not compatible with RCU Preemption (bug #223281), please disable it"
	fi

	if kernel_is ge 2 6 26 && ! linux_chkconfig_present UNUSED_SYMBOLS; then
			ewarn "You have to Enable unused/obsolete exported symbols in Kernel hacking section of kernel config for fglrx to load"
	fi

	if kernel_is ge 2 6 24 && ! linux_chkconfig_present PCI_LEGACY; then
		eerror "${P} requires support for pci_find_slot."
		die "${P} requires support for pci_find_slot."
	fi

	if ! linux_chkconfig_present MTRR; then
		ewarn "You don't have MTRR support enabled, the direct rendering will not work."
	fi

	if linux_chkconfig_builtin DRM; then
		ewarn "You have DRM support enabled builtin, the direct rendering will not work."
	fi

	if ! linux_chkconfig_present AGP && \
		! linux_chkconfig_present PCIEPORTBUS; then
		ewarn "You need AGP and/or PCI Express support for direct rendering to work."
	fi

	if linux_chkconfig_present PARAVIRT; then
		eerror "The current ati-drivers don't compile when having"
		eerror "paravirtualization active due to GPL symbol export"
		eerror "restrictions."
		eerror "Please disable it:"
		eerror "	CONFIG_PARAVIRT=n"
		eerror "in /usr/src/linux/.config or"
		eerror "	Processor type and features -->"
		eerror "		[ ] Paravirtualization support (EXPERIMENTAL)"
		eerror "in 'menuconfig'"
		die "CONFIG_PARAVIRT enabled"
	fi

	if ! linux_chkconfig_present MAGIC_SYSRQ; then
		eerror "You need MAGIC_SYSRQ enabled in order to build ati-drivers"
		die "CONFIG_MAGIC_SYSRQ disabled"
	fi

	# Only support xorg-server >=1.5
	BASE_DIR="${S}/x740"

	if ! linux_chkconfig_present PCI_MSI; then
		eerror "You need PCI_MSI enabled in order to build ati-drivers"
		die "CONFIG_PCI_MSI disabled"
	fi

	# This is used like $(get_libdir) for paths in ati's package.
	if use amd64 ; then
		MY_BASE_DIR="${BASE_DIR}_64a"
		PKG_LIBDIR=lib64
		ARCH_DIR="${S}/arch/x86_64"
	else
		MY_BASE_DIR="${BASE_DIR}"
		PKG_LIBDIR=lib
		ARCH_DIR="${S}/arch/x86"
	fi
}

src_unpack() {
	#Switching to a standard way to extract the files since otherwise no signature file
	#would be created
	local src="${DISTDIR}/${A}"
	sh "${src}" --extract "${S}"  2&>1 /dev/null
	cd "${S}"
	epatch "${FILESDIR}"/ati-drivers-xen.patch || die "epatch failed"
	epatch "${FILESDIR}"/fglrx-2.6.29-9.2-5.patch || die "epatch failed"

	# These are the userspace utilities that we also have source for.
	# We rebuild these later.
	rm \
		"${ARCH_DIR}"/usr/X11R6/bin/{fgl_glxgears,fglrx_xgamma} \
		"${ARCH_DIR}"/usr/X11R6/${PKG_LIBDIR}/libfglrx_gamma* \
		|| die "bin rm failed"

	if use debug; then
		# Enable debug mode in the Source Code.
		sed -i '/^#define DRM_DEBUG_CODE/s/0/1/' \
			"${MODULE_DIR}/firegl_public.c" \
			|| die "Failed to enable debug output."
	fi

	if use acpi; then
		sed -i \
			-e "s:/var/lib/xdm/authdir/authfiles/:/var/run/xauth/:" \
			-e "s:/var/lib/gdm/:/var/gdm/:" \
			"${S}/common/etc/ati/authatieventsd.sh" \
			|| die "sed failed."

		# Since "who" is in coreutils, we're using that one instead of "finger".
		sed -i -e 's:finger:who:' \
			"${S}/common/usr/share/doc/fglrx/examples/etc/acpi/ati-powermode.sh" \
			|| die "Replacing 'finger' with 'who' failed."
		# Adjust paths in the script from /usr/X11R6/bin/ to /opt/bin/ and
		# add function to detect default state.
		epatch "${FILESDIR}"/ati-powermode-opt-path-2.patch || die "Failed to epatch powermode-opt-path-2.patch"
	fi

	pushd ${MODULE_DIR} >/dev/null
	ln -s "${ARCH_DIR}"/lib/modules/fglrx/build_mod/libfglrx_ip.a.GCC$(gcc-major-version) \
		|| die "symlinking precompiled core failed"

	convert_to_m 2.6.x/Makefile || die "convert_to_m failed"

	# When built with ati's make.sh it defines a bunch of macros if
	# certain .config values are set, falling back to less reliable
	# detection methods if linux/autoconf.h is not available. We
	# simply use the linux/autoconf.h settings directly, bypassing the
	# detection script.
	sed -i -e 's/__SMP__/CONFIG_SMP/' *.c *h || die "SMP sed failed"
	sed -i -e 's/ifdef MODVERSIONS/ifdef CONFIG_MODVERSIONS/' *.c *.h \
		|| die "MODVERSIONS sed failed"
	popd >/dev/null

	mkdir extra || die "mkdir failed"
	cd extra
	unpack ./../common/usr/src/ati/fglrx_sample_source.tgz
	sed -i -e 's:include/extensions/extutil.h:X11/extensions/extutil.h:' \
		lib/fglrx_gamma/fglrx_gamma.c || die "include fixup failed"
	# Add a category.
	mv programs/fglrx_gamma/fglrx_xgamma.{man,1} || die "man mv failed"
	cd ..
}

src_compile() {
	linux-mod_src_compile

	einfo "Building fgl_glxgears"
	cd "${S}"/extra/fgl_glxgears
	# These extra libs/utils either have an Imakefile that does not
	# work very well without tweaking or a Makefile ignoring CFLAGS
	# and the like. We bypass those.

	# The -DUSE_GLU is needed to compile using nvidia headers
	# according to a comment in ati-drivers-extra-8.33.6.ebuild.
	"$(tc-getCC)" -o fgl_glxgears ${CFLAGS} ${LDFLAGS} -DUSE_GLU \
		-I"${S}"/common/usr/include fgl_glxgears.c \
		-lGL -lGLU -lX11 -lm || die "fgl_glxgears build failed"

	einfo "Building fglrx_gamma lib"
	cd "${S}"/extra/lib/fglrx_gamma
	"$(tc-getCC)" -shared -fpic -o libfglrx_gamma.so.1.0 ${CFLAGS} ${LDFLAGS} \
		-DXF86MISC -Wl,-soname,libfglrx_gamma.so.1.0 fglrx_gamma.c \
		-lXext || die "fglrx_gamma lib build failed"
	ln -s libfglrx_gamma.so.1.0 libfglrx_gamma.so || die "ln failed"
	ln -s libfglrx_gamma.so.1.0 libfglrx_gamma.so.1 || die "ln failed"

	einfo "Building fglrx_gamma util"
	cd "${S}"/extra/programs/fglrx_gamma
	"$(tc-getCC)" -o fglrx_xgamma ${CFLAGS} ${LDFLAGS} \
		-I../../../common/usr/X11R6/include -L../../lib/fglrx_gamma \
		fglrx_xgamma.c -lm -lfglrx_gamma -lX11 \
		|| die "fglrx_gamma util build failed"

}

src_install() {
	linux-mod_src_install

	# We can do two things here, and neither of them is very nice.

	# For direct rendering libGL has to be able to load one or more
	# dri modules (files ending in _dri.so, like fglrx_dri.so).
	# Gentoo's mesa looks for these files in the location specified by
	# LIBGL_DRIVERS_PATH or LIBGL_DRIVERS_DIR, then in the hardcoded
	# location /usr/$(get_libdir)/dri. Ati's libGL does the same
	# thing, but the hardcoded location is /usr/X11R6/lib/modules/dri
	# on x86 and amd64 32bit, /usr/X11R6/lib64/modules/dri on amd64
	# 64bit. So we can either put the .so files in that (unusual,
	# compared to "normal" mesa libGL) location or set
	# LIBGL_DRIVERS_PATH. We currently do the latter. See also bug
	# 101539.

	# The problem with this approach is that LIBGL_DRIVERS_PATH
	# *overrides* the default hardcoded location, it does not extend
	# it. So if ati-drivers is merged but a non-ati libGL is selected
	# and its hardcoded path does not match our LIBGL_DRIVERS_PATH
	# (because it changed in a newer mesa or because it was compiled
	# for a different set of multilib abis than we are) stuff breaks.

	# We create one file per ABI to work with "native" multilib, see
	# below.

	echo "COLON_SEPARATED=LIBGL_DRIVERS_PATH" > "${T}/03ati-colon-sep"
	doenvd "${T}/03ati-colon-sep"

	# All libraries that we have a 32 bit and 64 bit version of on
	# amd64 are installed in src_install-libs. Everything else
	# (including libraries only available in native 64bit on amd64)
	# goes in here.

	# There used to be some code here that tried to detect running
	# under a "native multilib" portage ((precursor of)
	# http://dev.gentoo.org/~kanaka/auto-multilib/). I removed that, it
	# should just work (only doing some duplicate work). --marienz
	if has_multilib_profile; then
		local OABI=${ABI}
		for ABI in $(get_install_abis); do
			src_install-libs
		done
		ABI=${OABI}
		unset OABI
	else
		src_install-libs
	fi

	# This is sorted by the order the files occur in the source tree.

	# X modules.
	exeinto /usr/$(get_libdir)/xorg/modules/drivers
	doexe "${MY_BASE_DIR}"/usr/X11R6/${PKG_LIBDIR}/modules/drivers/fglrx_drv.so
	exeinto /usr/$(get_libdir)/xorg/modules/linux
	doexe "${MY_BASE_DIR}"/usr/X11R6/${PKG_LIBDIR}/modules/linux/libfglrxdrm.so
	exeinto /usr/$(get_libdir)/xorg/modules
	doexe "${MY_BASE_DIR}"/usr/X11R6/${PKG_LIBDIR}/modules/{esut.a,glesx.so,amdxmm.so}

	# Arch-specific files.
	# (s)bin.
	into /opt
	if use acpi; then
		dosbin "${ARCH_DIR}"/usr/sbin/atieventsd
	fi
	# We cleaned out the compilable stuff in src_unpack
	dobin "${ARCH_DIR}"/usr/X11R6/bin/*

	# lib.
	exeinto /usr/$(get_libdir)
	# Everything except for the libGL.so installed in src_install-libs.
	doexe $(find "${ARCH_DIR}"/usr/X11R6/${PKG_LIBDIR} \
		-maxdepth 1 -type f -name '*.so*' -not -name 'libGL.so*')
	insinto /usr/$(get_libdir)
	doins $(find "${ARCH_DIR}"/usr/X11R6/${PKG_LIBDIR} \
		-maxdepth 1 -type f -not -name '*.so*')

	# Common files.
	# etc.
	insinto /etc/ati
	# Everything except for the authatieventsd.sh script.
	doins common/etc/ati/{logo*,control,atiogl.xml,signature,amdpcsdb.default}
	if use acpi; then
		insopts -m0755
		doins common/etc/ati/authatieventsd.sh
	fi

	# include.
	insinto /usr
	doins -r common/usr/include
	insinto /usr/include/X11/extensions
	doins common/usr/X11R6/include/X11/extensions/fglrx_gamma.h

	# Just the atigetsysteminfo.sh script.
	into /usr
	dosbin common/usr/sbin/*

	# data files for the control panel.
	insinto /usr/share
	doins -r common/usr/share/ati
	insinto /usr/share/pixmaps
	doins common/usr/share/icons/ccc_{large,small}.xpm
	make_desktop_entry amdcccle 'ATI Catalyst Control Center' \
		ccc_large System

	# doc.
	dohtml -r common/usr/share/doc/fglrx

	if use acpi; then
		doman common/usr/share/man/man8/atieventsd.8

		pushd common/usr/share/doc/fglrx/examples/etc/acpi >/dev/null

		exeinto /etc/acpi
		doexe ati-powermode.sh
		insinto /etc/acpi/events
		doins events/*

		popd >/dev/null
	fi

	# Done with the "source" tree. Install tools we rebuilt:
	dobin extra/fgl_glxgears/fgl_glxgears
	newdoc extra/fgl_glxgears/README README.fgl_glxgears

	dolib extra/lib/fglrx_gamma/*so*
	newdoc extra/lib/fglrx_gamma/README README.libfglrx_gamma

	dobin extra/programs/fglrx_gamma/fglrx_xgamma
	doman extra/programs/fglrx_gamma/fglrx_xgamma.1
	newdoc extra/programs/fglrx_gamma/README README.fglrx_gamma

	# Gentoo-specific stuff:
	if use acpi; then
		newinitd "${FILESDIR}"/atieventsd.init atieventsd \
			|| die "Failed to install atieventsd.init.d"
		echo 'ATIEVENTSDOPTS=""' > "${T}"/atieventsd.conf
		newconfd "${T}"/atieventsd.conf atieventsd
	fi
}

src_install-libs() {
	if [[ "${ABI}" == "amd64" ]]; then
		local EX_BASE_DIR="${BASE_DIR}_64a"
		local pkglibdir=lib64
		local MY_ARCH_DIR="${S}/arch/x86_64"
	else
		local EX_BASE_DIR="${BASE_DIR}"
		local pkglibdir=lib
		local MY_ARCH_DIR="${S}/arch/x86"
	fi
	einfo "ati tree '${pkglibdir}' -> '$(get_libdir)' on system"

	local ATI_ROOT=/usr/$(get_libdir)/opengl/ati
	# To make sure we do not miss a spot when these change.
	local libmajor=1 libminor=2
	local libver=${libmajor}.${libminor}

	# The GLX libraries
	# (yes, this really is "lib" even on amd64/multilib --marienz)
	exeinto ${ATI_ROOT}/lib
	doexe "${MY_ARCH_DIR}"/usr/X11R6/${pkglibdir}/libGL.so.${libver}
	dosym libGL.so.${libver} ${ATI_ROOT}/lib/libGL.so.${libmajor}
	dosym libGL.so.${libver} ${ATI_ROOT}/lib/libGL.so

	exeinto ${ATI_ROOT}/extensions
	doexe "${EX_BASE_DIR}"/usr/X11R6/${pkglibdir}/modules/extensions/*

	# DRI modules, installed into the path used by recent versions of mesa.
	exeinto /usr/$(get_libdir)/dri
	doexe "${MY_ARCH_DIR}"/usr/X11R6/${pkglibdir}/modules/dri/fglrx_dri.so

	# AMD Cal libraries
	exeinto /usr/$(get_libdir)
	doexe "${MY_ARCH_DIR}"/usr/${pkglibdir}/*.so

	# Make up a libGL.la. Ati does not provide one, but mesa does. If
	# a (libtool-based) libfoo is built with libGL.la present a
	# reference to it is put into libfoo.la, and compiling
	# (libtool-based) things that link too libfoo.la will complain if
	# libGL.la disappears. So if we do not make up a libGL.la
	# switching between mesa and ati becomes painful.
	local revision=$(printf '%d%02d%02d' $(get_version_components))
	sed -e "s:\${libmajor}:${libmajor}:g" \
		-e "s:\${libminor}:${libminor}:g" \
		-e "s:\${libdir}:$(get_libdir):g" \
		-e "s:\${revision}:${revision}:g" \
		"${FILESDIR}"/libGL.la.in > "${D}"/${ATI_ROOT}/lib/libGL.la \
		|| die "sed failed to make libGL.la"

	local envname="${T}"/04ati-dri-path
	if [[ -n ${ABI} ]]; then
		envname="${envname}-${ABI}"
	fi
	echo "LIBGL_DRIVERS_PATH=/usr/$(get_libdir)/dri" > "${envname}"
	doenvd "${envname}"
}

pkg_postinst() {
	/usr/bin/eselect opengl set --use-old ati

	elog "To switch to ATI OpenGL, run \"eselect opengl set ati\""
	elog "To change your xorg.conf you can use the bundled \"aticonfig\""
	elog
	elog "If you experience unexplained segmentation faults and kernel crashes"
	elog "with this driver and multi-threaded applications such as wine,"
	elog "set UseFastTLS in xorg.conf to either 0 or 1, but not 2."
	elog
	elog "You will have to source /etc/profile (or logout and back in) for dri"
	elog "to work, unless you previously had ati-drivers installed."

	# Workaroud screen corruption
	ewarn "If you experience screen corruption with this driver, try putting"
	ewarn '         Option "XAANoOffscreenPixmaps" "true"'
	ewarn "in the Device Section of /etc/X11/xorg.conf."

	linux-mod_pkg_postinst
}

pkg_prerm() {
	/usr/bin/eselect opengl set xorg-x11
}
