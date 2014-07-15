#!/sbin/runscript

depend() {
    need net
    use dns logger
}

RUN_AS=sonar

MACHINE_TYPE=`getconf LONG_BIT`
if [ "${MACHINE_TYPE}" = "64" ]; then
  JSW=/opt/sonar/bin/linux-x86-64/sonar.sh
else
  JSW=/opt/sonar/bin/linux-x86-32/sonar.sh
fi

checkconfig() {
    return 0
}

start() {
    checkconfig || return 1

    ebegin "Starting ${SVCNAME}"
    su $RUN_AS -c "$JSW start"
    eend $?
}

stop() {
    ebegin "Stopping ${SVCNAME}"
    su $RUN_AS -c "$JSW stop"
    eend $?
}
