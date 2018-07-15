# Zig + Snapcraft

This repository contains [Snapcraft][1] configuration and script files for packaging [Zig][2] into a [snap][3].

[1]: https://snapcraft.io
[2]: https://ziglang.org
[3]: https://en.wikipedia.org/wiki/Snappy_(package_manager)

## Install Zig

To install a recent development version of Zig:

```
snap install zig --classic --edge
```

Since Zig is undergoing rapid development, stable versions have not been published yet.

Visit https://snapcraft.io/zig to see published versions and more information.

## Build a Zig Snap

1. [Setup the `snapcraft` tool][4].
2. Run `snapcraft cleanbuild` in a copy of this repository.

[4]: https://docs.snapcraft.io/build-snaps/get-started-snapcraft

## Report Problems

If you have a problem, be sure to report it in the correct place:

- [Create issues in this project][5] for problems specific to the Zig snap package.
- For general problems with Zig, head over to the [main Zig project][6].

[5]: https://github.com/jayschwa/zig-snapcraft/issues
[6]: https://github.com/ziglang/zig/issues
