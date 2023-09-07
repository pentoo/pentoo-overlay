CFLAGS="${CFLAGS} -flto -Werror=strict-aliasing -Werror=odr -Werror=lto-type-mismatch -Wstringop-overread -Werror=stringop-overread"
CXXFLAGS="${CXXFLAGS} -flto -Werror=strict-aliasing -Werror=odr -Werror=lto-type-mismatch -Wstringop-overread -Werror=stringop-overread"
FCFLAGS="${FCFLAGS} -flto -Werror=strict-aliasing -Werror=odr -Werror=lto-type-mismatch -Wstringop-overread -Werror=stringop-overread"
FFLAGS="${FFLAGS} -flto -Werror=strict-aliasing -Werror=odr -Werror=lto-type-mismatch -Wstringop-overread -Werror=stringop-overread"

# https://bugs.gentoo.org/877761
# https://bugs.gentoo.org/860873
# https://bugs.gentoo.org/861872
#  if [[ $PN != kismet ]] && [[ $PN != bladerf ]] && [[ $PN != gnuradio ]] && [[ $PN != trunk-recorder ]] && [[ $PN != osmo-fl2k ]]; then
#    export CFLAGS="${CFLAGS} -Werror=strict-aliasing -flto"
#    export CXXFLAGS="${CXXFLAGS} -Werror=strict-aliasing -flto"
#  fi

# https://bugs.gentoo.org/853898
#if [[ $CATEGORY == sys-devel ]]; then
#  if [[ $PN != gdb ]]; then
#    export CFLAGS="${CFLAGS} -Werror=strict-aliasing -flto"
#    export CXXFLAGS="${CXXFLAGS} -Werror=strict-aliasing -flto"
#  fi
#fi

QA_CMP_ARGS='--quiet-nodebug'
if [[ $CATEGORY/$PN == app-crypt/hashcat ]]; then
  export ALLOW_TEST=all
fi
