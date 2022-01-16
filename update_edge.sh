#!/bin/sh -e

# Tagged versions are built with command line argument.
version=$1

# Prevent concurrent builds.
# Three processes are expected when executed via crontab.
if [ "$(pgrep --count --full $0)" -gt 3 ]; then
	exit
fi

cd $(dirname $0)

download_json=$(curl --fail --silent https://ziglang.org/download/index.json)

if [ -n "$version" ]; then
	zig_release=$version
else
	zig_release=master
	version=$(echo $download_json | jq --raw-output ".\"$zig_release\".version")
	if [ "$version" = "null" ]; then
		echo "Missing master branch info on ziglang.org"
		exit 1
	fi
	snap_version=$(snap info zig | grep latest/edge | awk '{print $2}')
	if [ "$version" = "$snap_version" ]; then
		echo "Snap and ziglang.org versions are the same ($version)"
		exit
	fi
fi

# Clean working directory.
git clean --force -x

# Build and upload snaps for each architecture
for pair in "aarch64 arm64" "armv7a armhf" "i386 i386" "x86_64 amd64"; do
	zig_arch=$(echo $pair | awk '{print $1}')
	deb_arch=$(echo $pair | awk '{print $2}')
	tarball=$(echo $download_json | jq --raw-output ".\"$zig_release\".\"$zig_arch-linux\".tarball")
	[ "$tarball" = null ] && continue
	echo "Creating $deb_arch snap from $tarball"
	snap=$(./snaphack $version $deb_arch $tarball | grep --only-matching '[[:graph:]]\+\.snap')
	echo "Uploading $snap"
	snapcraft upload $snap --release edge
done
