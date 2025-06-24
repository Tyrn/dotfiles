# PlatformIO Basics

## References

- nvim-platformio.lua:
  [GitHub](https://github.com/anurag3301/nvim-platformio.lua),
  [Blog](https://anurag3301.com/blog/nvim-platformio-lua/),
  [#20](https://github.com/anurag3301/nvim-platformio.lua/issues/20),
  [#23](https://github.com/anurag3301/nvim-platformio.lua/issues/23),
  [#25](https://github.com/anurag3301/nvim-platformio.lua/issues/25)
  [#4950](https://github.com/platformio/platformio-core/issues/4950),
  [AstroNvim](https://github.com/Tyrn/dotfiles/blob/main/dot_config/nvim/lua/plugins/nvim-platformio.lua)

- [PlatformIO Core](https://docs.platformio.org/en/latest/core/index.html)
- [PlatformIO CLI Guide](https://docs.platformio.org/en/latest/core/userguide/index.html)

## Misc

- To enable HID bootloader (for STM32)

```
yay -S hid-flash
```

## Project Essentials

### Platform

- List all available platforms (requires correction as of 2025-06-14)

```
pio pkg search "platform:*"
```

- Install platform

```
pio pkg install -p "platformio/espressif32"
```

- Update platform

```
pio pkg update -p "platformio/espressif32"
```

- Install tool globally

```
pio pkg install -g -t "platformio/tool-stm32duino"
```

### Project configuration

- Standard project directories are `include` `lib` `src` `test`

- Create project in the current directory

```
pio project init -b esp32dev -O framework=arduino --ide=vim
```

- Install a standard library

```
pio pkg install -l arkhipenko/TaskScheduler
```

- Install a library from GitHub

```
pio pkg install -l git@github.com:Tyrn/LCD_1602_RUS_ALL.git
```

- Unistall a library

```
pio pkg uninstall -l git@github.com:Tyrn/LCD_1602_RUS_ALL.git
```

- Create/update `.ccls` file if necessary

```
pio project init --ide=vim
```

### Build and run

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
