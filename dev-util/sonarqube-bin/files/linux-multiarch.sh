#!/bin/sh
#

MACHINE_TYPE=`getconf LONG_BIT`
if [ "${MACHINE_TYPE}" = "64" ]; then
  JSW=/opt/sonar/bin/linux-x86-64/sonar.sh
else
  JSW=/opt/sonar/bin/linux-x86-32/sonar.sh
fi

echo "Launching startup scripts ${JWS}"

exec ${JSW} console
