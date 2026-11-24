# MTP (Media Transfer Protocol)

## Manual usage (via terminal)

- Utilities
  - [mtp-rs](https://github.com/vdavid/mtp-rs/tree/main/crates/mtp-rs)
    Rust library
  - [mtp-rs-cli](https://github.com/vdavid/mtp-rs/blob/main/crates/mtp-rs-cli/docs/cli.md)
    file transfer utility
  - [mtp-mount](https://github.com/vdavid/mtp-mount)
    and `mtp-mountd`
  - [Android File Transfer](https://github.com/whoozle/android-file-transfer-linux)

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

  - A (sometimes) useful check

        mount | grep mtp

- Mounting with `aft-mtp-mount` (Android File Transfer)
  - Mount

        aft-mtp-mount ~/mnt/phone

  - Unmount

        fusermount -u $HOME/mnt/phone

## Quirks

- `lfs`: not good enough for `shfmt` because of `zsh` syntax

      # Check your favorite MTP phone directory.
      # Requires manual configuration (chezmoi.toml).
      #
      # Usage, simple and advanced:
      #
      #   lz phoneKey
      #   lz phoneKey '*Martin*'
      #
      function lz() {
        local key="${1}"
        shift 1
        local value; value=$(get_chezmoi_value "$key")
        if [[ "$value" == 🔸* ]]; then
          printf '%s should have an entry like this:\n[data]\n...\n%s = "%s"\n %s\n' \
            "$chezmoi_toml" "$key" "/storage/something" "⛵"
        fi

        local base="$mtp_mountpoint$value"
        if (( $# )); then
          local -a paths=()
          local p
          for p in "$@"; do
            # shellcheck disable=SC2296,SC1036,SC2206
            local -a hit=( "$base"/${~p}(N) )
            if (( ${#hit[@]} )); then
              paths+=( "${hit[@]}" )
            else
              printf 'lz: no match: %q\n' "$base/$p" >&2
              paths+=( "$base/$p" )
            fi
          done
          lf "${paths[@]}"
        else
          li "$base"
        fi
      }
