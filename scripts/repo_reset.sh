#!/bin/sh
pentoo_repo=$(portageq get_repo_path / pentoo)
#this is a safety check to make sure we aren't force resetting a dev's environment
if ! grep 'git@github.com:pentoo/pentoo-overlay.git' "${pentoo_repo}/.git/config"; then
  if cd "${pentoo_repo}"; then
    #should probably add some "is this needed?" detection in here
    git reset --hard origin
    git clean -fd
    git clean -fx
  fi
else
  printf "Not hard resetting git on developer machine\n"
fi
