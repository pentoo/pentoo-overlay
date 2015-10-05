if [[ $CATEGORY/$PN == www-client/chromium ]] ; then CFLAGS=${CFLAGS/-ggdb/} CXXFLAGS=${CXXFLAGS/-ggdb/}; fi
if [[ $CATEGORY/$PN == www-client/firefox ]] ; then CFLAGS=${CFLAGS/-ggdb/} CXXFLAGS=${CXXFLAGS/-ggdb/}; fi
