#!/bin/bash
# Test scripts/qa/annotated and scripts/qa/explain-failure on excerpts of real
# CI output.  Needs only bash, awk and sed; uses shellcheck when it is there.
#
# usage: scripts/qa/test-annotated.sh

# shellcheck disable=SC2329,SC2016 # functions called through check; eval and literal code in single quotes
set -euo pipefail

src=$(realpath "$(dirname "$0")/../..")
annotated=${src}/scripts/qa/annotated
explain=${src}/scripts/qa/explain-failure
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

# $1: name, then annotated's options and command; runs in $work/repo, keeps
# the annotations in $work/$1.out and the status in $work/$1.rc
run() {
	local name=$1 rc=0
	shift
	(cd "${work}/repo" && GITHUB_STEP_SUMMARY=${summary:-} "${annotated}" "$@") > "${work}/${name}.all" 2>&1 || rc=$?
	grep '^::' "${work}/${name}.all" > "${work}/${name}.out" || true
	echo "${rc}" > "${work}/${name}.rc"
}
has() {
	grep -qxF -- "$2" "${work}/$1.out"
}
count() {
	[ "$(wc -l < "${work}/$1.out")" -eq "$2" ]
}
rc_is() {
	[ "$(cat "${work}/$1.rc")" = "$2" ]
}

mkdir -p "${work}/repo/net-wireless/wireless-regdb" "${work}/repo/dev-python/graphql-core" \
	"${work}/repo/dev-libs/libredasm" "${work}/repo/dev-util/cpu_rec_rs" "${work}/repo/scripts"
touch "${work}/repo/net-wireless/wireless-regdb/wireless-regdb-20260903.ebuild" \
	"${work}/repo/dev-python/graphql-core/graphql-core-3.3.0.ebuild" \
	"${work}/repo/dev-libs/libredasm/libredasm-20260616.ebuild" \
	"${work}/repo/dev-util/cpu_rec_rs/cpu_rec_rs-1.0.1.ebuild"

# test scripts' FAIL lines, from a run of test-check-mirrors.sh
cat > "${work}/tests.log" << 'EOF'
ok   a current mirror is ok
FAIL a mirror more than a day behind is reported
ok   the rest
EOF
run tests "Mirror Check" sh -c "cat '${work}/tests.log'; exit 1"
check "a test's FAIL line is an error" has tests '::error title=Mirror Check::a mirror more than a day behind is reported'
check "and nothing else is" count tests 1
check "the command's status is kept" rc_is tests 1
check "and its output still shown" grep -qxF 'ok   the rest' "${work}/tests.all"

# The Visibility Check's dnscrypt-proxy failure (run 46008833837): the FAIL line
# is printed once in the step and again in buildkit's excerpt of it
cat > "${work}/visibility.log" << 'EOF'
#11 150.8 !!! The following update has been skipped due to unsatisfied dependencies:
#11 150.8 FAIL: emerge can't resolve pentoo/pentoo: update to net-dns/dnscrypt-proxy-2.1.21 skipped: All ebuilds that could satisfy ">=dev-lang/go-1.27.4" have been masked. (dependency required by "net-dns/dnscrypt-proxy-2.1.21::gentoo" [ebuild])
#11 ERROR: process "/bin/sh -c time emerge ...; echo \"FAIL: emerge can't resolve pentoo/pentoo: ...\"" did not complete successfully: exit code: 1
------
 > [7/7] RUN time emerge ...:
150.8 FAIL: emerge can't resolve pentoo/pentoo: update to net-dns/dnscrypt-proxy-2.1.21 skipped: All ebuilds that could satisfy ">=dev-lang/go-1.27.4" have been masked. (dependency required by "net-dns/dnscrypt-proxy-2.1.21::gentoo" [ebuild])
------
  28 | >>>     echo "FAIL: emerge can't resolve pentoo/pentoo: $(explain-failure emerge /tmp/emerge.out)"; \
ERROR: failed to build: failed to solve: process "/bin/sh -c time emerge ..." did not complete successfully: exit code: 1
EOF
run visibility "Visibility Check" sh -c "cat '${work}/visibility.log'; exit 1"
check "a FAIL line in docker's output is an error, once" count visibility 1
check "with buildkit's prefix taken off" has visibility \
	'::error title=Visibility Check::emerge can'"'"'t resolve pentoo/pentoo: update to net-dns/dnscrypt-proxy-2.1.21 skipped: All ebuilds that could satisfy ">=dev-lang/go-1.27.4" have been masked. (dependency required by "net-dns/dnscrypt-proxy-2.1.21::gentoo" [ebuild])'

