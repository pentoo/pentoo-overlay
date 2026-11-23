#!/bin/bash
# Integration test for the signed binpkg rollout: scripts/pentoo-binrepos-conf
# and pentoo/pentoo-core/files/pentoo-trust-helper against a local binhost.
# Runs as root inside a gentoo/stage3 container and changes /etc/portage, so
# it refuses to run anywhere else.  From the repository root on the host:
#
#   docker create --name portage gentoo/portage
#   docker run --rm --volumes-from portage -v "$PWD":/src -w /src gentoo/stage3 scripts/qa/test-binhost-signing.sh
#
# Remove the portage volume container afterwards with: docker rm -v portage
# shellcheck disable=SC2329
# the functions below run through check, trap and command substitutions
set -u

if [ ! -e /.dockerenv ] && [ "${BINHOST_TEST_ALLOW:-}" != yes ]; then
	echo "refusing to run outside a container (set BINHOST_TEST_ALLOW=yes to override)" >&2
	exit 2
fi
if [ "$(id -u)" != 0 ]; then
	echo "must run as root" >&2
	exit 2
fi

src=$(dirname "$(realpath "$0")")/../..
src=$(realpath "${src}")
gen=${src}/scripts/pentoo-binrepos-conf
helper=${src}/pentoo/pentoo-core/files/pentoo-trust-helper
for tool in getuto gpkg-sign quickpkg python3 gpg emaint emerge portageq; do
	command -v "${tool}" > /dev/null || {
		echo "${tool} not found in this container" >&2
		exit 2
	}
done
[ -x "${gen}" ] && [ -f "${helper}" ] || {
	echo "scripts under test not found below ${src}" >&2
	exit 2
}

work=$(mktemp -d)
srv=/srv/binhost
sighome=${work}/sign
port=8000
base=http://127.0.0.1:${port}
signed=${base}/pentoo-signed
unsigned=${base}/pentoo-unsigned
other=${base}/other-unsigned
match='^http://127\.0\.0\.1:8000/pentoo'
binrepos=/etc/portage/binrepos.conf
pkgdir=/var/cache/binpkgs
failed=0
httpd=

cleanup() {
	[ -z "${httpd}" ] || kill "${httpd}" 2> /dev/null
	gpgconf --homedir "${sighome}" --kill all 2> /dev/null
	gpgconf --homedir /etc/portage/gnupg --kill all 2> /dev/null
	[ ! -f "${work}/gentoo.conf" ] || mv "${work}/gentoo.conf" "${binrepos}/gentoo.conf"
	rm -rf "${work}"
}
trap cleanup EXIT

# the stage3's own binrepo would make getbinpkg reach for the internet
mv "${binrepos}/gentoo.conf" "${work}/gentoo.conf" 2> /dev/null

check() {
	local name=$1 out
	shift
	if out=$("$@" 2>&1); then
		echo "ok   ${name}"
	else
		echo "FAIL ${name}"
		echo "     ${out//$'\n'/$'\n'     }"
		failed=1
	fi
}

info() {
	echo "info $*"
}

indent() {
	sed 's/^/     /'
}

reset_client() {
	rm -rf /etc/portage/gnupg "${binrepos}/pentoo-binhost.conf" "${binrepos}/other.conf" \
		/var/cache/edb/binhost /var/cache/binhost
	rm -rf "${pkgdir:?}"
	mkdir -p "${pkgdir}" "${binrepos}"
}


# $1 uri list for PORTAGE_BINHOST, $2 getbinpkg mode, rest emerge arguments
client_emerge() {
	local uris=$1
	shift
	PORTAGE_BINHOST=${uris} FEATURES="getbinpkg" emerge --oneshot --nodeps --quiet "$@"
}

gen_conf() {
	PORTAGE_BINHOST=$1 PENTOO_BINHOST_MATCH=${match} "${2:-${gen}}"
}

trust() {
	PENTOO_BINHOST_KEY=${work}/test-binhost.asc PENTOO_BINHOST_FPR=${fpr} bash "${helper}"
}

keyfield() {
	gpg --homedir "$1" --with-colons --list-keys "${fpr}" 2> /dev/null | awk -F: -v n="$2" '$1 == "pub" {print $n; exit}'
}

expect_fail() {
	local out
	if out=$("$@" 2>&1); then
		echo "unexpected success"
		echo "${out}"
		return 1
	fi
	echo "${out}"
}

unusable() {
	local out
	out=$(expect_fail "$@") || {
		echo "${out}"
		return 1
	}
	if ! grep -qiE 'not usable|verification|signature|no binary' <<< "${out}"; then
		echo "rejected, but the output doesn't mention the binpkg: ${out}"
		return 1
	fi
}

