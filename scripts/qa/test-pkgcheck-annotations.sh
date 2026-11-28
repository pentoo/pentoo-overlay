#!/bin/bash
# Check that .github/actions/pkgcheck annotates every pkgcheck failure: run
# the action's script in the pkgcheck image on a small repo with known errors,
# and check that GitHub would take each ::error line as a workflow command.
# Also runs pkgcore/pkgcheck-action@v1 the same way, and says when it no longer
# loses the first annotation, so ours can go.  Needs docker, python3 with
# PyYAML, and curl.
#
# usage: scripts/qa/test-pkgcheck-annotations.sh

set -euo pipefail

src=$(realpath "$(dirname "$0")/../..")
image=ghcr.io/pkgcore/pkgcheck:latest
work=$(mktemp -d)
trap 'rm -rf "${work}"' EXIT

mkdir -p "${work}"/repo/{metadata,profiles,app-misc/foo}
printf 'masters =\nrepo-name = annotations-test\nthin-manifests = true\n' > "${work}"/repo/metadata/layout.conf
echo annotations-test > "${work}"/repo/profiles/repo_name
echo amd64 > "${work}"/repo/profiles/arch.list
for v in 1 2; do
	cat > "${work}/repo/app-misc/foo/foo-${v}.ebuild" <<-'EOF'
		EAPI=8
		DESCRIPTION="test"
		HOMEPAGE="https://example.org"
		SRC_URI="https://example.org/${P}.tar.gz"
		LICENSE="MIT"
		SLOT="0"
		KEYWORDS="~amd64"
	EOF
done

# prints the bash script the action's pkgcheck step runs
action_script() {
	python3 - "$1" <<-'EOF'
		import shlex, sys, yaml
		action = yaml.safe_load(open(sys.argv[1]))
		step = next(s for s in action["runs"]["steps"] if s.get("uses", "").startswith("docker://"))
		args = shlex.split(step["with"]["args"])
		assert args[0] == "-c", args
		print(args[1].replace("${{ inputs.path }}", ".").replace("${{ inputs.args }}", "--exit error -k error"))
	EOF
}

# runs an action.yml's script; prints how many ::error lines it gave and how
# many of them start their line
run_action() {
	local name=$1 home="${work}/home-$1"
	mkdir -p "${home}"
	action_script "$2" > "${work}/${name}.sh"
	docker run --rm --user "$(id -u):$(id -g)" -e HOME=/home -v "${work}/repo:/repo:ro" -v "${home}:/home" \
		-v "${work}/${name}.sh:/action.sh:ro" -w /repo --entrypoint /usr/bin/bash \
		"${image}" /action.sh > "${work}/${name}.out" 2>&1 || true
	echo "$(grep -c '::error' "${work}/${name}.out") $(grep -c '^::error' "${work}/${name}.out")"
}

docker pull -q "${image}" > /dev/null

read -r total parsed < <(run_action ours "${src}/.github/actions/pkgcheck/action.yml")
echo "ours: ${parsed} of ${total} ::error lines start their line"
if [ "${total}" -lt 3 ] || [ "${parsed}" != "${total}" ]; then
	echo "FAIL: .github/actions/pkgcheck/action.yml: GitHub would miss $((total - parsed)) of ${total} annotations (or the test repo stopped failing)"
	sed 's/^/    /' "${work}/ours.out" | cat -v
	exit 1
fi

curl -fsSL https://raw.githubusercontent.com/pkgcore/pkgcheck-action/v1/action.yml -o "${work}/upstream.yml"
read -r total parsed < <(run_action upstream "${work}/upstream.yml")
echo "pkgcore/pkgcheck-action@v1: ${parsed} of ${total} ::error lines start their line"
if [ "${total}" -ge 3 ] && [ "${parsed}" = "${total}" ]; then
	echo "::notice title=pkgcheck-action::pkgcore/pkgcheck-action@v1 no longer loses annotations, so .github/workflows/pkgcheck.yaml can use it again"
fi
