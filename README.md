# Snapcraft 💞 Zig

This repository contains [Snapcraft][1] configuration and script files for packaging [Zig][2] into a [snap][3].

[![Zig](https://snapcraft.io/zig/badge.svg)](https://snapcraft.io/zig)

[1]: https://snapcraft.io
[2]: https://ziglang.org
[3]: https://en.wikipedia.org/wiki/Snap_(package_manager)

## Install Zig

To install the latest tagged version of Zig:

```sh
snap install zig --classic --beta
```

Since Zig is undergoing rapid development, stable versions have not been published yet.

Visit https://snapcraft.io/zig to see published versions and more information.

## Build a Zig Snap

Install prerequisites:

- [`aria2c`](https://aria2.github.io)
- [`jq`](https://stedolan.github.io/jq)
- [`minisign`](https://jedisct1.github.io/minisign)
- [`snap` and `snapcraft`](https://snapcraft.io)

Run `zig-to-snap` in this repository.

## Background Service

Start:

```sh
systemd-run --user --unit=zig-to-snap --on-startup=0 --on-unit-inactive=5min --setenv=SNAPCRAFT_STORE_CREDENTIALS=hunter2 $PWD/zig-to-snap master edge
```

Stop:

```sh
systemctl stop --user zig-to-snap.timer
```

Status:

```sh
systemctl status --user zig-to-snap.service
```

Log:

```sh
journalctl --user-unit zig-to-snap.service
```

## Report Problems

If you have a problem, be sure to report it in the correct place:

- [Create issues in this project][4] for problems specific to the Zig snap package.
- For general problems with Zig, head over to the [main Zig project][5].

[4]: https://github.com/jayschwa/snapcraft-zig/issues
[5]: https://codeberg.org/ziglang/zig/issues