#### setup
echo "== setup"
mkdir -p "${sighome}" && chmod 700 "${sighome}"
printf 'disable-scdaemon\n' > "${sighome}/gpg-agent.conf"
GNUPGHOME=${sighome} gpg --batch --passphrase '' --pinentry-mode loopback \
	--quick-gen-key 'Test binhost <test@example.invalid>' nistp384 sign 900d 2> /dev/null
fpr=$(gpg --homedir "${sighome}" --with-colons --list-keys 2> /dev/null | awk -F: '$1 == "fpr" {print $10; exit}')
[ -n "${fpr}" ] || {
	echo "test key generation failed" >&2
	exit 2
}
gpg --homedir "${sighome}" --armor --export "${fpr}" > "${work}/test-binhost.asc"

rm -rf "${srv}"
mkdir -p "${srv}/pentoo-signed" "${srv}/pentoo-unsigned" "${srv}/other-unsigned"
mkpkgs() {
	local dir=$1
	shift
	local atom
	for atom in "$@"; do
		PKGDIR=${dir} BINPKG_FORMAT=gpkg FEATURES="-binpkg-signing binpkg-multi-instance compress-index" \
			quickpkg --include-config=y "${atom}" > /dev/null 2>&1 || {
			echo "quickpkg ${atom} into ${dir} failed" >&2
			exit 2
		}
	done
}
mkpkgs "${srv}/pentoo-signed" app-arch/gzip sys-apps/sed
mkpkgs "${srv}/pentoo-unsigned" app-arch/gzip sys-apps/sed
mkpkgs "${srv}/other-unsigned" app-arch/bzip2
while IFS= read -r f; do
	BINPKG_GPG_SIGNING_GPG_HOME=${sighome} BINPKG_GPG_SIGNING_KEY=${fpr} \
		BINPKG_GPG_SIGNING_BASE_COMMAND="/usr/bin/gpg --sign --armor [PORTAGE_CONFIG]" \
		gpkg-sign --allow-unsigned "${f}" > /dev/null 2>&1 || {
		echo "gpkg-sign ${f} failed" >&2
		exit 2
	}
done < <(find "${srv}/pentoo-signed" -name '*.gpkg.tar')
for d in pentoo-signed pentoo-unsigned other-unsigned; do
	PKGDIR=${srv}/${d} FEATURES="binpkg-ignore-signature compress-index" emaint binhost --fix > /dev/null 2>&1 || {
		echo "emaint binhost --fix failed for ${d}" >&2
		exit 2
	}
done

python3 -m http.server "${port}" --bind 127.0.0.1 --directory "${srv}" > "${work}/httpd.log" 2>&1 &
httpd=$!
for _ in $(seq 50); do
	python3 -c "import urllib.request,sys; urllib.request.urlopen('${signed}/Packages')" 2> /dev/null && break
	sleep 0.2
done
python3 -c "import urllib.request,sys; urllib.request.urlopen('${signed}/Packages')" 2> /dev/null || {
	echo "local binhost doesn't answer" >&2
	exit 2
}
info "test key ${fpr}"

#### a
echo "== signature enforcement"
reset_client
gen_conf "${signed}" > /dev/null
check "a: no trust, false entry, signed package installs" client_emerge "${signed}" --getbinpkgonly app-arch/gzip

#### b
reset_client
check "b: no trust, no entry, signed package is rejected" unusable client_emerge "${signed}" --getbinpkgonly app-arch/gzip

#### c
reset_client
gen_conf "${signed}" > /dev/null
client_emerge "${signed}" --getbinpkgonly app-arch/gzip > /dev/null 2>&1
if out=$(PORTAGE_BINHOST='' FEATURES="-getbinpkg" emerge --oneshot --nodeps --usepkgonly app-arch/gzip 2>&1); then
	info "c: signed package downloaded under a false entry was reused offline without trust: accepted"
else
	info "c: signed package downloaded under a false entry was reused offline without trust: rejected"
