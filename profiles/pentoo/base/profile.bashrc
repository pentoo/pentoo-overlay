local CORES="$(nproc)"
if [[ "${CORES}" -eq "0" ]] ; then CORES="1" ; fi
echo ${MAKEOPTS} | grep -q -e -j || export MAKEOPTS="-j${CORES} -l${CORES}"

#bug, fails during src_install
if [[ $CATEGORY/$PN == dev-lang/ghc ]]; then export MAKEOPTS="${MAKEOPTS/--shuffle/}"; fi

#bug, fails during compile
#https://bugs.gentoo.org/904338
#https://bugs.gentoo.org/936493
if [[ $CATEGORY/$PN-${PVR} == sys-fs/e2fsprogs-1.47.1 ]]; then export MAKEOPTS="-j1"; fi

#by the time this is parsed, EMERGE_DEFAULT_OPTS are already applied, this file is too late
#echo ${EMERGE_DEFAULT_OPTS} | grep -q jobs || export EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS} --jobs=${CORES} --load-average=${CORES}"

#bug
if [[ $CATEGORY/$PN == sys-boot/os-prober ]] ; then FEATURES=${FEATURES/multilib-strict/} ; fi

#are you kidding me?
if [[ $CATEGORY/$PN == net-misc/openssh ]]; then export OPENSSH_EOL_USE_FLAGS_I_KNOW_WHAT_I_AM_DOING=yes; fi

#some packages are too big for ggdb
if [[ $CATEGORY/$PN == www-client/chromium ]]; then
  CFLAGS=${CFLAGS/-ggdb3/} CXXFLAGS=${CXXFLAGS/-ggdb3/}
  CFLAGS=${CFLAGS/-ggdb/} CXXFLAGS=${CXXFLAGS/-ggdb/}
fi
if [[ $CATEGORY/$PN == dev-lang/rust ]]; then
  CFLAGS=${CFLAGS/-ggdb3/} CXXFLAGS=${CXXFLAGS/-ggdb3/}
  CFLAGS=${CFLAGS/-ggdb/} CXXFLAGS=${CXXFLAGS/-ggdb/}
fi

#sorry, unimplemented: __builtin_clear_padding not supported for variable length aggregates
if [[ ${CATEGORY}/${PN} == app-crypt/johntheripper-jumbo ]]; then
  export CFLAGS="${CFLAGS/-ftrivial-auto-var-init=pattern/}"
fi

#some packages break on LTO and should all have bugs
if [[ ${CATEGORY}/${PN} == app-crypt/mit-krb5 ]]; then
  export CFLAGS="${CFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/numpy ]]; then
  export CFLAGS="${CFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == media-video/mplayer ]]; then
  export CFLAGS="${CFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == net-wireless/bluez ]]; then
  # Tests fail with -flto
  export CFLAGS="${CFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == sys-apps/util-linux ]]; then
  export CFLAGS="${CFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == sys-devel/binutils ]]; then
  export CFLAGS="${CFLAGS/-flto/}"
  # zero uses extra warnings to find bugs
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == www-client/chromium ]]; then
  export CFLAGS="${CFLAGS/-flto/}"
  export CXXFLAGS="${CXXFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == dev-qt/qtnetwork ]]; then
  export CXXFLAGS="${CXXFLAGS/-flto/}"
  # zero uses extra warnings to find bugs
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/kwayland ]]; then
  export CXXFLAGS="${CXXFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == media-gfx/geeqie ]]; then
  export CXXFLAGS="${CXXFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/mesa ]]; then
  export CXXFLAGS="${CXXFLAGS/-flto/}"
  # zero uses extra warnings to find bugs
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/x265 ]]; then
  export CXXFLAGS="${CXXFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == net-ftp/filezilla ]]; then
  export CXXFLAGS="${CXXFLAGS/-flto/}"
fi
# FFLAGS
if [[ ${CATEGORY}/${PN} == dev-python/scipy ]]; then
  export FFLAGS="${FFLAGS/-flto/}"
fi

#Sign kernel modules, stolen unmodified on 20200514 from:
#https://wiki.gentoo.org/wiki/Signed_kernel_module_support
function pre_pkg_preinst() {
    # This hook signs any out-of-tree kernel modules.
    if [[ -z "${MODULE_NAMES}" ]]; then
        # The package does not seem to install any kernel modules.
        return
    fi
    # Get the signature algorithm used by the kernel.
    local module_sig_hash="$(grep -Po '(?<=CONFIG_MODULE_SIG_HASH=").*(?=")' /usr/src/linux/.config)"
    # Get the key file used by the kernel.
    local module_sig_key="$(grep -Po '(?<=CONFIG_MODULE_SIG_KEY=").*(?=")' /usr/src/linux/.config)"
    module_sig_key="${module_sig_key:-certs/signing_key.pem}"
    # Path to the key file or PKCS11 URI
    if [[ "${module_sig_key#pkcs11:}" == "${module_sig_key}" && "${module_sig_key#/}" == "${module_sig_key}" ]]; then
        local key_path="/usr/src/linux/${module_sig_key}"
    else
        local key_path="${module_sig_key}"
    fi
    # Certificate path
    local cert_path=/usr/src/linux/certs/signing_key.x509
    # Sign all installed modules before merging.
    find "${D%/}/${INSDESTTREE#/}/" -name "*.ko" -exec /usr/src/linux/scripts/sign-file "${module_sig_hash}" "${key_path}" "${cert_path}" '{}' \;
}
