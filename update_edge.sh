#!/bin/sh -e

snap=zig.snap
master=https://ziglang.org/builds/zig-linux-x86_64-master.tar.xz
current=$(curl --head --silent $master | grep location | awk '{print $2}')

cd $(dirname $0)

if [ "$current" = "$(cat last_build)" ]; then
	echo "no change since last build"
	exit
fi

git clean --force -x --exclude='last_build'
snapcraft snap --output $snap
snapcraft push $snap --release edge

echo $current > last_build
