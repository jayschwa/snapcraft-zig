#!/bin/sh -e

snap=zig.snap
master=https://s3.amazonaws.com/ziglang.org/builds/zig-linux-x86_64-master.tar.xz
location=$(curl --head --silent $master | grep location | tr -d '\r\n' | awk '{print $2}')
version=$(basename $location .tar.xz | cut -c18-)

cd $(dirname $0)

if [ "$version" = "$(cat last_build)" ]; then
	echo "no change since last build"
	exit
fi

git clean --force -x --exclude='last_build'
sed --in-place "s/version: .*/version: $version/" snapcraft.yaml
snapcraft snap --output $snap
snapcraft push $snap --release edge

echo $version > last_build
