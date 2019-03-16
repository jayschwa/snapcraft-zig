#!/bin/sh -e

# Query latest Zig version from URL
master=https://s3.amazonaws.com/ziglang.org/builds/zig-linux-x86_64-master.tar.xz
location=$(curl --head --silent $master | grep location | tr -d '\r\n' | awk '{print $2}')
version=$(basename $location .tar.xz | cut -c18-)

cd $(dirname $0)

if [ "$version" = "$(cat last_build)" ]; then
	echo "no change since last build"
	exit
fi

# Setup working directory
git clean --force -x --exclude='last_build'
sed --in-place "s/version: .*/version: $version/" snapcraft.yaml

# Build the snap
export SNAPCRAFT_BUILD_ENVIRONMENT_MEMORY=300M
snapcraft snap --output zig.snap
snapcraft push zig.snap --release edge

echo $version > last_build
