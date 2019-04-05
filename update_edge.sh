#!/bin/sh -e

# Prevent concurrent builds
# Three processes are expected when executed via crontab
if [ "$(pgrep --count --full $0)" -gt 3 ]; then
	exit
fi

# Query latest Zig build
tarball=$(curl https://ziglang.org/download/index.json | jq --raw-output '.master."x86_64-linux".tarball')

cd $(dirname $0)

if [ "$tarball" = "$(cat last_build)" ]; then
	echo "No change since last build ($tarball)"
	exit
fi

echo "Snapping $tarball"

# Setup working directory
git clean --force -x --exclude=last_build
sed --in-place "s,source: .*,source: $tarball," snapcraft.yaml

# Build the snap
export SNAPCRAFT_BUILD_ENVIRONMENT_MEMORY=300M
snapcraft snap --output zig.snap
snapcraft push zig.snap --release edge

echo $tarball > last_build
