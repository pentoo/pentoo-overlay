# https://bugs.gentoo.org/877761
# https://bugs.gentoo.org/860873
# https://bugs.gentoo.org/861872

# Packages that need format-security disabled
if [[ ${CATEGORY}/${PN} == net-analyzer/gspoof ]]; then
  export CFLAGS="${CFLAGS/-Werror=format-security/}"
fi
if [[ ${CATEGORY}/${PN} == net-analyzer/hunt ]]; then
  export CFLAGS="${CFLAGS/-Werror=format-security/}"
fi
if [[ ${CATEGORY}/${PN} == net-analyzer/p0f ]]; then
  export CFLAGS="${CFLAGS/-Werror=format-security/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/libcdio ]]; then
  export CFLAGS="${CFLAGS/-Werror=format-security/}"
fi
if [[ ${CATEGORY}/${PN} == net-mail/mailutils ]]; then
  export CFLAGS="${CFLAGS/-Werror=format-security/}"
fi
if [[ ${CATEGORY}/${PN} == net-wireless/mdk ]]; then
  export CFLAGS="${CFLAGS/-Werror=format-security/}"
fi
if [[ ${CATEGORY}/${PN} == dev-build/gn ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=format-security/}"
fi

# Packages that need stringop-overread disabled
if [[ ${CATEGORY}/${PN} == net-misc/ntp ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == media-video/ffmpeg ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == dev-vcs/cvs ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == app-crypt/p11-kit ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == dev-db/sqlite ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == net-analyzer/xprobe ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == dev-qt/qtbase ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == sci-libs/libqalculate ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == llvm-core/clang ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
fi

# Packages that need shuffle disabled
if [[ ${CATEGORY}/${PN} == www-client/chromium ]]; then
  export MAKEOPTS="${MAKEOPTS} --shuffle=none"
fi
if [[ ${CATEGORY}/${PN} == app-containers/containerd ]]; then
  export MAKEOPTS="${MAKEOPTS} --shuffle=none"
fi
if [[ ${CATEGORY}/${PN} == net-libs/ldns ]]; then
  export MAKEOPTS="${MAKEOPTS} --shuffle=none"
fi
if [[ ${CATEGORY}/${PN} == sys-devel/gcc ]]; then
  export MAKEOPTS="${MAKEOPTS} --shuffle=none"
fi
if [[ ${CATEGORY}/${PN} == net-analyzer/thc-ipv6 ]]; then
  export MAKEOPTS="${MAKEOPTS} --shuffle=none"
fi
if [[ ${CATEGORY}/${PN} == app-text/openjade ]]; then
  export MAKEOPTS="${MAKEOPTS} --shuffle=none"
fi
if [[ ${CATEGORY}/${PN} == app-cdr/cdrtools ]]; then
  export MAKEOPTS="${MAKEOPTS} --shuffle=none"
fi

# Special case to run tests for hashcat
if [[ ${CATEGORY}/${PN} == app-crypt/hashcat ]]; then
  export ALLOW_TEST=all
fi

# These packages need lto or similar disabled
# CFLAGS
if [[ ${CATEGORY}/${PN} == app-text/texlive-core ]]; then
  export CFLAGS="${CFLAGS/-Werror=lto-type-mismatch/}"
  export CFLAGS="${CFLAGS/-Werror=strict-aliasing/}"
fi
if [[ ${CATEGORY}/${PN} == app-emulation/wine-vanilla ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == dev-build/kbuild ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == dev-db/mariadb-connector-c ]]; then
  export CFLAGS="${CFLAGS/-Werror=lto-type-mismatch/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/libtasn1 ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/libtecla ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/protobuf-python ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/protobuf ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == dev-util/radare2 ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
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
if [[ ${CATEGORY}/${PN} == media-libs/jbig2dec ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == media-video/obs-studio ]]; then
  export CFLAGS="${CFLAGS/-Werror=lto-type-mismatch/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/opus ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == media-video/vlc ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
  export CFLAGS="${CFLAGS/-Werror=strict-aliasing/}"
  export CFLAGS="${CFLAGS/-Werror=lto-type-mismatch/}"
fi
if [[ ${CATEGORY}/${PN} == net-analyzer/ppscan ]]; then
  export CFLAGS="${CFLAGS/-Werror=strict-aliasing/}"
fi
if [[ ${CATEGORY}/${PN} == net-analyzer/yersinia ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == net-fs/curlftpfs ]]; then
  export CFLAGS="${CFLAGS/-Werror=lto-type-mismatch/}"
fi
if [[ ${CATEGORY}/${PN} == net-fs/nfs-utils ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == net-misc/dhcp ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == net-misc/remmina ]]; then
  export CFLAGS="${CFLAGS/-Werror=lto-type-mismatch/}"
fi
if [[ ${CATEGORY}/${PN} == net-misc/vde ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == net-wireless/bladerf ]]; then
  export CFLAGS="${CFLAGS/-Werror=lto-type-mismatch/}"
fi
if [[ ${CATEGORY}/${PN} == sys-cluster/openmpi ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
  export CFLAGS="${CFLAGS/-Werror=lto-type-mismatch/}"
  export FCFLAGS="${FCFLAGS/-Werror=lto-type-mismatch/}"
fi
if [[ ${CATEGORY}/${PN} == sys-fs/f2fs-tools ]]; then
  export CFLAGS="${CFLAGS/-Werror=lto-type-mismatch/}"
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
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == dev-db/sqlitebrowser ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=odr/}"
fi
if [[ ${CATEGORY}/${PN} == dev-util/bcc ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=odr/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/keystone ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=odr/}"
fi
if [[ ${CATEGORY}/${PN} == dev-qt/qtwebengine ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == dev-util/android-tools ]]; then
  export CFLAGS="${CFLAGS/-Werror=stringop-overread/}"
  export CXXFLAGS="${CXXFLAGS/-Werror=strict-aliasing/}"
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
  export CXXFLAGS="${CXXFLAGS/-Werror=odr/}"
fi
if [[ ${CATEGORY}/${PN} == dev-util/colm ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == dev-util/gengetopt ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
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
if [[ ${CATEGORY}/${PN} == kde-plasma/plasma-desktop ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=odr/}"
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/plasma-vault ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=odr/}"
fi
if [[ ${CATEGORY}/${PN} == media-sound/audacity ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=strict-aliasing/}"
  export CXXFLAGS="${CXXFLAGS/-Werror=odr/}"
fi
if [[ ${CATEGORY}/${PN} == net-analyzer/gspoof ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=lto-type-mismatch/}"
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
if [[ ${CATEGORY}/${PN} == sys-devel/clang ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == dev-util/lief ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=strict-aliasing/}"
fi
if [[ ${CATEGORY}/${PN} == app-office/libreoffice ]]; then
  export CXXFLAGS="${CXXFLAGS/-flto/}"
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
fi

QA_CMP_ARGS='--quiet-nodebug'
