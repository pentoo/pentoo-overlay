#!/bin/bash
# Test scripts/binpkgs-missing-rebuild, which lists the installed packages the
# livecd builds quickpkg because they have no binpkg.  It must skip versions
# that are no longer in the tree, packages in PENTOO_BINPKG_RESTRICTED and
# packages that already have a binpkg.  Runs as root inside a gentoo/stage3
# container and changes /var/db/pkg, so it refuses to run anywhere else.  From
# the repository root on the host:
#
#   docker create --name portage gentoo/portage
#   docker run --rm --volumes-from portage -v "$PWD":/src:ro -w /src gentoo/stage3 scripts/qa/test-binpkgs-missing-rebuild.sh
#
# Remove the portage volume container afterwards with: docker rm -v portage
# shellcheck disable=SC2329 # functions called through check
set -u

if [ ! -e /.dockerenv ] && [ "${BINPKGS_TEST_ALLOW:-}" != yes ]; then
	echo "refusing to run outside a container (set BINPKGS_TEST_ALLOW=yes to override)" >&2
	exit 2
fi
if [ "$(id -u)" != 0 ]; then
	echo "must run as root" >&2
	exit 2
fi

src=$(realpath "$(dirname "$(realpath "$0")")/../..")
script=${src}/scripts/binpkgs-missing-rebuild
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

listed() {
	grep -qxF "=$1" "${work}/out"
}
not_listed() {
	! listed "$1"
}
none_listed() {
	! grep -q "^=$1" "${work}/out"
}
all_in_tree() {
	python3 -c '
import sys
import portage
portdb = portage.db[portage.root]["porttree"].dbapi
sys.exit(any(not portdb.cpv_exists(l.strip().lstrip("=")) for l in open(sys.argv[1]) if l.strip()))
' "${work}/out"
}

mkdir -p /etc/portage/repos.conf
printf '[pentoo]\nlocation = %s\n' "${src}" > /etc/portage/repos.conf/pentoo-test.conf
pkgdir=$(portageq pkgdir 2> /dev/null)
rm -rf "${pkgdir:?}"
mkdir -p "${pkgdir}"

# installed versions still in the tree: one gets a binpkg, one doesn't, one is restricted by
# a bare name, and one only contains a restricted category's name
mapfile -t in_tree < <(python3 -c '
import portage
vardb = portage.db[portage.root]["vartree"].dbapi
portdb = portage.db[portage.root]["porttree"].dbapi
names = set()
for cpv in sorted(vardb.cpv_all()):
    name = portage.catsplit(portage.cpv_getkey(cpv))[1]
    if portdb.cpv_exists(cpv) and not cpv.startswith("acct-group/") and name not in names:
        names.add(name)
        print(cpv)
')
with_binpkg=${in_tree[0]}
without_binpkg=${in_tree[1]}
contains_name=${in_tree[2]}
bare_name=${in_tree[3]}
pn() {
	local p=${1#*/}
	echo "${p%%-[0-9]*}"
}
restricted=$(portageq match / 'acct-group/*' 2> /dev/null | head -n 1)
quickpkg --include-config=y "=${with_binpkg}" > /dev/null 2>&1

# a copy of an installed package under a version the tree doesn't have
real=${without_binpkg}
fake=${real%%-[0-9]*}-0.0.0.1
pf=${fake#*/}
cp -a "/var/db/pkg/${real}" "/var/db/pkg/${fake}"
mv "/var/db/pkg/${fake}/${real#*/}.ebuild" "/var/db/pkg/${fake}/${pf}.ebuild"
echo "${pf}" > "/var/db/pkg/${fake}/PF"

PENTOO_BINPKG_RESTRICTED="acct-group/* $(pn "${contains_name}")/* $(pn "${bare_name}")" "${script}" > "${work}/out" 2> "${work}/err"
echo "${?}" > "${work}/rc"

check "the script succeeds" test "$(cat "${work}/rc")" = 0
check "it lists an installed package without a binpkg (${without_binpkg})" listed "${without_binpkg}"
check "it skips a version that is not in the tree (${fake})" not_listed "${fake}"
check "it skips a package that has a binpkg (${with_binpkg})" not_listed "${with_binpkg}"
if [ -n "${restricted}" ]; then
	check "it skips PENTOO_BINPKG_RESTRICTED packages (${restricted})" none_listed "acct-group/"
else
	echo "info no acct-group package installed, restricted check skipped"
fi
check "a category wildcard only matches that category (${contains_name})" listed "${contains_name}"
check "a bare name matches the package in any category (${bare_name})" not_listed "${bare_name}"
check "every version it lists is in the tree" all_in_tree

rm -rf "/var/db/pkg/${fake}" /etc/portage/repos.conf/pentoo-test.conf
exit "${failed}"
