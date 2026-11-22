#!/bin/bash
# Test pentoo/zero-system's udev hook that restarts scdaemon when a token is
# plugged or unplugged.  Fake gpg-agent processes stand in for the real ones
# and stubs replace pgrep, getent, setpriv and gpgconf, so nothing touches a
# real agent or card.  Needs no root.
#
# usage: scripts/qa/test-zero-scdaemon-rescan.sh

# shellcheck disable=SC2329 # functions called through check and trap
set -euo pipefail

src=$(realpath "$(dirname "$0")/../..")
files=${src}/pentoo/zero-system/files
hook=${files}/scdaemon-rescan
rules=${files}/90-zero-scdaemon-rescan.rules
root=$(mktemp -d)
pids=()
cleanup() {
	[ "${#pids[@]}" -eq 0 ] || kill "${pids[@]}" 2> /dev/null || true
	rm -rf "${root}"
}
trap cleanup EXIT
stub=${root}/stub
mkdir -p "${stub}" "${root}/agent"
failed=0

check() {
	local name=$1
	shift
	if "$@"; then
		echo "ok   ${name}"
	else
		echo "FAIL ${name}"
		failed=1
	fi
}

cat > "${stub}/pgrep" <<STUB
#!/bin/sh
[ "\$*" = "-x gpg-agent" ] || exit 2
cat "${root}/agents" 2> /dev/null
STUB
cat > "${stub}/getent" <<STUB
#!/bin/sh
[ "\$1" = passwd ] || exit 2
echo "tester:x:\$2:4242:Tester:${root}/home-\$2:/bin/sh"
STUB
cat > "${stub}/setpriv" <<STUB
#!/bin/sh
printf '%s %s %s\n' "\$1" "\$2" "\$3" >> "${root}/setpriv"
shift 3
exec "\$@"
STUB
cat > "${stub}/gpgconf" <<STUB
#!/bin/sh
printf 'HOME=%s %s\n' "\${HOME}" "\$*" >> "${root}/gpgconf"
[ ! -e "${root}/gpgconf-hangs" ] || sleep 30
[ ! -e "${root}/gpgconf-fails" ]
STUB
cat > "${root}/agent/gpg-agent" <<'STUB'
#!/bin/sh
while :; do sleep 1; done
STUB
chmod 755 "${stub}"/* "${root}/agent/gpg-agent"

# $@: the fake agent's arguments; its pid goes into the list pgrep prints
start_agent() {
	"${root}/agent/gpg-agent" "$@" < /dev/null > /dev/null 2>&1 &
	pids+=("$!")
	echo "$!" >> "${root}/agents"
}
run() {
	local rc=0
	rm -f "${root}/setpriv" "${root}/gpgconf"
	PATH=${stub}:${PATH} sh "${hook}" > "${root}/out" 2>&1 || rc=$?
	echo "${rc}" > "${root}/rc"
}
rc_is() {
	[ "$(cat "${root}/rc")" = "$1" ]
}
lines() {
	if [ -e "${root}/$1" ]; then wc -l < "${root}/$1"; else echo 0; fi
}
rules_parse() {
	udevadm verify --no-style "${rules}" > "${root}/verify" 2>&1
}
has_line() {
	grep -qxF -- "$2" "${root}/$1"
}

uid=$(id -u)
start_agent --homedir /tmp/agent-one --daemon
start_agent --homedir=/tmp/agent-two --daemon
start_agent --daemon
sleep 0.2
run
check "exits 0" rc_is 0
check "is quiet" test ! -s "${root}/out"
check "kills scdaemon once per agent" test "$(lines gpgconf)" = 3
check "runs as the agent's uid, with its passwd gid" \
	has_line setpriv "--reuid=${uid} --regid=4242 --init-groups"
check "drops to each agent's user" test "$(lines setpriv)" = 3
check "uses --homedir X" has_line gpgconf "HOME=${root}/home-${uid} --homedir /tmp/agent-one --kill scdaemon"
check "uses --homedir=X" has_line gpgconf "HOME=${root}/home-${uid} --homedir /tmp/agent-two --kill scdaemon"
check "uses the default homedir without one" has_line gpgconf "HOME=${root}/home-${uid} --kill scdaemon"

touch "${root}/gpgconf-fails"
run
check "exits 0 when gpgconf fails" rc_is 0
check "still tries every agent when gpgconf fails" test "$(lines gpgconf)" = 3
rm -f "${root}/gpgconf-fails"

kill "${pids[@]}"
wait 2> /dev/null || true
pids=()
rm -f "${root}/agents"
start_agent --daemon
sleep 0.2
touch "${root}/gpgconf-hangs"
start=${SECONDS}
run
check "exits 0 when gpgconf hangs" rc_is 0
check "gives up on a hanging gpgconf within 5 seconds" test $((SECONDS - start)) -le 7
rm -f "${root}/gpgconf-hangs"

kill "${pids[@]}"
wait 2> /dev/null || true
pids=()
echo 999999999 > "${root}/agents"
run
check "exits 0 when the agent is already gone" rc_is 0
check "does nothing for a vanished agent" test "$(lines gpgconf)" = 0
rm -f "${root}/agents"
run
check "does nothing without an agent" test "$(lines gpgconf)" = 0

check "udev rules file parses" rules_parse
check "rule runs the installed hook" \
	grep -qF 'RUN+="/usr/libexec/zero-system/scdaemon-rescan"' "${rules}"
check "rule matches Yubico and Identiv on add and remove" \
	grep -qF 'ACTION=="add|remove", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ENV{PRODUCT}=="1050/*|4e6/*"' "${rules}"
check "ebuild installs the hook where the rule runs it" \
	grep -qE '^[[:space:]]*exeinto /usr/libexec/zero-system$' "${src}"/pentoo/zero-system/zero-system-*.ebuild

exit "${failed}"
