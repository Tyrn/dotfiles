# MTP (Media Transfer Protocol)

## Manual usage (via terminal)

- Utilities
  - [mtp-rs](https://github.com/vdavid/mtp-rs/tree/main/crates/mtp-rs)
    Rust library
  - [mtp-rs-cli](https://github.com/vdavid/mtp-rs/blob/main/crates/mtp-rs-cli/docs/cli.md)
    file transfer utility
  - [mtp-mount](https://github.com/vdavid/mtp-mount)
    and `mtp-mountd`

- Mounting with `mtp-mount`
  - Create a custom mount point in your home directory

        mkdir -p ~/mnt/phone

  - Prevent interference (to bring the `kio` machinery back
    just open the _Dolphin_ after unmounting)

        killall -w kiod6

    - The means of checking before and after `killall`

          sudo lsof /dev/libmtp-* 2>/dev/null

  - Mount the one and only plugged-in device
    (in a separate shell)

        mtp-mount ~/mnt/phone