# egencache's FAIL lines name the ebuild
cat > "${work}/egencache.log" << 'EOF'
#11 7.142 FAIL: dev-libs/libredasm/libredasm-20260616.ebuild: fails to source: Sandbox violations found, exiting
#11 7.142 FAIL: dev-libs/libredasm/libredasm-9999.ebuild: fails to source
EOF
run egencache "Visibility Check" sh -c "cat '${work}/egencache.log'; exit 1"
check "a FAIL line naming a file is annotated on it" has egencache \
	'::error file=dev-libs/libredasm/libredasm-20260616.ebuild,title=Visibility Check::fails to source: Sandbox violations found, exiting'
check "and one naming a missing file isn't" has egencache \
	'::error title=Visibility Check::dev-libs/libredasm/libredasm-9999.ebuild: fails to source'

# A docker build that fails before any check runs
cat > "${work}/docker.log" << 'EOF'
#5 [2/7] RUN git clone https://github.com/gentoo/gentoo.git --depth 1
#5 0.312 fatal: unable to access 'https://github.com/gentoo/gentoo.git/': Could not resolve host: github.com
#5 ERROR: process "/bin/sh -c git clone https://github.com/gentoo/gentoo.git --depth 1" did not complete successfully: exit code: 128
ERROR: failed to build: failed to solve: process "/bin/sh -c git clone https://github.com/gentoo/gentoo.git --depth 1" did not complete successfully: exit code: 128
EOF
run docker "Build Test" sh -c "cat '${work}/docker.log'; exit 1"
check "a failure with no FAIL line gets docker's error" has docker \
	'::error title=Build Test::ERROR: failed to build: failed to solve: process "/bin/sh -c git clone https://github.com/gentoo/gentoo.git --depth 1" did not complete successfully: exit code: 128'
run quiet "Build Test" sh -c 'exit 4'
check "or says to see the log" has quiet '::error title=Build Test::failed, see the log'
check "and keeps the status" rc_is quiet 4
run passed "Build Test" sh -c "cat '${work}/docker.log'"
check "a passing command with an ERROR line isn't annotated" count passed 0

# The Build Test summary, once in the step and again in buildkit's excerpt,
# with a test suite's FAIL line before it
cat > "${work}/build.log" << 'EOF'
#10 80.12 FAIL: test_expected_failure (tests.test_x.T)
#10 95.40 === build test summary ===
#10 95.40 built                    dev-python/graphql-core/graphql-core-3.2.13.ebuild
#10 95.40 built (~amd64)           dev-python/graphql-core/graphql-core-3.3.0.ebuild
#10 95.40 skipped (masked)         dev-python/graphql-core/graphql-core-9999.ebuild
#10 95.40 FAILED (deps)            net-wireless/wireless-regdb/wireless-regdb-20260903.ebuild All ebuilds that could satisfy "=dev-lang/go-9999" have been masked.
#10 95.40 WARNING (dep build)      dev-util/cpu_rec_rs/cpu_rec_rs-1.0.1.ebuild
#10 95.40 === end summary ===
95.40 === build test summary ===
95.40 FAILED (deps)            net-wireless/wireless-regdb/wireless-regdb-20260903.ebuild All ebuilds that could satisfy "=dev-lang/go-9999" have been masked.
95.40 === end summary ===
EOF
summary=${work}/build.summary
run build -b "Build Test" sh -c "cat '${work}/build.log'; exit 1"
check "a FAILED summary line is an error on the ebuild, with the reason" has build \
	'::error file=net-wireless/wireless-regdb/wireless-regdb-20260903.ebuild,title=Build Test%3A FAILED (deps)::net-wireless/wireless-regdb/wireless-regdb-20260903.ebuild: visible, but its dependencies cannot be resolved: All ebuilds that could satisfy "=dev-lang/go-9999" have been masked.'
check "a ~amd64 build is a warning" has build \
	'::warning file=dev-python/graphql-core/graphql-core-3.3.0.ebuild,title=Build Test%3A only ~amd64::dev-python/graphql-core/graphql-core-3.3.0.ebuild: only keyworded ~amd64, users have to accept ~amd64 to install it'
check "and so is a WARNING line" has build \
	'::warning file=dev-util/cpu_rec_rs/cpu_rec_rs-1.0.1.ebuild,title=Build Test%3A WARNING (dep build)::dev-util/cpu_rec_rs/cpu_rec_rs-1.0.1.ebuild: its dependencies failed to build, so it was not built'
check "builds and skips aren't, nor test suites' FAIL lines with -b, nor the repeat" count build 3
check "the summary goes in the step summary once" eval \
	'[ "$(grep -c "=== build test summary ===" "${work}/build.summary")" = 1 ]'
check "with the annotations listed" grep -qF -- '- **error** `net-wireless/wireless-regdb/wireless-regdb-20260903.ebuild`: ' "${work}/build.summary"
summary=''

# Workflow command escaping, and a path out of the checkout isn't a file
printf 'FAIL: scripts: 100%% of\r it\n' > "${work}/escape.log"
printf 'FAIL: ../repo/scripts: up\n' >> "${work}/escape.log"
run escape "Mirror, check: x" cat "${work}/escape.log"
check "data and properties are escaped" has escape '::error title=Mirror%2C check%3A x::scripts: 100%25 of%0D it'
check "a path with .. isn't used as a file" has escape '::error title=Mirror%2C check%3A x::../repo/scripts: up'

