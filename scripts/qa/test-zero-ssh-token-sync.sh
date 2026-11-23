#!/bin/bash
# Test pentoo/zero-system's ssh-token-sync, ssh-token-watch and
# ssh-askpass-pinentry.  A throwaway ssh-agent with plain ed25519 keys stands
# in for the user's agent and token handles, a temp dir for sysfs, and stubs
# replace ssh-keygen -K, pinentry and udevadm, so nothing touches a real
# agent or token.  Needs no root.
#
# usage: scripts/qa/test-zero-ssh-token-sync.sh

# shellcheck disable=SC2329 # functions called through check and trap
set -euo pipefail
unset SSH_AUTH_SOCK SSH_AGENT_PID DISPLAY WAYLAND_DISPLAY

src=$(realpath "$(dirname "$0")/../..")
files=${src}/pentoo/zero-system/files
sync=${files}/ssh-token-sync
watch=${files}/ssh-token-watch
askpass=${files}/ssh-askpass-pinentry
root=$(mktemp -d)
agent=
cleanup() {
	[ -z "${agent}" ] || kill "${agent}" 2> /dev/null || true
	rm -rf "${root}"
}
trap cleanup EXIT
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

home=${root}/home
ssh=${home}/.ssh
stub=${root}/stub
sysfs=${root}/sys
keys=${root}/keys
resident=${root}/resident
mkdir -p "${ssh}" "${stub}" "${sysfs}" "${keys}" "${resident}" "${root}/run"
chmod 700 "${ssh}"

for k in green cresc other; do
	ssh-keygen -q -t ed25519 -N '' -C "${k}" -f "${keys}/${k}"
done
ssh-keygen -q -t ed25519 -N '' -C stranger -f "${keys}/stranger"

cat > "${root}/map" <<'EOF'
# test map
1050:0407 0020489729 id_green id_green

04e6:* - id_cresc id_ecdsa_sk_rk
1050:0407 0020489728 id_red
EOF

