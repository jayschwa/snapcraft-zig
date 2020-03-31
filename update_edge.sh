#!/bin/sh -e

# Prevent concurrent builds
# Three processes are expected when executed via crontab
if [ "$(pgrep --count --full $0)" -gt 3 ]; then
	exit
fi

# Query latest Zig build
VERSION=$(curl --silent https://ziglang.org/download/index.json | jq --raw-output '.master.src.tarball' | grep -o '/zig-.*\.tar' | cut -c 6- | rev | cut -c 5- | rev)

cd $(dirname $0)

if [ "$VERSION" = "$(cat last_build)" ]; then
	echo "No change since last build ($VERSION)"
	exit
fi

# Clean working directory
git clean --force -x --exclude=last_build

# Build and upload snap
TARBALL=$(curl --silent https://ziglang.org/download/index.json | jq --raw-output '.master."x86_64-linux".tarball')
echo "Creating snap for $TARBALL"
SNAP=$(./snaphack $VERSION amd64 $TARBALL | tail -1)
echo "Uploading $SNAP"
snapcraft push $SNAP --release edge

echo $VERSION > last_build
