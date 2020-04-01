#!/bin/sh -e

# Prevent concurrent builds
# Three processes are expected when executed via crontab
if [ "$(pgrep --count --full $0)" -gt 3 ]; then
	exit
fi

# Query latest Zig build
download_json=$(curl --silent https://ziglang.org/download/index.json)
version=$(echo $download_json | jq --raw-output '.master.version')

cd $(dirname $0)

if [ "$version" = "$(cat last_build)" ]; then
	echo "No change since last build ($version)"
	exit
fi

# Clean working directory
git clean --force -x --exclude=last_build

# Build and upload snap
tarball=$(echo $download_json | jq --raw-output '.master."x86_64-linux".tarball')
echo "Creating snap for $tarball"
snap=$(./snaphack $version amd64 $tarball | tail -1)
echo "Uploading $snap"
snapcraft push $snap --release edge

echo $version > last_build
