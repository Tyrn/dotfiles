# PlatformIO Basics

## References

- nvim-platformio.lua:
  [GitHub](https://github.com/anurag3301/nvim-platformio.lua),
  [Blog](https://anurag3301.com/blog/nvim-platformio-lua/),
  [#20](https://github.com/anurag3301/nvim-platformio.lua/issues/20),
  [#23](https://github.com/anurag3301/nvim-platformio.lua/issues/23),
  [#4950](https://github.com/platformio/platformio-core/issues/4950),
  [AstroNvim](https://github.com/Tyrn/dotfiles/blob/main/dot_config/nvim/lua/plugins/nvim-platformio.lua)

- [PlatformIO Core](https://docs.platformio.org/en/latest/core/index.html)
- [PlatformIO CLI Guide](https://docs.platformio.org/en/latest/core/userguide/index.html)

## Project Essentials

- Install platform

```
pio pkg install -p "platformio/espressif32"
```

- Update platform

```
pio pkg update -p "platformio/espressif32"
```

- Create project in the current directory

```
pio project init -b esp32dev -O framework=arduino --ide=vim
```

- Create/update `.ccls` file if necessary

```
pio project init --ide=vim
```

- Build project

```
pio run
```

- Upload project

```
pio run -t upload
```

- Clean project

```
pio run -t clean
```
