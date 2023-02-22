if [[ $CATEGORY/$PN == net-wireless/trunk-recorder ]]; then export CFLAGS=${CFLAGS/-Os/-O3}; fi
if [[ $CATEGORY/$PN == net-wireless/trunk-recorder ]]; then export CXXFLAGS=${CXXFLAGS/-Os/-O3}; fi
if [[ $CATEGORY == net-wireless ]]; then
  export CFLAGS="${CFLAGS} -Werror=strict-aliasing -flto"
  export CXXFLAGS="${CXXFLAGS} -Werror=strict-aliasing -flto"
fi
QA_CMP_ARGS='--quiet-nodebug'
