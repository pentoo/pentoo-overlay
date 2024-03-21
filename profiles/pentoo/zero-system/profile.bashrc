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
if [[ ${CATEGORY}/${PN} == net-libs/ldns ]]; then
  export MAKEOPTS="${MAKEOPTS} --shuffle=none"
fi

# Special case to run tests for hashcat
if [[ ${CATEGORY}/${PN} == app-crypt/hashcat ]]; then
  export ALLOW_TEST=all
fi

# These packages need lto or similar disabled
# CFLAGS
if [[ ${CATEGORY}/${PN} == app-crypt/mit-krb5 ]]; then
  export CFLAGS="${CFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == app-text/texlive-core ]]; then
  export CFLAGS="${CFLAGS/-Werror=lto-type-mismatch/}"
  export CFLAGS="${CFLAGS/-Werror=strict-aliasing/}"
fi
if [[ ${CATEGORY}/${PN} == dev-db/mariadb-connector-c ]]; then
  export CFLAGS="${CFLAGS/-Werror=lto-type-mismatch/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/numpy ]]; then
  export CFLAGS="${CFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == dev-util/radare2 ]]; then
  export CFLAGS="${CFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == dev-util/rizin ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == mate-base/caja ]]; then
  export CFLAGS="${CFLAGS/-Werror=strict-aliasing/}"
fi
if [[ ${CATEGORY}/${PN} == media-gfx/gimp ]]; then
  export CFLAGS="${CFLAGS/-Werror=strict-aliasing/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/fdk-aac ]]; then
  export CFLAGS="${CFLAGS/-Werror=odr/}"
fi
if [[ ${CATEGORY}/${PN} == media-video/obs-studio ]]; then
  export CFLAGS="${CFLAGS/-Werror=lto-type-mismatch/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/opus ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == media-video/mplayer ]]; then
  export CFLAGS="${CFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == media-video/vlc ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
  export CFLAGS="${CFLAGS/-Werror=strict-aliasing/}"
  export CFLAGS="${CFLAGS/-Werror=lto-type-mismatch/}"
fi
if [[ ${CATEGORY}/${PN} == net-fs/nfs-utils ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == net-wireless/bluez ]]; then
  # Tests fail with -flto
  export CFLAGS="${CFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == net-wireless/bladerf ]]; then
  export CFLAGS="${CFLAGS/-Werror=lto-type-mismatch/}"
fi
if [[ ${CATEGORY}/${PN} == sys-apps/util-linux ]]; then
  export CFLAGS="${CFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == sys-devel/binutils ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
  export CFLAGS="${CFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == sys-cluster/openmpi ]]; then
  export CFLAGS="${CFLAGS/-Werror=lto-type-mismatch/}"
  export FCFLAGS="${FCFLAGS/-Werror=lto-type-mismatch/}"
fi
if [[ ${CATEGORY}/${PN} == sys-fs/jfsutils ]]; then
  export CFLAGS="${CFLAGS/-Werror=lto-type-mismatch/}"
fi
if [[ ${CATEGORY}/${PN} == sys-libs/volk ]]; then
  export CFLAGS="${CFLAGS/-Werror=lto-type-mismatch/}"
fi
if [[ ${CATEGORY}/${PN} == x11-libs/libdrm ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
# CXXFLAGS
if [[ ${CATEGORY}/${PN} == app-crypt/ophcrack ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == app-emulation/virtualbox ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
  #export CFLAGS="${CFLAGS/-Werror=strict-aliasing/}"
  export CXXFLAGS="${CXXFLAGS/-Werror=strict-aliasing/}"
fi
if [[ ${CATEGORY}/${PN} == dev-db/sqlitebrowser ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=odr/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/keystone ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=odr/}"
fi
if [[ ${CATEGORY}/${PN} == dev-qt/qtnetwork ]]; then
  export CXXFLAGS="${CXXFLAGS/-flto/}"
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == dev-util/android-tools ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=strict-aliasing/}"
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
  export CXXFLAGS="${CXXFLAGS/-Werror=odr/}"
fi
if [[ ${CATEGORY}/${PN} == dev-util/libabigail ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == dev-util/lief ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=odr/}"
fi
if [[ ${CATEGORY}/${PN} == kde-apps/gwenview ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=odr/}"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/khtml ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=odr/}"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/kwayland ]]; then
  export CXXFLAGS="${CXXFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/plasma-desktop ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=odr/}"
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/plasma-vault ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=odr/}"
fi
if [[ ${CATEGORY}/${PN} == media-gfx/geeqie ]]; then
  export CXXFLAGS="${CXXFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/mesa ]]; then
  export CXXFLAGS="${CXXFLAGS/-flto/}"
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/x265 ]]; then
  export CXXFLAGS="${CXXFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == net-analyzer/gspoof ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=lto-type-mismatch/}"
fi
if [[ ${CATEGORY}/${PN} == net-ftp/filezilla ]]; then
  export CXXFLAGS="${CXXFLAGS/-flto/}"
fi
if [[ ${CATEGORY}/${PN} == net-wireless/gnuradio ]]; then
  # https://github.com/gnuradio/gnuradio/issues/7056
  export CXXFLAGS="${CXXFLAGS/-Werror=odr/}"
fi
if [[ ${CATEGORY}/${PN} == net-wireless/kismet ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=strict-aliasing/}"
fi
if [[ ${CATEGORY}/${PN} == sys-apps/smartmontools ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == sys-devel/llvm ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=odr/}"
fi
# FFLAGS
if [[ ${CATEGORY}/${PN} == dev-python/scipy ]]; then
  export FFLAGS="${FFLAGS/-flto/}"
fi

QA_CMP_ARGS='--quiet-nodebug'
