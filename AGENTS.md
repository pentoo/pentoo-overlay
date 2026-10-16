# Agent and Contributor Notes

## Bumping Go-based ebuilds

Go packages in this overlay fetch a pre-vendored dependency tarball from
[pentoo/pentoo-golang-dist](https://github.com/pentoo/pentoo-golang-dist)
releases (named `<package>-<version>-deps.tar.xz`).

**The workflow must run and succeed before the Manifest can be regenerated.**

### Steps

1. **Trigger the golang-dist workflow** for the package:

   ```
   gh workflow run net-analyzer-nuclei.yml --repo pentoo/pentoo-golang-dist -f version=3.11.1
   ```

   The workflow filename follows the pattern `<category>-<package>.yml`
   (forward slash replaced by hyphen). List all available workflows with:

   ```
   gh workflow list --repo pentoo/pentoo-golang-dist
   ```

2. **Wait for the workflow to finish:**

   ```
   gh run watch <RUN_ID> --repo pentoo/pentoo-golang-dist
   ```

   The run URL is printed by the previous command.

3. **Copy the existing ebuild** to the new version:

   ```
   cp nuclei-3.11.0.ebuild nuclei-3.11.1.ebuild
   ```

   No content changes are needed if the ebuild uses `${PV}` throughout.

4. **Regenerate the Manifest:**

   ```
   ebuild nuclei-3.11.1.ebuild manifest
   ```

   This downloads the source tarball and the deps tarball from
   pentoo-golang-dist releases.

## Bumping nuclei-templates

`nuclei-templates` is not a Go package - it only ships YAML template files.
Copy the ebuild and regenerate the Manifest directly; no workflow is needed.

## github-archive.eclass

Use `github-archive.eclass` whenever an ebuild fetches a source archive
directly from GitHub. It eliminates the boilerplate of setting `SRC_URI`, `S`,
and `HOMEPAGE` by hand.

Set `GITHUB_REPOSITORY="owner/repo"` before inheriting. The eclass supports
four modes:

- **Auto tag from PV** (most common) - set nothing else; the tag is derived as
  `v${PV}` (underscores become hyphens, e.g. PV `1.2_beta1` -> tag
  `v1.2-beta1`):

  ```bash
  GITHUB_REPOSITORY="projectdiscovery/nuclei"
  inherit github-archive
  ```

- **Explicit tag** - when the tag does not follow the `v${PV}` pattern:

  ```bash
  GITHUB_REPOSITORY="owner/repo"
  GITHUB_TAG="release-1.2.3"
  inherit github-archive
  ```

- **Commit snapshot** - pin to a specific commit SHA:

  ```bash
  GITHUB_REPOSITORY="owner/repo"
  GITHUB_COMMIT="12c119fa857ba62ad3d4c23e6a413a8100961a69"
  inherit github-archive
  ```

- **Release asset** - fetch a named asset from GitHub Releases instead of the
  auto-generated source tarball (useful when upstream ships a custom archive):

  ```bash
  GITHUB_REPOSITORY="rizinorg/cutter"
  GITHUB_RELEASE_ASSET="Cutter-v${PV}-src.tar.gz"
  inherit github-archive
  ```

Do NOT use `github-archive.eclass` for Go packages that need a deps tarball
from `pentoo-golang-dist` - those set their own `SRC_URI` explicitly.
