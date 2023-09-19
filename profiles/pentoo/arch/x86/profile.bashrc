if [[ $CATEGORY/$PN == www-client/firefox ]]; then
  CFLAGS=${CFLAGS/-ggdb3/} CXXFLAGS=${CXXFLAGS/-ggdb3/};
  CFLAGS=${CFLAGS/-ggdb/} CXXFLAGS=${CXXFLAGS/-ggdb/};
fi
