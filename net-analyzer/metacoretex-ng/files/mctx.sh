#!/bin/sh
cd /opt/metacoretex-ng/
echo "Starting MetaCoretex"

JARNAME="MetaCoreTex-NG.jar"

DIR=/opt/metacoretex-ng/

DIST="${DIR}/dist/"
CONTRIB="${DIR}/contrib/"
PROBES="${DIR}/probes/"

MCTXJAR="${DIST}${JARNAME}"
BIN="${DIR}/bin/"

JARZ=`ls ${CONTRIB}`

CP="${MCTXJAR}:${PROBES}" 

if [ -f ${JDK_HOME}/lib/tools.jar ]; then
    CP="${CP}:${JDK_HOME}/lib/tools.jar"
fi

for I in ${JARZ}; do
    CP="${CP}:${CONTRIB}${I}"
done

java -cp ${CP} -Dswing.aatext=true  com.securitycentric.metacoretex.Init &
