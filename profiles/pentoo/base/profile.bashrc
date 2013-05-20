#if [[ $CATEGORY/$PN == sys-auth/polkit ]] ; then FEATURES=${FEATURES/multilib-strict/} ; fi
local CORES="$(grep -c ^proc /proc/cpuinfo)"
echo ${MAKEOPTS} | grep -q -e -j || export MAKEOPTS="-j${CORES} -l${CORES}"

#by the time this is parsed, EMERGE_DEFAULT_OPTS are already applied, this file is too late
#echo ${EMERGE_DEFAULT_OPTS} | grep -q jobs || export EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS} --jobs=${CORES} --load-average=${CORES}"

#PENTOO_BINPKG_RESTRICTED=" sys-kernel/compat-drivers sys-kernel/ax88179_178a x11-drivers/ati-drivers x11-drivers/nvidia-drivers sys-fs/zfs-kmod sys-kernel/spl sys-power/bbswitch app-emulation/virtualbox-modules app-emulation/vmware-modules app-emulation/open-vm-tools-kmod "
#[[ ${PENTOO_BINPKG_RESTRICTED} = *" ${CATEGORY}/${PN} "* ]] && FEATURES=${FEATURES/buildpkg}
