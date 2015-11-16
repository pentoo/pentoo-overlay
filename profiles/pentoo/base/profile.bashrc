#if [[ $CATEGORY/$PN == sys-auth/polkit ]] ; then FEATURES=${FEATURES/multilib-strict/} ; fi
#local CORES="$(grep -c ^proc /proc/cpuinfo)"
local CORES="$(nproc)"
if [[ "${CORES}" -eq "0" ]] ; then CORES="1" ; fi
echo ${MAKEOPTS} | grep -q -e -j || export MAKEOPTS="-j${CORES} -l${CORES}"

#by the time this is parsed, EMERGE_DEFAULT_OPTS are already applied, this file is too late
#echo ${EMERGE_DEFAULT_OPTS} | grep -q jobs || export EMERGE_DEFAULT_OPTS="${EMERGE_DEFAULT_OPTS} --jobs=${CORES} --load-average=${CORES}"