fi
indent <<< "${out}" | tail -n 4
reset_client
gen_conf "${signed}" > /dev/null
client_emerge "${signed}" --getbinpkgonly app-arch/gzip > /dev/null 2>&1
mkdir -p "${pkgdir}/app-arch/gzip"
cp /var/cache/binhost/pentoo-binhost-1/app-arch/gzip/*.gpkg.tar "${pkgdir}/app-arch/gzip/"
FEATURES="binpkg-ignore-signature" emaint binhost --fix > /dev/null 2>&1
if out=$(PORTAGE_BINHOST='' FEATURES="-getbinpkg" emerge --oneshot --nodeps --usepkgonly app-arch/gzip 2>&1); then
	info "c: the same package copied into the local PKGDIR and installed without trust: accepted"
else
	info "c: the same package copied into the local PKGDIR and installed without trust: rejected"
fi
indent <<< "${out}" | tail -n 4

#### d
reset_client
check "d: trust helper runs" trust
check "d: test key has full validity" test "$(keyfield /etc/portage/gnupg 2)" = f
sed 's/^verify_signature=false$/verify_signature=true/' "${gen}" > "${work}/gen-true"
chmod +x "${work}/gen-true"
gen_conf "${signed}" "${work}/gen-true" > /dev/null
check "d: trusted key, true entry, signed package installs" client_emerge "${signed}" --getbinpkgonly app-arch/gzip

#### e
reset_client
trust > /dev/null 2>&1
gen_conf "${unsigned}" "${work}/gen-true" > /dev/null
check "e: trusted key, true entry, unsigned package is rejected" unusable client_emerge "${unsigned}" --getbinpkgonly app-arch/gzip

#### f
reset_client
trust > /dev/null 2>&1
gen_conf "${signed}" "${work}/gen-true" > /dev/null
PKGDIR=${pkgdir} BINPKG_FORMAT=gpkg FEATURES="-binpkg-signing binpkg-multi-instance" \
	quickpkg --include-config=y app-arch/bzip2 > /dev/null 2>&1
check "f: local unsigned binpkg is unaffected by the true entry" client_emerge "${signed}" --usepkgonly app-arch/bzip2

#### g
reset_client
printf '[other]\nsync-uri = %s\nlocation = /var/cache/binhost/other\nverify-signature = true\n' "${other}" > "${binrepos}/other.conf"
cp "${binrepos}/other.conf" "${work}/other.conf.orig"
gen_conf "${signed} ${other}" > /dev/null
check "g: other binrepos file is untouched" cmp "${binrepos}/other.conf" "${work}/other.conf.orig"
check "g: unsigned package from another repo with verify-signature=true is rejected" \
	unusable client_emerge "${signed} ${other}" --getbinpkgonly app-arch/bzip2
check "g: signed pentoo package still installs next to it" client_emerge "${signed} ${other}" --getbinpkgonly app-arch/gzip

#### h
echo "== trust helper"
reset_client
sigs() {
	local id
	read -r id < /etc/portage/gnupg/mykeyid
	gpg --homedir /etc/portage/gnupg --with-colons --list-sigs "${fpr}" 2> /dev/null |
		awk -F: -v k="${id: -16}" '$1 == "sig" && $5 == k {n++} END {print n + 0}'
}
trust > /dev/null 2>&1
trust > /dev/null 2>&1
check "h: running the helper twice leaves exactly one local signature" test "$(sigs)" = 1
old=$(keyfield /etc/portage/gnupg 7)
GNUPGHOME=${sighome} gpg --batch --passphrase '' --pinentry-mode loopback --quick-set-expire "${fpr}" 2y 2> /dev/null
gpg --homedir "${sighome}" --armor --export "${fpr}" > "${work}/test-binhost.asc"
new=$(keyfield "${sighome}" 7)
trust > /dev/null 2>&1
check "h: extended expiry reaches /etc/portage/gnupg" test "$(keyfield /etc/portage/gnupg 7)" = "${new}" -a "${new}" != "${old}"
check "h: still one local signature after the update" test "$(sigs)" = 1

#### k
echo "== eclean-pkg"
cached_builds() {
	find /var/cache/binhost/pentoo-binhost-1 -name 'gzip-*.gpkg.tar' -printf '%f\n' | sort
}
show_builds() {
	echo "binhost caches and PKGDIR:"
	find /var/cache/binhost "${pkgdir}" -name 'gzip-*' 2> /dev/null
	echo "server:"
	find "${srv}/pentoo-cache" -name 'gzip-*'
	grep -E '^(BUILD_ID|PATH):' "${srv}/pentoo-cache/Packages"
}
holds_two_builds() {
	[ "$(cached_builds | wc -l)" = 2 ] || { show_builds; return 1; }
}
dropped_older_build() {
	[ "$(cached_builds)" = "$(comm -13 <(echo "${first}") <(echo "${both}"))" ] || { show_builds; return 1; }
}
sign_and_index() {
	local f
	while IFS= read -r f; do
		tar -tf "${f}" | grep '\.sig$' > /dev/null && continue
		BINPKG_GPG_SIGNING_GPG_HOME=${sighome} BINPKG_GPG_SIGNING_KEY=${fpr} \
			BINPKG_GPG_SIGNING_BASE_COMMAND="/usr/bin/gpg --sign --armor [PORTAGE_CONFIG]" \
			gpkg-sign --allow-unsigned "${f}" > /dev/null 2>&1
	done < <(find "$1" -name '*.gpkg.tar')
	PKGDIR=$1 FEATURES="binpkg-ignore-signature compress-index" emaint binhost --fix > /dev/null 2>&1
}
if command -v eclean-pkg > /dev/null || emerge --oneshot --quiet --usepkg=n app-portage/gentoolkit > "${work}/gentoolkit.log" 2>&1; then
	cache=${base}/pentoo-cache
	rm -rf "${srv}/pentoo-cache"
	mkpkgs "${srv}/pentoo-cache" app-arch/gzip
	sign_and_index "${srv}/pentoo-cache"
	reset_client
	trust > /dev/null 2>&1
	gen_conf "${cache}" > /dev/null
	check "k: first build downloads into the binhost cache" client_emerge "${cache}" --getbinpkgonly app-arch/gzip
	first=$(cached_builds)
	# If-Modified-Since has one-second resolution, so a rebuild in the same
	# second as the client's download would be answered 304 Not Modified
	sleep 2
	mkpkgs "${srv}/pentoo-cache" app-arch/gzip
	# quickpkg names the second build -2 but copies BUILD_ID and BUILD_TIME from
	# the vdb, so give it what a real rebuild on the build host would have
	python3 -I -c '
import sys, time, portage
from portage import gpkg
p = gpkg.gpkg(portage.settings, gpkg_file=sys.argv[1])
metadata = p.get_metadata()
metadata["BUILD_ID"] = b"2\n"
metadata["BUILD_TIME"] = b"%d\n" % (int(time.time()) + 60)
p.update_metadata(metadata)
' "$(find "${srv}/pentoo-cache" -name 'gzip-*-2.gpkg.tar')"
	sign_and_index "${srv}/pentoo-cache"
	check "k: newer build downloads next to it" client_emerge "${cache}" --getbinpkgonly --rebuilt-binaries=y app-arch/gzip
	both=$(cached_builds)
	check "k: the cache holds both builds" holds_two_builds
	check "k: eclean-pkg --unique-use runs, as pentoo-updater does" eclean-pkg --unique-use
	check "k: it deletes the older build from the binhost cache" dropped_older_build
	check "k: installing from the binhost still works afterwards" client_emerge "${cache}" --getbinpkgonly app-arch/gzip
else
	echo "FAIL k: gentoolkit doesn't install"
	indent < "${work}/gentoolkit.log"
	failed=1
fi

#### i
echo "== generator and helper unit checks"
reset_client
gen_conf "https://example.org/other ${base}/pentoo-a ${base}/pentoo-b" > /dev/null
conf=${binrepos}/pentoo-binhost.conf
check "i: two matching URIs give two sections" test "$(grep -c '^\[' "${conf}")" = 2
check "i: priorities follow the profile order" test \
	"$(awk '/^sync-uri/ {u = $3} /^priority/ {print u "=" $3}' "${conf}" | tr '\n' ' ')" = "${base}/pentoo-a=2 ${base}/pentoo-b=1 "
check "i: verify-signature is false in every section" test \
	"$(grep -c '^verify-signature = false$' "${conf}")" = 2
check "i: the non-matching URI is not written" test "$(grep -c example.org "${conf}")" = 0
gen_conf "https://example.org/other" > /dev/null
check "i: no matching URI removes the file" test ! -e "${conf}"
pentoo_uris="https://pentoo.glpgs.io/Packages/amd64_23.0s-hardened/ https://ftp.acc.umu.se/mirror/pentoo.ch/Packages/amd64_23.0s-hardened/ https://pentoo.osuosl.org/Packages/amd64_23.0s-hardened/ https://www.pentoo.ch/isos/Packages/amd64_23.0s-hardened/ https://pentoo.ch/isos/Packages/x86-hardened/"
other_uris="https://distfiles.gentoo.org/releases/amd64/binpackages/23.0/x86-64/ https://pentoo.ch.example.org/isos/Packages/ https://notpentoo.ch/isos/Packages/ https://www.pentoo.ch/other/Packages/"
env -u PENTOO_BINHOST_MATCH PORTAGE_BINHOST="${other_uris} ${pentoo_uris}" "${gen}" > /dev/null
check "i: the default match takes every Pentoo mirror, pentoo.ch included" test \
	"$(awk '/^sync-uri/ {print $3}' "${conf}" | tr '\n' ' ')" = "$(for u in ${pentoo_uris}; do printf '%s ' "${u%/}"; done)"
rm -f "${conf}"
rm -rf "${binrepos}"
touch "${binrepos}"
cp "${binrepos}" "${work}/binrepos.orig"
check "i: binrepos.conf as a regular file exits 0" gen_conf "${signed}"
err=$(gen_conf "${signed}" 2>&1 > /dev/null)
check "i: and warns on stderr" test -n "${err}"
check "i: and leaves the file unchanged" cmp "${binrepos}" "${work}/binrepos.orig"
rm -f "${binrepos}"
mkdir -p "${binrepos}"
GNUPGHOME=${sighome} gpg --batch --passphrase '' --pinentry-mode loopback \
	--quick-gen-key 'Other key <other@example.invalid>' nistp384 sign 1y 2> /dev/null
other_fpr=$(gpg --homedir "${sighome}" --with-colons --list-keys other@example.invalid 2> /dev/null | awk -F: '$1 == "fpr" {print $10; exit}')
gpg --homedir "${sighome}" --armor --export "${other_fpr}" > "${work}/other-key.asc"
reset_client
check "i: helper exits non-zero when the key file holds a different fingerprint" expect_fail \
	env PENTOO_BINHOST_KEY="${work}/other-key.asc" PENTOO_BINHOST_FPR="${fpr}" bash "${helper}"

#### j
reset_client
check "j: helper refuses a key file that is not the expected key" expect_fail \
	env PENTOO_BINHOST_KEY="${work}/test-binhost.asc" PENTOO_BINHOST_FPR=FFB957A9397712C1EC079E30BE0908FC837B76F4 bash "${helper}"
check "j: and imports nothing" test -z "$(keyfield /etc/portage/gnupg 5)"

#### n
echo "== a rejected binpkg"
reset_client
rm -rf /var/db/pkg/app-arch/gzip-*/BINPKGMD5
if client_emerge "${signed}" --getbinpkg --keep-going=y app-arch/gzip > "${work}/n.log" 2>&1; then
	if compgen -G "/var/db/pkg/app-arch/gzip-*/BINPKGMD5" > /dev/null; then
		info "n: no trust, signed binpkg, --getbinpkg: installed the binpkg"
	else
		info "n: no trust, signed binpkg, --getbinpkg: emerge succeeded by building from source"
	fi
