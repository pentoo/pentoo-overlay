# https://bugs.gentoo.org/877761
# https://bugs.gentoo.org/860873
# https://bugs.gentoo.org/861872

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
# CFLAGS
if [[ ${CATEGORY}/${PN} == app-crypt/mit-krb5 ]]; then
  export CFLAGS="${CFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/numpy ]]; then
  export CFLAGS="${CFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == dev-util/radare2 ]]; then
  export CFLAGS="${CFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == sys-apps/util-linux ]]; then
  export CFLAGS="${CFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == sys-devel/binutils ]]; then
  export CFLAGS="${CFLAGS/-flto/}"
fi
# CXXFLAGS
if [[ ${CATEGORY}/${PN} == dev-qt/qtnetwork ]]; then
  export CXXFLAGS="${CXXFLAGS/-flto/}"
fi
# FFLAGS
if [[ ${CATEGORY}/${PN} == dev-python/scipy ]]; then
  export FFLAGS="${FFLAGS/-flto/}"
fi

QA_CMP_ARGS='--quiet-nodebug'
