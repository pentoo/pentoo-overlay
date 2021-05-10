if [[ $CATEGORY/$PN == sys-boot/os-prober ]] ; then FEATURES=${FEATURES/multilib-strict/} ; fi
local CORES="$(nproc)"
if [[ "${CORES}" -eq "0" ]] ; then CORES="1" ; fi
echo ${MAKEOPTS} | grep -q -e -j || export MAKEOPTS="-j${CORES} -l${CORES}"

#by the time this is parsed, EMERGE_DEFAULT_OPTS are already applied, this file is too late
#echo ${EMERGE_DEFAULT_OPTS} | grep -q jobs || export EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS} --jobs=${CORES} --load-average=${CORES}"

#let's speed up the cracker's default cflags a bit. this bloats the binaries but speeds improve
if [[ $CATEGORY/$PN == net-wireless/aircrack-ng ]]; then
    export CFLAGS=${CFLAGS/-Os/-O3}
    export CXXFLAGS=${CXXFLAGS/-Os/-O3}
fi
if [[ $CATEGORY/$PN == app-crypt/asleap ]]; then export CFLAGS=${CFLAGS/-Os/-O3}; fi
if [[ $CATEGORY/$PN == app-crypt/hashcat ]]; then export CFLAGS=${CFLAGS/-Os/-O3}; fi
if [[ $CATEGORY/$PN == app-crypt/johntheripper ]]; then export CFLAGS=${CFLAGS/-Os/-O3}; fi
if [[ $CATEGORY/$PN == app-crypt/johntheripper-jumbo ]]; then export CFLAGS=${CFLAGS/-Os/-O3}; fi
if [[ $CATEGORY/$PN == net-wireless/cowpatty ]]; then export CFLAGS=${CFLAGS/-Os/-O3}; fi
if [[ $CATEGORY/$PN =~ net-wireless/soapy* ]]; then export CFLAGS=${CFLAGS/-Os/-O3}; export CXXFLAGS=${CXXFLAGS/-Os/-O3}; fi
if [[ $CATEGORY/$PN == net-wireless/kismet ]]; then export CFLAGS=${CFLAGS/-Os/-O3}; fi
#speaking of, why not build gcc fast like the crackers
if [[ $CATEGORY/$PN == sys-devel/gcc ]]; then export CFLAGS=${CFLAGS/-Os/-O3}; fi
if [[ $CATEGORY/$PN == sys-devel/binutils ]]; then export CFLAGS=${CFLAGS/-Os/-O3}; fi
if [[ $CATEGORY/$PN == sys-libs/binutils-libs ]]; then export CFLAGS=${CFLAGS/-Os/-O3}; fi

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
