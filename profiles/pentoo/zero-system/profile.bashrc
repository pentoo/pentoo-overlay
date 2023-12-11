# https://bugs.gentoo.org/877761
# https://bugs.gentoo.org/860873
# https://bugs.gentoo.org/861872
#  if [[ $PN != kismet ]] && [[ $PN != bladerf ]] && [[ $PN != gnuradio ]] && [[ $PN != trunk-recorder ]] && [[ $PN != osmo-fl2k ]]; then
#    export CFLAGS="${CFLAGS} -Werror=strict-aliasing -flto"
#    export CXXFLAGS="${CXXFLAGS} -Werror=strict-aliasing -flto"
#  fi

# Packages that need stringop-overread disabled
if [[ ${CATEGORY}/${PN} == media-video/ffmpeg ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == app-crypt/p11-kit ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi

# Packages that need shuffle disabled
if [[ ${CATEGORY}/${PN} == www-client/chromium ]]; then
  export MAKEOPTS="${MAKEOPTS} --shuffle=none"
  export CFLAGS="${CFLAGS/-flto/}"
  export CXXFLAGS="${CXXFLAGS/-flto/}"
fi

# Special case to run tests for hashcat
if [[ ${CATEGORY}/${PN} == app-crypt/hashcat ]]; then
  export ALLOW_TEST=all
fi

# These packages need lto disabled
#if [[ ${CATEGORY}/${PN} == app-containers/podman ]]; then
  # https://bugs.gentoo.org/919314
#  export CFLAGS="${CFLAGS/-flto -Werror=strict-aliasing -Werror=odr -Werror=lto-type-mismatch -Wstringop-overread -Werror=stringop-overread/}"
#  export CXXFLAGS="${CXXFLAGS/-flto -Werror=strict-aliasing -Werror=odr -Werror=lto-type-mismatch -Wstringop-overread -Werror=stringop-overread/}"
#fi

QA_CMP_ARGS='--quiet-nodebug'