# Annotating can't change the result
summary=/nonexistent/summary
run unwritable "Build Test" sh -c 'echo "FAIL x"; exit 0'
summary=''
check "a step summary that can't be written leaves the status alone" rc_is unwritable 0
check "and still annotates" has unwritable '::error title=Build Test::x'

run keep -o "${work}/kept.log" "Mirror Check" printf 'line\n'
check "-o keeps the output" grep -qxF line "${work}/kept.log"

if command -v shellcheck > /dev/null; then
	printf '#!/bin/sh\necho $1\n' > "${work}/repo/scripts/bad"
	run shellcheck Shellcheck shellcheck -f gcc scripts/bad
	check "shellcheck findings are errors on the file and line" has shellcheck \
		'::error file=scripts/bad,title=shellcheck SC2086,line=2,col=6::note: Double quote to prevent globbing and word splitting. [SC2086]'
	check "and fail the step" rc_is shellcheck 1
fi

# explain-failure
cat > "${work}/emerge.out" << 'EOF'
WARNING: One or more updates/rebuilds have been skipped due to a dependency conflict:

dev-python/numpy:0

!!! The following update has been skipped due to unsatisfied dependencies:

net-dns/dnscrypt-proxy:0

  selected: (net-dns/dnscrypt-proxy-2.1.15:0/0::gentoo, installed)
  skipped: (net-dns/dnscrypt-proxy-2.1.21:0/0::gentoo, ebuild scheduled for merge) (see unsatisfied dependency below)

!!! All ebuilds that could satisfy ">=dev-lang/go-1.27.4" have been masked.
!!! One of the following masked packages is required to complete your request:
- dev-lang/go-1.27.4::gentoo (masked by: ~amd64 keyword)

(dependency required by "net-dns/dnscrypt-proxy-2.1.21::gentoo" [ebuild])
(dependency required by "pentoo/pentoo-2026.0::pentoo" [ebuild])
EOF
check "explain-failure names the skipped update and why" eval '[ "$("${explain}" emerge "${work}/emerge.out")" = '"'"'update to net-dns/dnscrypt-proxy-2.1.21 skipped: All ebuilds that could satisfy ">=dev-lang/go-1.27.4" have been masked. (dependency required by "net-dns/dnscrypt-proxy-2.1.21::gentoo" [ebuild])'"'"' ]'
printf 'emerge: there are no ebuilds to satisfy "dev-foo/bar".\n(dependency required by "pentoo/pentoo-2026.0::pentoo" [ebuild])\n' > "${work}/missing.out"
check "or the first error and what required it" eval '[ "$("${explain}" emerge "${work}/missing.out")" = '"'"'emerge: there are no ebuilds to satisfy "dev-foo/bar". (dependency required by "pentoo/pentoo-2026.0::pentoo" [ebuild])'"'"' ]'
: > "${work}/empty.out"
check "or points to the output" eval '[ "$("${explain}" emerge "${work}/empty.out")" = "see the emerge output" ]'

# egencache's output on the #2901 tree, 48d53344d
cat > "${work}/egencache.out" << 'EOF'
Messages for package dev-libs/libredasm-20260616::pentoo:
 * Call stack:
 * ERROR: dev-libs/libredasm-20260616::pentoo failed (depend phase):
 *   Sandbox violations found, exiting
 *   ebuild.sh, line 688:  Called die

Messages for package dev-util/cpu_rec_rs-1.0.1::pentoo:
 * ERROR: dev-util/cpu_rec_rs-1.0.1::pentoo failed (depend phase):
 *   RUST_MAX_VER must not be older than RUST_MIN_VER
 *
Error processing dev-libs/libredasm-20260616 with returncode 1, continuing...
Error processing dev-util/cpu_rec_rs-1.0.1 with returncode 1, continuing...
Error processing dev-util/gone-1 with returncode 1, continuing...
EOF
"${explain}" egencache "${work}/egencache.out" "${work}/repo" > "${work}/egencache.fail"
check "explain-failure gives each ebuild that fails to source and why" grep -qxF \
	'FAIL: dev-libs/libredasm/libredasm-20260616.ebuild: fails to source: Sandbox violations found, exiting' "${work}/egencache.fail"
check "with the eclass's die message" grep -qxF \
	'FAIL: dev-util/cpu_rec_rs/cpu_rec_rs-1.0.1.ebuild: fails to source: RUST_MAX_VER must not be older than RUST_MIN_VER' "${work}/egencache.fail"
check "and the atom when there's no ebuild" grep -qxF 'FAIL: dev-util/gone-1: fails to source' "${work}/egencache.fail"

exit "${failed}"
