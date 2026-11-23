#!/bin/bash
# Run check-mirrors.sh against a primary and three mirrors served from a temp
# dir by python's http.server on localhost.  Needs curl and python3, no network.
#
#   scripts/qa/test-check-mirrors.sh

# shellcheck disable=SC2329 # functions called through check
set -euo pipefail

script=$(dirname "$(realpath "$0")")/check-mirrors.sh
tmp=$(mktemp -d)
server=
cleanup() {
	[ -z "${server}" ] || kill "${server}"
	rm -rf "${tmp}"
}
trap cleanup EXIT
failed=0
now=1800000000

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

index() {
	mkdir -p "${tmp}/www/$1"
	printf 'ARCH: amd64\nPACKAGES: 1\nTIMESTAMP: %s\nVERSION: 0\n\nCPV: app-misc/foo-1\nTIMESTAMP: 1\n' \
		"$2" > "${tmp}/www/$1/Packages"
}

index primary/new-hardened $((now - 3600))
index primary/old-hardened $((now - 4 * 86400))
index a/new-hardened $((now - 3600))
index a/old-hardened $((now - 4 * 86400))
index b/new-hardened $((now - 3600 - 7200))
index c/new-hardened $((now - 3600 - 2 * 86400))

port=$(python3 -I -c 'import socket; s = socket.socket(); s.bind(("127.0.0.1", 0)); print(s.getsockname()[1])')
python3 -I -m http.server -b 127.0.0.1 -d "${tmp}/www" "${port}" > /dev/null 2>&1 &
server=$!
for _ in $(seq 50); do
	curl -sf "http://127.0.0.1:${port}/" > /dev/null && break
	sleep 0.1
done

url=http://127.0.0.1:${port}
run() {
	rc=0
	out=$(PRIMARY="prime=${url}/$1/" MIRRORS=$2 NOW=${now} \
		"${script}" -o "${tmp}/badges" "${@:3}") || rc=$?
}
says() {
	printf '%s\n' "${out}" | grep -qxF -- "$1"
}
badge() {
	python3 -I -c 'import json, sys
b = json.load(open(sys.argv[1]))
sys.exit(b != {"schemaVersion": 1, "label": "", "message": sys.argv[2], "color": sys.argv[3]})' \
		"${tmp}/badges/$1.json" "$2" "$3"
}

run primary "a=${url}/a/ b=${url}/b/ c=${url}/c/" new-hardened old-hardened
printf '%s\n' "${out}" | sed 's/^/     /'
check "a mirror more than a day behind fails the check" test "${rc}" = 1
check "a primary updated an hour ago is up to date" says "OK   prime new-hardened: updated 1h ago"
check "a mirror with the primary's index is in sync" says "OK   a new-hardened: in sync"
check "a mirror less than a day behind passes" says "OK   b new-hardened: 2h behind"
check "a mirror more than a day behind is reported" says "FAIL c new-hardened: 2d behind"
check "a primary not updated in MAX_AGE is reported" says "FAIL prime old-hardened: not updated in 4d"
check "a mirror without the dir is unreachable" says "FAIL b old-hardened: unreachable"
check "in-sync badge" badge a_new-hardened "in sync" brightgreen
check "behind badge" badge b_new-hardened "2h behind" yellow
check "out-of-date badge" badge c_new-hardened "2d behind" red
check "primary badge" badge prime_new-hardened "updated 1h ago" brightgreen
check "stale primary badge" badge prime_old-hardened "not updated in 4d" red

run primary "a=${url}/a/ b=${url}/b/" new-hardened
check "with every mirror up to date the check passes" test "${rc}" = 0

run primary "a=${url}/a/" old-hardened
check "a primary not updated in MAX_AGE fails, even with mirrors in sync" test "${rc}" = 1

run nonexistent "a=${url}/a/" new-hardened
check "an unreachable primary fails" test "${rc}" = 1
check "and the mirrors can't be compared" says "FAIL a new-hardened: primary unreachable"

out=$(PRIMARY="prime=${url}/primary/" MIRRORS="a=${url}/a/" NOW=${now} "${script}") || true
check "with no DIR it checks amd64_23.0s-hardened" says "FAIL prime amd64_23.0s-hardened: unreachable"

exit "${failed}"
