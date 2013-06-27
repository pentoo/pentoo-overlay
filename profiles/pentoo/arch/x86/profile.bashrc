if [[ $CATEGORY/$PN == www-client/chromium ]] ; then CFLAGS=${CFLAGS/-ggdb/} CXXFLAGS=${CXXFLAGS/-ggdb/}; fi
