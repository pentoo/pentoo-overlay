#!/bin/bash
# Check that a stage3 tarball from the bootstrap profile can seed stage4:
# catalyst's first stage4 emerge, @system with --newuse under the normal
# profile, has to resolve with binpkgs from the Pentoo binhost.  The bootstrap
# profile turns off flags such as verify-sig, so that emerge reinstalls those
# packages.  Needs docker, no privileges, and only runs emerge --pretend.  From
# the repository root, with a stage3 tarball from the build host's Stage 3:
#
#   scripts/qa/test-stage4-seed.sh /path/to/stage3-amd64-2026.0.tar.zstd
#
# The tarball is imported as the docker image pentoo-stage3:test, replacing
# any earlier one; remove it afterwards with: docker rmi pentoo-stage3:test
# The gentoo repository comes from the host's /var/db/repos/gentoo, or from
# GENTOO_REPO.  The stage's python has no ssl, so BINHOST defaults to an
# http mirror.
set -euo pipefail

tarball=${1:?usage: test-stage4-seed.sh stage3-tarball}
src=$(realpath "$(dirname "$(realpath "$0")")/../..")
gentoo=${GENTOO_REPO:-/var/db/repos/gentoo}
binhost=${BINHOST:-http://pentoo.osuosl.org/Packages/amd64_23.0s-hardened/}
image=pentoo-stage3:test

zstd -dc "${tarball}" | docker import - "${image}" > /dev/null

# shellcheck disable=SC2016 # expanded in the container
script='
mkdir -p /var/db/repos/pentoo
cp -a /src/. /var/db/repos/pentoo/
echo "USE=\"bindist\"" >> /etc/portage/make.conf
echo "PORTAGE_BINHOST=\"$1\"" >> /etc/portage/make.conf
ln -sfn ../../var/db/repos/pentoo/profiles/pentoo/hardened/linux/amd64/23.0/split-usr /etc/portage/make.profile
emerge --pretend --tree --usepkg --getbinpkg --binpkg-respect-use=y --newuse -u @system > /tmp/out 2>&1
echo "rc: $?"
grep -E "^Total:" /tmp/out
grep -A12 -m1 "circular dependencies" /tmp/out
grep -B2 -A12 -E "^!!!|emerge: there are no" /tmp/out | head -30
'
out=$(docker run --rm -v "${gentoo}":/var/db/repos/gentoo:ro -v "${src}":/src:ro \
	"${image}" /bin/bash -c "${script}" sh "${binhost}" 2>&1) || true
printf '%s\n' "${out}" | sed 's/^/     /'
if printf '%s\n' "${out}" | grep -qxF "rc: 0"; then
	echo "ok   catalyst's first stage4 emerge resolves on this seed"
else
	echo "FAIL catalyst's first stage4 emerge resolves on this seed"
	exit 1
fi
