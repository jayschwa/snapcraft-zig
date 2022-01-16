# Snapcraft 💞 Zig

This repository contains [Snapcraft][1] configuration and script files for packaging [Zig][2] into a [snap][3].

[![Zig](https://snapcraft.io/zig/badge.svg)](https://snapcraft.io/zig)

[1]: https://snapcraft.io
[2]: https://ziglang.org
[3]: https://en.wikipedia.org/wiki/Snap_(package_manager)

## Install Zig

To install a recent development version of Zig:

```
snap install zig --classic --edge
```

Since Zig is undergoing rapid development, stable versions have not been published yet.

Visit https://snapcraft.io/zig to see published versions and more information.

## Build a Zig Snap

Install prerequisites:

- [`curl`](https://curl.se)
- [`jq`](https://stedolan.github.io/jq)
- [`snap` and `snapcraft`](https://snapcraft.io)

Run `zig-to-snap` in this repository.

## Report Problems

If you have a problem, be sure to report it in the correct place:

- [Create issues in this project][4] for problems specific to the Zig snap package.
- For general problems with Zig, head over to the [main Zig project][5].

[4]: https://github.com/jayschwa/snapcraft-zig/issues
[5]: https://github.com/ziglang/zig/issues
