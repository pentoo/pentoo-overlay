#!/bin/bash
# Test the metadata step of scripts/qa/Dockerfile.visibility: it must fail on
# 48d53344d, the tree of issue #2901 whose cpm-cmake.eclass broke portage's
# sandboxed depend phase, and pass on the working tree.  Builds only up to that
# step, in docker, unprivileged.  Needs network and git history.
#
# usage: scripts/qa/test-visibility-regen.sh

set -euo pipefail

src=$(realpath "$(dirname "$0")/../..")
broken=48d53344d
work=$(mktemp -d)
trap 'rm -rf "${work}"' EXIT
failed=0

awk '/^# test install pentoo\/pentoo/ { exit } { print }' "${src}/scripts/qa/Dockerfile.visibility" > "${work}/Dockerfile"
grep -q 'egencache' "${work}/Dockerfile"

mkdir "${work}/broken" "${work}/current"
git -C "${src}" archive "${broken}" | tar -C "${work}/broken" -xf -
git -C "${src}" ls-files -z | (cd "${src}" && tar --null -T - -cf -) | tar -C "${work}/current" -xf -
for d in broken current; do
	cp "${src}/scripts/qa/explain-failure" "${work}/${d}/scripts/qa/"
done

# $1: context name; prints the build log to $work/$1.log, returns the build's status
build() {
	nice -n 19 docker build --pull --no-cache --progress=plain --output type=cacheonly \
		-f "${work}/Dockerfile" "${work}/$1" > "${work}/$1.log" 2>&1
}

if build broken; then
	echo "FAIL the #2901 tree passed the metadata step"
	failed=1
elif grep -q 'FAIL: dev-libs/libredasm/libredasm-[^:]*\.ebuild: fails to source' "${work}/broken.log"; then
	echo "ok   the #2901 tree fails the metadata step on dev-libs/libredasm"
else
	echo "FAIL the #2901 tree failed, but not in the metadata step:"
	tail -n 20 "${work}/broken.log"
	failed=1
fi

if build current; then
	echo "ok   the working tree passes the metadata step"
else
	echo "FAIL the working tree fails the metadata step:"
	grep -E 'Error processing|failed \(depend phase\)' "${work}/current.log" || tail -n 20 "${work}/current.log"
	failed=1
fi

exit "${failed}"
