if [[ $CATEGORY/$PN == sys-boot/os-prober ]] ; then FEATURES=${FEATURES/multilib-strict/} ; fi
if [[ $CATEGORY/$P == x11-drivers/nvidia-drivers-396.24 ]] ; then FEATURES=${FEATURES/multilib-strict/} ; fi
#local CORES="$(grep -c ^proc /proc/cpuinfo)"
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
if [[ $CATEGORY/$PN == app-crypt/hashcat ]]; then export CFLAGS=${CFLAGS/-Os/-O3}; fi
if [[ $CATEGORY/$PN == app-crypt/johntheripper ]]; then export CFLAGS=${CFLAGS/-Os/-O3}; fi
if [[ $CATEGORY/$PN == app-crypt/johntheripper-jumbo ]]; then export CFLAGS=${CFLAGS/-Os/-O3}; fi
if [[ $CATEGORY/$PN == net-wireless/cowpatty ]]; then export CFLAGS=${CFLAGS/-Os/-O3}; fi
