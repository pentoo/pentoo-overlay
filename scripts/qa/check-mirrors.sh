#!/bin/bash
# Check that the binpkg mirrors are up to date.  Each dir's Packages index
# starts with a TIMESTAMP header that portage sets every time it writes the
# index.  A mirror more than MAX_LAG seconds behind the primary fails, and so
# does the primary when its index is more than MAX_AGE seconds old, since the
# nightly build is then no longer reaching it.  The default DIR is the one the
# build server currently builds.  With -o, writes a shields.io endpoint badge
# for each mirror and dir to BADGE_DIR, as NAME_DIR.json.
#
# usage: check-mirrors.sh [-o BADGE_DIR] [DIR...]
#
# PRIMARY is NAME=URL; MIRRORS is a space-separated list of them.
set -euo pipefail

primary=${PRIMARY:-pentoo.ch=https://www.pentoo.ch/isos/Packages/}
read -ra mirrors <<< "${MIRRORS:-glpgs=https://pentoo.glpgs.io/Packages/ umu=https://ftp.acc.umu.se/mirror/pentoo.ch/Packages/ osuosl=https://pentoo.osuosl.org/Packages/}"
max_lag=${MAX_LAG:-86400}
max_age=${MAX_AGE:-259200}
now=${NOW:-$(date +%s)}
badges=

while getopts o:h opt; do
	case "${opt}" in
		o) badges=${OPTARG} ;;
		*) echo "usage: ${0##*/} [-o BADGE_DIR] [DIR...]" >&2; exit 2 ;;
	esac
done
shift $((OPTIND - 1))
dirs=("$@")
[ "${#dirs[@]}" -gt 0 ] || dirs=(amd64_23.0s-hardened)

primary_name=${primary%%=*}
primary_url=${primary#*=}
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

# result OK|FAIL NAME DIR COLOR MESSAGE
result() {
	printf '%-4s %s %s: %s\n' "$1" "$2" "$3" "$5"
	[ "$1" = OK ] || fail=1
	if [ -n "${badges}" ]; then
		printf '{"schemaVersion":1,"label":"","message":"%s","color":"%s"}\n' \
			"$5" "$4" > "${badges}/$2_$3.json"
	fi
}

[ -z "${badges}" ] || mkdir -p "${badges}"

for dir in "${dirs[@]}"; do
	ts=$(timestamp "${primary_url}" "${dir}") || true
	if [[ ! ${ts} =~ ^[0-9]+$ ]]; then
		result FAIL "${primary_name}" "${dir}" red "unreachable"
	elif [ "$((now - ts))" -le "${max_age}" ]; then
		result OK "${primary_name}" "${dir}" brightgreen "updated $(duration "$((now - ts))") ago"
	else
		result FAIL "${primary_name}" "${dir}" red "not updated in $(duration "$((now - ts))")"
	fi

	for mirror in "${mirrors[@]}"; do
		name=${mirror%%=*}
		mts=$(timestamp "${mirror#*=}" "${dir}") || true
		if [[ ! ${mts} =~ ^[0-9]+$ ]]; then
			result FAIL "${name}" "${dir}" red "unreachable"
		elif [[ ! ${ts} =~ ^[0-9]+$ ]]; then
			result FAIL "${name}" "${dir}" lightgrey "primary unreachable"
		elif [ "${mts}" -ge "${ts}" ]; then
			result OK "${name}" "${dir}" brightgreen "in sync"
		elif [ "$((ts - mts))" -le "${max_lag}" ]; then
			result OK "${name}" "${dir}" yellow "$(duration "$((ts - mts))") behind"
		else
			result FAIL "${name}" "${dir}" red "$(duration "$((ts - mts))") behind"
		fi
	done
done
exit "${fail}"
