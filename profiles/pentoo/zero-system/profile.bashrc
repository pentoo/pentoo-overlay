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
fi
if [[ ${CATEGORY}/${PN} == app-containers/containerd ]]; then
  export MAKEOPTS="${MAKEOPTS} --shuffle=none"
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
if [[ ${CATEGORY}/${PN} == sys-devel/llvm ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=odr/}"
fi

#GCC14 Hardening Relaxations
if [[ ${CATEGORY}/${PN} == sys-libs/efivar ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-ruby/ffi ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == app-containers/containerd ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-ruby/strscan ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-ruby/stringio ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-ruby/psych ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-ruby/io-console ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-ruby/rbs ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-ruby/racc ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-ruby/do_sqlite3 ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-ruby/json ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == sys-libs/liburing ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == net-libs/libpcap ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == app-text/ghostscript-gpl ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kguiaddons ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kwindowsystem ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == app-text/poppler ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/breeze-icons ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == app-text/qpdf ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == app-crypt/pinentry ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/ki18n ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kconfig ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kdbusaddons ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kidletime ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/layer-shell-qt ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kglobalaccel ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kitemviews ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kitemmodels ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/sonnet ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kholidays ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/karchive ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kstatusnotifieritem ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kcodecs ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/syntax-highlighting ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kquickcharts ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/modemmanager-qt ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kcoreaddons ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/attica ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/solid ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/bluez-qt ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kwidgetsaddons ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kdnssd ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kcrash ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kcolorscheme ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kpty ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kunitconversion ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kpackage ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kcompletion ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/krunner ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/knotifications ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/libplasma ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/libksysguard ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/kactivitymanagerd ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/milou ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/kglobalacceld ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/kscreenlocker ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/plasma5support ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/breeze ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/kwin ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/plasma-activities ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/plasma-integration ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/plasma-workspace ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kconfigwidgets ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/ksvg ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kdesu ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kfilemetadata ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/networkmanager-qt ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kdoctools ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kiconthemes ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/plasma-activities-stats ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/kwrited ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/libkscreen ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/kdecoration ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/plasma-activities ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == net-wireless/gnuradio ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == net-analyzer/gr-fosphor ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/libjcat ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/libv4l ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == gui-libs/gtk ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == app-crypt/gpgme ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == app-crypt/p11-kit ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/gobject-introspection ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == x11-libs/pango ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/bottleneck ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/pycryptodome ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/libinput ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-util/rizin ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-video/vlc ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == sys-auth/polkit ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/pandas ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/numpy ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/fontconfig ]]; then
  export CFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-cpp/abseil-cpp ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/protobuf ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/webrtc-audio-processing ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == net-libs/libpsl ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/libfmt ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/kiwisolver ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/cchardet ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/numexpr ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-cpp/glibmm ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/libixion ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/spdlog ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == app-office/libreoffice ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/libnl ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/dav1d ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == net-libs/libmbim ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/libxmlb ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == sys-libs/libnvme ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == sys-apps/dtc ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/virglrenderer ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/sratom ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/babl ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/openjpeg ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/lcms ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/graphene ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-ruby/yajl-ruby ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == sys-libs/cracklib ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == net-libs/ngtcp2 ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/libepoxy ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-video/ffmpeg ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == app-arch/libdeflate ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/regex ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/tree-sitter ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/msgpack ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/websockets ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/yajl ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi

QA_CMP_ARGS='--quiet-nodebug'
