if [[ $CATEGORY/$PN == www-client/firefox ]] ; then CFLAGS=${CFLAGS/-ggdb/} CXXFLAGS=${CXXFLAGS/-ggdb/}; fi