else
	info "n: no trust, signed binpkg, --getbinpkg: emerge failed"
fi
grep -iE 'not usable|verification|>>> (emerging|compiling)|failed to emerge|emerge \(1 of' "${work}/n.log" | head -8 | indent

#### l
echo "== callers of the helper"
real_fpr=FFB957A9397712C1EC079E30BE0908FC837B76F4
real_validity() {
	gpg --homedir /etc/portage/gnupg --with-colons --list-keys "${real_fpr}" 2> /dev/null |
		awk -F: '$1 == "pub" {print $2; exit}'
}
mkdir -p /etc/portage/repos.conf
printf '[pentoo]\nlocation = %s\n' "${src}" > /etc/portage/repos.conf/pentoo-test.conf
reset_client
check "l: postsync hook exits 0" sh "${src}/pentoo/pentoo-core/files/pentoo-trust-postsync"
check "l: it trusts the binhost key from the synced repo" test "$(real_validity)" = f
reset_client
check "l: postsync hook still exits 0 when the helper fails" \
	env PENTOO_BINHOST_FPR=0000000000000000000000000000000000000000 sh "${src}/pentoo/pentoo-core/files/pentoo-trust-postsync"
rm -f /etc/portage/repos.conf/pentoo-test.conf

#### m
reset_client
install -m 0755 "${helper}" /usr/bin/pentoo-trust-helper
check "m: the installed helper fails without the installed key" expect_fail pentoo-trust-helper
install -D -m 0644 "${src}/sec-keys/openpgp-keys-pentoo-release/files/pentoo-release.asc" /usr/share/openpgp-keys/pentoo-release.asc
check "m: the installed helper runs, as the postsync fallback and PORTAGE_TRUST_HELPER do" pentoo-trust-helper
check "m: it trusts the binhost key from /usr/share/openpgp-keys" test "$(real_validity)" = f
check "m: and runs again without changes" pentoo-trust-helper
rm -f /usr/bin/pentoo-trust-helper /usr/share/openpgp-keys/pentoo-release.asc

if [ "${failed}" = 0 ]; then
	echo "all checks passed"
else
	echo "some checks FAILED"
fi
exit "${failed}"