cat > "${stub}/ssh-keygen" <<STUB
#!/bin/sh
[ "\$1" = -K ] || exit 2
printf '%s %s\n' "\${SSH_ASKPASS_REQUIRE:-}" "\${SSH_ASKPASS:-}" >> "${root}/keygen"
[ ! -e "${root}/keygen-cancels" ] || exit 1
cp "${resident}"/* .
STUB
chmod 755 "${stub}/ssh-keygen"

ssh-agent -D -a "${root}/agent.sock" > /dev/null 2>&1 &
agent=$!
for _ in $(seq 50); do
	[ -S "${root}/agent.sock" ] && break
	sleep 0.1
done

# $1: name, $2: VID, $3: PID, $4: serial or empty
plug() {
	mkdir -p "${sysfs}/$1"
	echo "$2" > "${sysfs}/$1/idVendor"
	echo "$3" > "${sysfs}/$1/idProduct"
	[ -z "${4:-}" ] || echo "$4" > "${sysfs}/$1/serial"
}
unplug() {
	rm -rf "${sysfs:?}/$1"
}
install_key() {
	cp "${keys}/$1" "${ssh}/$2"
	cp "${keys}/$1.pub" "${ssh}/$2.pub"
}
# $1: key stand-in, $2: the name ssh-keygen -K saves it under
resident_key() {
	rm -f "${resident}"/*
	cp "${keys}/$1" "${resident}/$2"
	cp "${keys}/$1.pub" "${resident}/$2.pub"
}
run() {
	local rc=0
	rm -f "${root}/keygen"
	env HOME="${home}" PATH="${stub}:${PATH}" SSH_AUTH_SOCK="${root}/agent.sock" \
		ZERO_SSH_TOKENS="${root}/map" ZERO_SYSFS="${sysfs}" ZERO_STATE="${root}/state" \
		ZERO_ASKPASS=/usr/libexec/zero-system/ssh-askpass-pinentry "$@" \
		sh "${sync}" < /dev/null > "${root}/out" 2>&1 || rc=$?
	echo "${rc}" > "${root}/rc"
}
rc_is() {
	[ "$(cat "${root}/rc")" = "$1" ]
}
loaded() {
	SSH_AUTH_SOCK=${root}/agent.sock ssh-add -L 2> /dev/null | grep -q " $1\$"
}
keygen_runs() {
	if [ -e "${root}/keygen" ]; then wc -l < "${root}/keygen"; else echo 0; fi
}

install_key green id_green
install_key cresc id_cresc
plug 5-1 1050 0407 0020489729
run
check "exits 0" rc_is 0
check "is quiet" test ! -s "${root}/out"
check "loads the key of a plugged in token" loaded green
check "doesn't load the key of an absent token" eval '! loaded cresc'

SSH_AUTH_SOCK=${root}/agent.sock ssh-add -q "${keys}/other" 2> /dev/null
run
check "a second run changes nothing" loaded green
unplug 5-1
run
check "unplugging a token takes its key out" eval '! loaded green'
check "leaves identities that aren't in the map alone" loaded other

plug 3-2 04e6 5410
run
check "* PID and - serial match any reader" loaded cresc
plug 5-1 1050 0407 0020489728
run
check "matches the USB serial" eval '! loaded green'
check "a line without RKNAME never runs ssh-keygen -K" test "$(keygen_runs)" = 0
unplug 5-1
unplug 3-2
run

rm -f "${ssh}"/id_green*
resident_key green id_green
plug 5-1 1050 0407 0020489729
run DISPLAY=:99
check "recovers a missing handle with ssh-keygen -K" test -f "${ssh}/id_green" -a -f "${ssh}/id_green.pub"
check "loads the recovered key" loaded green
check "asks for the PIN with the askpass program on a display" \
	grep -qxF "force /usr/libexec/zero-system/ssh-askpass-pinentry" "${root}/keygen"
check "removes its temp dir" test -z "$(find "${ssh}" -name '.recover.*')"
unplug 5-1
run

rm -f "${ssh}"/id_cresc*
resident_key cresc id_ecdsa_sk_rk
plug 3-2 04e6 5410
run DISPLAY=:99
check "renames RKNAME to KEYFILE" cmp -s "${keys}/cresc" "${ssh}/id_cresc"
check "and loads it" loaded cresc
unplug 3-2
run

rm -f "${ssh}"/id_green*
plug 5-1 1050 0407 0020489729
run
check "without a display or terminal it doesn't ask" test "$(keygen_runs)" = 0
touch "${root}/keygen-cancels"
run DISPLAY=:99
check "asks once when the PIN prompt is cancelled" test "$(keygen_runs)" = 1
run DISPLAY=:99
check "doesn't ask again before a replug" test "$(keygen_runs)" = 0
unplug 5-1
run
plug 5-1 1050 0407 0020489729
run DISPLAY=:99
check "asks again after a replug" test "$(keygen_runs)" = 1
rm -f "${root}/keygen-cancels"
unplug 5-1
run

cp "${keys}/stranger.pub" "${ssh}/id_green.pub"
resident_key green id_green
plug 5-1 1050 0407 0020489729
run DISPLAY=:99
check "doesn't move a recovered key that doesn't match KEYFILE.pub" test ! -e "${ssh}/id_green"
check "doesn't overwrite KEYFILE.pub" cmp -s "${keys}/stranger.pub" "${ssh}/id_green.pub"
unplug 5-1
run

rc=0
env HOME="${home}" SSH_AUTH_SOCK="${root}/no-agent.sock" ZERO_SSH_TOKENS="${root}/map" \
	ZERO_SYSFS="${sysfs}" ZERO_STATE="${root}/state" sh "${sync}" < /dev/null > "${root}/out" 2>&1 || rc=$?
check "without an agent it exits 0" test "${rc}" = 0
check "and is quiet" test ! -s "${root}/out"

cat > "${stub}/pinentry" <<STUB
#!/bin/sh
echo "OK Pleased to meet you"
while read -r line; do
	echo "\${line}" >> "${root}/pinentry-in"
	case \${line} in
		GETPIN)
			if [ -e "${root}/pinentry-cancels" ]; then
				echo "ERR 83886179 Operation cancelled"
			else
				echo "D 12%2534%0A"
				echo OK
			fi
			;;
		*) echo OK ;;
	esac
done
STUB
chmod 755 "${stub}/pinentry"
pin=$(PATH=${stub}:${PATH} sh "${askpass}" "Enter PIN for 100% sure key:")
check "askpass prints the decoded PIN" test "${pin}" = "12%34"
check "askpass escapes % in the description" grep -qxF "SETDESC Enter PIN for 100%25 sure key:" "${root}/pinentry-in"
touch "${root}/pinentry-cancels"
rc=0
PATH=${stub}:${PATH} sh "${askpass}" "PIN:" > /dev/null || rc=$?
check "askpass exits 1 when cancelled" test "${rc}" = 1
rc=0
out=$(SSH_ASKPASS_PROMPT=none PATH=${stub}:${PATH} sh "${askpass}" "touch it") || rc=$?
check "askpass only returns for a notification" test "${rc}" = 0 -a -z "${out}"

cat > "${stub}/udevadm" <<STUB
#!/bin/sh
echo "monitor will print the received events for:"
echo "UDEV - the event which udev sends out after rule processing"
echo
if [ -e "${root}/udevadm-blocks" ]; then
	echo \$\$ > "${root}/udevadm-pid"
	exec sleep 30
fi
echo "KERNEL[1.000001] add      /devices/usb5/5-1 (usb)"
echo "UDEV  [1.000002] add      /devices/usb5/5-1 (usb)"
echo "UDEV  [1.000003] bind     /devices/usb5/5-1 (usb)"
echo "UDEV  [1.000004] remove   /devices/usb5/5-1 (usb)"
STUB
cat > "${stub}/sync" <<STUB
#!/bin/sh
echo sync >> "${root}/syncs"
STUB
chmod 755 "${stub}/udevadm" "${stub}/sync"
watch_run() {
	env PATH="${stub}:${PATH}" XDG_RUNTIME_DIR="${root}/run" ZERO_SSH_TOKEN_SYNC="${stub}/sync" \
		"$@" sh "${watch}" > /dev/null 2>&1
}
syncs() {
	if [ -e "${root}/syncs" ]; then wc -l < "${root}/syncs"; else echo 0; fi
}

rm -f "${root}/syncs"
watch_run SSH_AUTH_SOCK="${root}/agent.sock"
check "watch syncs at start and on each add or remove" test "$(syncs)" = 3

rm -f "${root}/syncs"
watch_run SSH_AUTH_SOCK="${root}/no-agent.sock"
check "watch stops at the first event after its agent is gone" test "$(syncs)" = 1

rm -f "${root}/syncs"
touch "${root}/udevadm-blocks"
watch_run SSH_AUTH_SOCK="${root}/agent.sock" &
first=$!
sleep 0.5
start=${SECONDS}
watch_run SSH_AUTH_SOCK="${root}/agent.sock"
check "a second watch for the same agent exits at once" test $((SECONDS - start)) -le 2
check "and doesn't sync" test "$(syncs)" = 1
kill "$(cat "${root}/udevadm-pid")"
wait "${first}" || true
rm -f "${root}/udevadm-blocks"

check "the desktop entry starts the installed watch" \
	grep -qxF "Exec=/usr/libexec/zero-system/ssh-token-watch" "${files}/zero-ssh-token-watch.desktop"
ebuild_has() {
	grep -qxF "	$1" "${src}"/pentoo/zero-system/zero-system-*.ebuild
}
check "the ebuild installs the map" ebuild_has "doins \"\${FILESDIR}\"/ssh-tokens"
check "the ebuild installs the autostart entry" ebuild_has "doins \"\${FILESDIR}\"/zero-ssh-token-watch.desktop"
check "zshrc runs the installed sync" \
	grep -qxF "    /usr/libexec/zero-system/ssh-token-sync" "${files}/zshrc"

exit "${failed}"
