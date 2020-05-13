#!/bin/sh
pentoo_repo=$(portageq get_repo_path / pentoo)
#this is a safety check to make sure we aren't force resetting a dev's environment
if ! grep 'git@github.com:pentoo/pentoo-overlay.git' "${pentoo_repo}/.git/config"; then
  if cd "${pentoo_repo}"; then
    git reset --hard origin
    git clean -fd
    git clean -fx
  fi
  #we don't set shallow by default anymore, but if it was installed shallow it stays that way
  if [ -f "${pentoo_repo}/.git/shallow" ]; then
      git fetch --fatten
  fi
else
  printf "Not hard resetting git on developer machine\n"
fi
