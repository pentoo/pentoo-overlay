if [[ $CATEGORY/$PN == net-wireless/trunk-recorder ]]; then export CFLAGS=${CFLAGS/-Os/-O3}; fi
if [[ $CATEGORY/$PN == net-wireless/trunk-recorder ]]; then export CXXFLAGS=${CXXFLAGS/-Os/-O3}; fi
if [[ $CATEGORY == net-wireless ]]; then
  # https://bugs.gentoo.org/877761
  # https://bugs.gentoo.org/860873
  # https://bugs.gentoo.org/861872
  if [[ $PN != kismet ]] && [[ $PN != bladerf ]] && [[ $PN != gnuradio ]] && [[ $PN != trunk-recorder ]] && [[ $PN != osmo-fl2k ]]; then
    export CFLAGS="${CFLAGS} -Werror=strict-aliasing -flto"
    export CXXFLAGS="${CXXFLAGS} -Werror=strict-aliasing -flto"
  fi
fi
if [[ $CATEGORY/$PN == dev-lang/python ]]; then
  export CFLAGS="${CFLAGS} -Werror=strict-aliasing -flto"
  export CXXFLAGS="${CXXFLAGS} -Werror=strict-aliasing -flto"
fi
if [[ $CATEGORY == sys-devel ]]; then
  #https://bugs.gentoo.org/853898
  if [[ $PN != gdb ]]; then
    export CFLAGS="${CFLAGS} -Werror=strict-aliasing -flto"
    export CXXFLAGS="${CXXFLAGS} -Werror=strict-aliasing -flto"
  fi
fi
if [[ $CATEGORY == www-client ]]; then
  export CFLAGS="${CFLAGS} -Werror=strict-aliasing -flto"
  export CXXFLAGS="${CXXFLAGS} -Werror=strict-aliasing -flto"
fi
QA_CMP_ARGS='--quiet-nodebug'
if [[ $CATEGORY/$PN == app-crypt/hashcat ]]; then
  export ALLOW_TEST=all
fi
