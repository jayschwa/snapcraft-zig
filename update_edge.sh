#!/bin/sh -e

user=ziglang
repo=zig
branch=master
snap=zig_git_amd64.snap

github_api_url=https://api.github.com/repos/$user/$repo/branches/$branch
latest_commit=$(curl --silent $github_api_url | jq --raw-output .commit.sha)
commit_file=${user}_${repo}_${branch}_commit

if [ "$latest_commit" = "$(cat $commit_file)" ]; then
	echo "no changes since last build"
	exit
fi

git clean --force -x --exclude='*_commit'
snapcraft cleanbuild
snapcraft push $snap --release edge

echo $latest_commit > $commit_file
