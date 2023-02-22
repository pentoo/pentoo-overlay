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
QA_CMP_ARGS='--quiet-nodebug'
