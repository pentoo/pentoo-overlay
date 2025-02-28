# https://bugs.gentoo.org/877761
# https://bugs.gentoo.org/860873
# https://bugs.gentoo.org/861872

# Packages that need stringop-overread disabled
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
if [[ ${CATEGORY}/${PN} == dev-qt/qtbase ]]; then
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == sci-libs/libqalculate ]]; then
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
if [[ ${CATEGORY}/${PN} == app-cdr/cdrtools ]]; then
  export MAKEOPTS="${MAKEOPTS} --shuffle=none"
  export CFLAGS="${CFLAGS} -fPIC"
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
  export CXXFLAGS="${CXXFLAGS} -fPIC"
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
if [[ ${CATEGORY}/${PN} == dev-qt/qtwebengine ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/plasma-systemmonitor ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/kinfocenter ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/ksystemstats ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-apps/dolphin ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/kdeplasma-addons ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/oxygen ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/plasma-disks ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/plasma-pa ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/plasma-welcome ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-apps/kate ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-apps/kate-lib ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-apps/kate-addons ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-apps/gwenview ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-apps/konsole ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/plasma-browser-integration ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/powerdevil ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
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
if [[ ${CATEGORY}/${PN} == dev-libs/opencl-icd-loader ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == media-libs/vulkan-loader ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-util/pahole ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-python/cryptography ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-ruby/msgpack ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-lang/luajit ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-perl/Syntax-Keyword-Try ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/newt ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == media-gfx/fontforge ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == sci-libs/volk ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-perl/XS-Parse-Keyword ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/ayatana-ido ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/zziplib ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-python/pyzmq ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == net-firewall/iptables ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == sys-libs/pam_wrapper ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == media-libs/freeglut ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == net-libs/libwebsockets ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/libfido2 ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-lua/luv ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/libical ]]; then
  export CFLAGS="${CFLAGS} -fPIC"
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/kpipewire ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == net-wireless/gr-osmosdr ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kauth ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == net-wireless/srsran ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == net-wireless/gr-rds ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == net-wireless/gr-ieee802154 ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == net-wireless/gr-paint ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == net-wireless/gr-iqbal ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == net-wireless/soapyuhd ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/qqc2-breeze-style ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kwallet ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/ktextwidgets ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kdeclarative ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/qqc2-desktop-style ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kxmlgui ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/kde-gtk-config ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == media-libs/pulseaudio-qt ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kbookmarks ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kservice ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-apps/libkexiv2 ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/qcoro ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
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
if [[ ${CATEGORY}/${PN} == kde-frameworks/threadweaver ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kjobwidgets ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kimageformats ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/sexpp ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/simdjson ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-util/librnp ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kirigami ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == net-wireless/uhd ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kio ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/prison ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-util/astyle ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
  # something is broken here, this shouldn't be required
  export CFLAGS="${CFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/frameworkintegration ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/kgamma ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-apps/kolourpaint ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/knotifyconfig ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/kirigami-addons ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/purpose ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-apps/kmix ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/sddm-kcm ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/kscreen ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/print-manager ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-apps/okular ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/bluedevil ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/plasma-nm ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/ktexteditor ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/keditfiletype ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-plasma/systemsettings ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-apps/kio-extras ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == media-gfx/kio-ps-thumbnailer ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/knewstuff ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kcmutils ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == kde-frameworks/kparts ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == net-wireless/gr-mixalot ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == app-text/libmspub ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == net-wireless/limesuite ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == net-libs/kdsoap-ws-discovery-client ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/flatbuffers ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == net-libs/kdsoap ]]; then
  export CXXFLAGS="${CXXFLAGS} -fPIC"
fi
if [[ ${CATEGORY}/${PN} == dev-lang/tk ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == sys-apps/portage ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/m2crypto ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == net-wireless/killerbee ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/arc4 ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/frida-python ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/donut-shellcode ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == sys-apps/pcsc-lite ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == www-servers/lighttpd ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/gstreamer ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/gst-plugins-base ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/nspr ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-plugins/gst-plugins-libnice ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == app-emulation/libvirt ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/libvirt-python ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == sys-apps/flashrom ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == sys-apps/lm-sensors ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/pyscard ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == sys-libs/ncurses-compat ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/wayland ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == net-libs/libnice ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == x11-base/xorg-server ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
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
if [[ ${CATEGORY}/${PN} == sys-libs/libcap ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/pyqt6-sip ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/pyqt5-sip ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/libpwquality ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/nassl ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/yara-python ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == sys-auth/elogind ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == sys-apps/dbus ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/openh264 ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-video/vlc ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == sys-auth/polkit ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/fontconfig ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/elfutils ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == x11-libs/cairo ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/protobuf ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == x11-libs/libdrm ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/libevdev ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == sys-libs/ldb ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == sys-libs/talloc ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-vcs/mercurial ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/fonttools ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/tree-sitter-bash ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/cbor2 ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/zope-interface ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/psutil ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == sys-libs/tdb ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/markupsafe ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/libdisplay-info ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == sys-libs/tevent ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/hidapi ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/libldac ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == app-arch/brotli ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/json-c ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == net-libs/libssh ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-util/unicorn ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/lilv ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == sys-fs/lvm2 ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/pillow ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/pycups ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == app-crypt/mit-krb5 ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == net-fs/samba ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == net-misc/proxychains ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == net-libs/libqmi ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/libei ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/openssl ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == x11-libs/pixman ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == net-libs/libproxy ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == net-libs/mbedtls ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == sys-apps/openrc ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == net-misc/networkmanager ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/tree-sitter-c ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/libpeas ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == net-libs/gtk-vnc ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == sys-apps/fwupd ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == net-libs/nghttp3 ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/glib ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == x11-libs/gdk-pixbuf ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/pygobject ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == gnome-base/gsettings-desktop-schemas ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == app-accessibility/at-spi2-core ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == net-libs/glib-networking ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == app-crypt/libsecret ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/libgusb ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == x11-libs/gtk+ ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == gui-libs/tepl ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == app-editors/ghex ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == gnome-extra/gucharmap ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/appstream-glib ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/json-glib ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == gnome-base/gvfs ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == gui-libs/libadwaita ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/gst-plugins-bad ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/gst-plugins-good ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/gst-plugins-ugly ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-plugins/gst-plugins-a52dec ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-plugins/gst-plugins-dvdread ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-plugins/gst-plugins-vaapi ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-plugins/gst-plugins-faad ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-plugins/gst-plugins-flac ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-plugins/gst-plugins-x264 ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-plugins/gst-plugins-mpg123 ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-plugins/gst-plugins-dts ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-plugins/gst-plugins-mpeg2dec ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-plugins/gst-plugins-wavpack ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-plugins/gst-plugins-oss ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-plugins/gst-plugins-resindvd ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-plugins/gst-plugins-pulse ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-plugins/gst-plugins-srtp ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-plugins/gst-plugins-cdparanoia ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-lua/mpack ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/tree-sitter-vim ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/tree-sitter-lua ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/tree-sitter-python ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/tree-sitter-vimdoc ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/tree-sitter-query ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-lang/perl ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-tcltk/tix ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == sys-libs/gpm ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/nettle ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/zstandard ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == net-libs/nghttp2 ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == app-forensics/afflib ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == sys-libs/zlib ]]; then
  # this builds without but breaks consumers
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
if [[ ${CATEGORY}/${PN} == dev-lang/ruby ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/gegl ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/harfbuzz ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == net-wireless/urh ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/libsass ]]; then
  # this builds without but breaks consumers
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-util/lief ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
  export CXXFLAGS="${CXXFLAGS/-Werror=strict-aliasing/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/crypto++ ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/scipy ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == app-arch/unrar ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/matplotlib ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-cpp/gtkmm ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == x11-libs/vte ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/gexiv2 ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == app-text/libmspub ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-sound/audacious ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-plugins/audacious-plugins ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == sys-apps/usbguard ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/liborcus ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-video/pipewire ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == net-wireless/soapysdr ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == x11-libs/fltk ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-util/colm ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == app-emulation/spice ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-util/glslang ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/assimp ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/contourpy ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-libs/jsoncpp ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-util/spirv-tools ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/mesa ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-debug/gdb ]]; then
  export CXXFLAGS="${CXXFLAGS/-fPIE -pie/}"
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
  export CXXFLAGS="${CXXFLAGS/-fPIC/}"
  export CXXFLAGS="${CXXFLAGS/-flto/}"
  export CXXFLAGS="${CXXFLAGS/-Werror=stringop-overread/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/bitarray ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == net-analyzer/net-snmp ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == net-libs/libssh2 ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/glfw ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/krb5 ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/gssapi ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-python/pycurl ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/gegl ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == net-misc/spice-gtk ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-libs/soxr ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == dev-util/radare2 ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == net-analyzer/bettercap ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == app-text/evince ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-video/wireplumber ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == x11-wm/marco ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
fi
if [[ ${CATEGORY}/${PN} == media-video/pipewire ]]; then
  export CFLAGS="${CFLAGS/-fPIE -pie/}"
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
if [[ ${CATEGORY}/${PN} == dev-libs/msgpack ]]; then
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
