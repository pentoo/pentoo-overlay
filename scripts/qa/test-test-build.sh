#!/bin/bash
# Test scripts/qa/test-build, the Build Test, by running the working tree's
# test-build, explain-failure and Dockerfile.build on old upstream merges whose
# outcome is known.  Each merge is fetched with its parents into a throwaway
# shallow repo; nothing is committed.  Runs docker unprivileged and needs
# network and git history.  Takes a while: the pentoo-full image and real
# builds.
#
# usage: scripts/qa/test-test-build.sh

# shellcheck disable=SC2329 # functions called through check
set -euo pipefail

src=$(realpath "$(dirname "$0")/../..")
work=$(mktemp -d)
trap 'rm -rf "${work}"' EXIT
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

# $1: case name, $2: merge commit, $3: optional command run in the checkout
# before the build.  Leaves the build log in $work/$1.log and its status in
# $work/$1.rc.
build() {
	local sha repo rc=0
	sha=$(git -C "${src}" rev-parse "$2^{commit}")
	repo=${work}/$1
	git init -q "${repo}"
	git -C "${repo}" fetch -q --depth 2 "file://${src}" "${sha}"
	git -C "${repo}" checkout -q --detach "${sha}"
	cp "${src}/scripts/qa/test-build" "${src}/scripts/qa/explain-failure" "${src}/scripts/qa/Dockerfile.build" "${repo}/scripts/qa/"
	[ -z "${3:-}" ] || (cd "${repo}" && eval "$3")
	nice -n 19 docker build --pull --no-cache --progress=plain --output type=cacheonly \
		-f "${repo}/scripts/qa/Dockerfile.build" "${repo}" > "${work}/$1.log" 2>&1 || rc=$?
	echo "${rc}" > "${work}/$1.rc"
}

# $1: case, $2: result, $3: ebuild
summary_has() {
	sed -n '/=== build test summary ===/,/=== end summary ===/p' "${work}/$1.log" |
		sed 's/^#[0-9]* [0-9.]* //' | grep -qE "^$2 +$3( |\$)"
}
failed_build() {
	[ "$(cat "${work}/$1.rc")" != 0 ]
}
passed_build() {
	[ "$(cat "${work}/$1.rc")" = 0 ]
}
# $1: case, $2: package-version
tests_enabled() {
	grep -qE "\] +${2//./\\.}::pentoo .* USE=\"([^\"]* )?test\*?[ \"]" "${work}/$1.log"
}
tested() {
	grep -qF "$2 looks like an ebuild" "${work}/$1.log"
}
# $1: case, $2: level, $3: file the Build Test's annotation must be on
annotates() {
	(cd "${work}/$1" && "${src}/scripts/qa/annotated" -b "Build Test" cat "${work}/$1.log") |
		grep -q "^::$2 file=$3,"
}

# #3046: two graphql-core versions, both with tests and only keyworded ~amd64
build graphql 1ab57ade5
check "the first of two changed ebuilds builds with tests" tests_enabled graphql dev-python/graphql-core-3.2.13
check "and so does the second" tests_enabled graphql dev-python/graphql-core-3.3.0
check "a ~amd64-only ebuild is built on ~amd64" \
	summary_has graphql 'built \(~amd64\)' dev-python/graphql-core/graphql-core-3.3.0.ebuild

# #3106: wireless-regdb-20230503-r2 removed, 20260903 kept
build regdb 92a7d5bde
check "a removed ebuild isn't tested" eval '! tested regdb net-wireless/wireless-regdb/wireless-regdb-20230503-r2.ebuild'
check "the kept one is" tested regdb net-wireless/wireless-regdb/wireless-regdb-20260903.ebuild
check "and the build test passes" passed_build regdb

# The same merge with a dependency that is never visible: go-9999 has no keywords
build masked-dep 92a7d5bde \
	'echo "RDEPEND+=\" =dev-lang/go-9999\"" >> net-wireless/wireless-regdb/wireless-regdb-20260903.ebuild'
check "a visible ebuild with a masked dependency fails the build test" failed_build masked-dep
check "and is reported as a dependency failure" \
	summary_has masked-dep 'FAILED \(deps\)' net-wireless/wireless-regdb/wireless-regdb-20260903.ebuild
check "with the dependency that is masked" \
	summary_has masked-dep 'FAILED \(deps\)' \
	'net-wireless/wireless-regdb/wireless-regdb-20260903.ebuild All ebuilds that could satisfy "=dev-lang/go-9999" have been masked\..*'
check "and annotated on the ebuild" annotates masked-dep error net-wireless/wireless-regdb/wireless-regdb-20260903.ebuild

for c in graphql regdb masked-dep; do
	echo "=== ${c} summary"
	sed -E 's/^(#[0-9]+ )?[0-9.]+ //' "${work}/${c}.log" | sed -n '/=== build test summary ===/,/=== end summary ===/{p;/=== end summary ===/q}' |
		sed 's/^/    /'
done
exit "${failed}"
