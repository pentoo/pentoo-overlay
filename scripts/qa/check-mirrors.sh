#!/bin/bash
# Check that the binpkg mirrors are up to date.  Each dir's Packages index
# starts with a TIMESTAMP header that portage sets every time it writes the
# index.  A mirror more than MAX_LAG seconds behind the primary fails, and so
# does the primary when its index is more than MAX_AGE seconds old, since the
# nightly build is then no longer reaching it.  The default DIR is the one the
# build server currently builds.  With -m, checks only the primary's age, or
# only one mirror against the primary.
#
# usage: check-mirrors.sh [-m NAME] [DIR...]
#
# PRIMARY is NAME=URL; MIRRORS is a space-separated list of them.
set -euo pipefail

primary=${PRIMARY:-pentoo.ch=https://www.pentoo.ch/isos/Packages/}
read -ra mirrors <<< "${MIRRORS:-glpgs=https://pentoo.glpgs.io/Packages/ umu=https://ftp.acc.umu.se/mirror/pentoo.ch/Packages/ osuosl=https://pentoo.osuosl.org/Packages/}"
max_lag=${MAX_LAG:-86400}
max_age=${MAX_AGE:-259200}
now=${NOW:-$(date +%s)}
only=

usage() {
	echo "usage: ${0##*/} [-m NAME] [DIR...]" >&2
	exit 2
}

while getopts m:h opt; do
	case "${opt}" in
		m) only=${OPTARG} ;;
		*) usage ;;
	esac
done
shift $((OPTIND - 1))
dirs=("$@")
[ "${#dirs[@]}" -gt 0 ] || dirs=(amd64_23.0s-hardened)

primary_name=${primary%%=*}
primary_url=${primary#*=}
check_primary=1
if [ "${only}" = "${primary_name}" ]; then
	mirrors=()
elif [ -n "${only}" ]; then
	check_primary=0
	found=
	for mirror in "${mirrors[@]}"; do
		[ "${mirror%%=*}" = "${only}" ] && found=${mirror}
	done
	[ -n "${found}" ] || { echo "${0##*/}: no mirror named ${only}" >&2; usage; }
	mirrors=("${found}")
fi
fail=0

# curl gets SIGPIPE when awk stops at the end of the header
timestamp() {
	curl -sfL --max-time 60 --retry 2 -r 0-16383 "$1$2/Packages" 2> /dev/null |
		awk -F': ' '/^$/ { exit } $1 == "TIMESTAMP" { print $2; exit }'
}

duration() {
	local s=$1
	if [ "${s}" -lt 3600 ]; then
		echo "$((s / 60))m"
	elif [ "${s}" -lt 172800 ]; then
		echo "$((s / 3600))h"
	else
		echo "$((s / 86400))d"
	fi
}

# result OK|FAIL NAME DIR MESSAGE
result() {
	printf '%-4s %s %s: %s\n' "$1" "$2" "$3" "$4"
	[ "$1" = OK ] || fail=1
}

for dir in "${dirs[@]}"; do
	ts=$(timestamp "${primary_url}" "${dir}") || true
	if [[ ! ${ts} =~ ^[0-9]+$ ]]; then
		result FAIL "${primary_name}" "${dir}" "unreachable"
	elif [ "${check_primary}" = 0 ]; then
		:
	elif [ "$((now - ts))" -le "${max_age}" ]; then
		result OK "${primary_name}" "${dir}" "updated $(duration "$((now - ts))") ago"
	else
		result FAIL "${primary_name}" "${dir}" "not updated in $(duration "$((now - ts))")"
	fi

	for mirror in "${mirrors[@]}"; do
		name=${mirror%%=*}
		mts=$(timestamp "${mirror#*=}" "${dir}") || true
		if [[ ! ${mts} =~ ^[0-9]+$ ]]; then
			result FAIL "${name}" "${dir}" "unreachable"
		elif [[ ! ${ts} =~ ^[0-9]+$ ]]; then
			result FAIL "${name}" "${dir}" "primary unreachable"
		elif [ "${mts}" -ge "${ts}" ]; then
			result OK "${name}" "${dir}" "in sync"
		elif [ "$((ts - mts))" -le "${max_lag}" ]; then
			result OK "${name}" "${dir}" "$(duration "$((ts - mts))") behind"
		else
			result FAIL "${name}" "${dir}" "$(duration "$((ts - mts))") behind"
		fi
	done
done
exit "${fail}"
