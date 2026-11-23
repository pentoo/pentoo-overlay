#!/bin/bash
# Check that catalyst's stage3 emerge resolves with this checkout's bootstrap
# profile: emerge -e @system has to find no circular dependencies and nothing
# missing.  It needs the build host's stage2 tarball, since which cycles
# emerge can break depends on what the seed has installed, so it isn't in CI.
# Needs docker, no privileges, and only runs emerge --pretend.  From the
# repository root, with the tarball copied off the build host:
#
#   scripts/qa/test-bootstrap-stage3.sh /path/to/stage2-amd64-2026.0.tar.zstd
#
# The tarball is imported as the docker image pentoo-stage2:test, replacing
# any earlier one; remove it afterwards with: docker rmi pentoo-stage2:test
# The gentoo repository comes from the host's /var/db/repos/gentoo, or from
# GENTOO_REPO.
set -euo pipefail

tarball=${1:?usage: test-bootstrap-stage3.sh stage2-tarball}
src=$(realpath "$(dirname "$(realpath "$0")")/../..")
gentoo=${GENTOO_REPO:-/var/db/repos/gentoo}
image=pentoo-stage2:test

zstd -dc "${tarball}" | docker import - "${image}" > /dev/null

# shellcheck disable=SC2016 # expanded in the container
script='
mkdir -p /var/db/repos/pentoo
cp -a /src/. /var/db/repos/pentoo/
echo "USE=\"bindist\"" >> /etc/portage/make.conf
echo "profile: $(readlink /etc/portage/make.profile)"
emerge --pretend --tree --newuse -e --update --deep --with-bdeps=y @system > /tmp/out 2>&1
echo "rc: $?"
grep -E "^Total:" /tmp/out
grep -A20 -m1 "circular dependencies" /tmp/out
grep -B2 -A12 -E "^!!!|emerge: there are no" /tmp/out | head -30
'
out=$(docker run --rm -v "${gentoo}":/var/db/repos/gentoo:ro -v "${src}":/src:ro \
	"${image}" /bin/bash -c "${script}" 2>&1) || true
printf '%s\n' "${out}" | sed 's/^/     /'
if printf '%s\n' "${out}" | grep -qxF "rc: 0"; then
	echo "ok   catalyst's stage3 emerge resolves"
else
	echo "FAIL catalyst's stage3 emerge resolves"
	exit 1
fi
