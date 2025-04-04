## CubeMX SW4STM32 (Ac6) Eclipse project

_Arch Linux Take_

### Installation

#### Install Eclipse (legacy)

```
$ yaourt -S eclipse-java
```

Eclipse upgrade is destructive, so `/etc/pacman.conf`:
`IgnorePkg  = eclipse-java eclipse-common`

_NB_ `eclipse-php` or `eclipse-cpp` will do; the latter has CDT plugins preinstalled.

#### Install Eclipse CDT plugin (legacy)

Install CDT, CDT SDK, and C/C++ Unit Testing Support via `Help > Install New Software...`

The working version: http://download.eclipse.org/tools/cdt/releases/9.3

Newer releases will ~~probably~~ work, too.

#### Install Eclipse SW4STM32 plugin (legacy)

Install System Workbench for STM32 - Bare Machine edition via `Help > Install New Software...`

http://ac6-tools.com/Eclipse-updates/org.openstm32.system-workbench.update-site-v2

[Install Emb Sys Registers plugin](https://mcuoneclipse.com/2017/07/26/embsysregview-0-2-6-for-eclipse-neon-and-oxygen/) (In `/usr/lib/eclipse/plugins`)

#### Install STM32CubeMX (legacy)

```
yaourt -S stm32cubemx
```

The utility is also available as an Eclipse plugin; the standalone application may be easier on your system, though.

NB Manual installaiton can be less troublesome:

- Unpack factory archive and install in `~/STM32CubeMX`

- Create `/usr/bin/stm32cubemx`:

```
#/usr/bin/env bash
exec $HOME/STM32CubeMX/STM32CubeMX
```

- `sudo chmod +x /usr/bin/stm32cubemx`

#### Install STM32CubeIDE

- [Download](https://aur.archlinux.org/packages/stm32cubeide) (Pinned Comment)

```
$ yay -S stm32cubeide
```

- Install [Linux Tools](http://wiki.eclipse.org/Linux_Tools_Project/PluginInstallHelp) Eclipse Plugin, `http://download.eclipse.org/linuxtools/update` (C/C++ Call Graph Visualization and a lot more)

- Install ST-Link and put in place [/etc/udev/rules.d/69-probe-rs.rules](https://probe.rs/docs/getting-started/probe-setup/):

```
# Copy this file to /etc/udev/rules.d/
# If rules fail to reload automatically, you can refresh udev rules
# with the command "udevadm control --reload"

# This rules are based on the udev rules from the OpenOCD project, with unsupported probes removed.
# See http://openocd.org/ for more details.
#
# This file is available under the GNU General Public License v2.0

ACTION!="add|change", GOTO="probe_rs_rules_end"

SUBSYSTEM=="gpio", MODE="0660", GROUP="plugdev", TAG+="uaccess"

SUBSYSTEM!="usb|tty|hidraw", GOTO="probe_rs_rules_end"

# Please keep this list sorted by VID:PID

# STMicroelectronics ST-LINK V1
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3744", MODE="660", GROUP="plugdev", TAG+="uaccess"

# STMicroelectronics ST-LINK/V2
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3748", MODE="660", GROUP="plugdev", TAG+="uaccess"

# STMicroelectronics ST-LINK/V2.1
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3752", MODE="660", GROUP="plugdev", TAG+="uaccess"

# STMicroelectronics STLINK-V3
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374d", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374e", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374f", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3753", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="0483", ATTRS{idProduct}=="3754", MODE="660", GROUP="plugdev", TAG+="uaccess"

# SEGGER J-Link
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0101", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0102", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0103", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0104", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0105", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0107", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="0108", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1010", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1011", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1012", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1013", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1014", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1015", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1016", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1017", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1018", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1051", MODE="660", GROUP="plugdev", TAG+="uaccess"
ATTRS{idVendor}=="1366", ATTRS{idProduct}=="1061", MODE="660", GROUP="plugdev", TAG+="uaccess"


# CMSIS-DAP compatible adapters
ATTRS{product}=="*CMSIS-DAP*", MODE="660", GROUP="plugdev", TAG+="uaccess"

LABEL="probe_rs_rules_end"
```

If you don't care to relogin:

```
$ sudo udevadm control --reload
$ sudo udevadm trigger
```

ST-Link, at last:

```
$ yay -S stlink-git
$ st-info --probe
...
  chipid:     0x410    ;; Must not be zero.
...
```

- Install STLinkUpgrade (Disconnect from the Pill before running `$ STLinkUpgrade`!)

```
$ yay -S stsw-link007
```

### Configuration

#### Create CubeMX project

Resources:

[DAC, DMA, ADC, USB, VCP](https://habrahabr.ru/post/310742/) (3 parts, Russian)

[FreeRTOS](https://habrahabr.ru/post/249273/) (5 parts, Russian)

[Carmine Noviello. _Mastering STM32_, examples](https://github.com/cnoviello/mastering-stm32)

[Kento Watanabe. _Introduction to STM32 ARM Microcontroller with STM HAL Library & SW4STM32_, examples](https://github.com/meerstern/stm32introductory)

Example:

[Blinky](https://www.exclude.se/2017/06/02/stm32f103c8t6-st-link-v2-blinky-example/), the Blue Pill on STLink/V2

Guidelines:

- Select project location inside Eclipse workspace; the project gets imported in place.
- In case of STLink do _not_ forget to set `Pinout > Configuration > Peripherals > SYS > Debug` to `Serial Wire`. See `[project].xml` in your project directory.

#### Import and configure Eclipse SW4STM32 project

- Make sure that your Eclipse is running.
- Run `Project > Generate Code` of your STM32CubeMX app.
- Once code generation is done, select `Open Project`. If everything is correct, the Eclipse project is imported hands off, no user interaction required.
- In case the Eclipse project won't import hands off after all, import it [manually](http://www.openstm32.org/Importing%2Ba%2BSTCubeMX%2Bgenerated%2Bproject). `Import > General > Existing Projects into Workspace`; `Select root directory`; all options unchecked.

#### GDB Eclipse

- Main/Project: `myproject`

- Main/Application: `Debug/myproject.elf`

- Main/Disable auto build

- Main/Mcu: `STM32F103C8Tx`

- Main/Board: `myproject`

- Debugger/GDB Command: `${openstm32_compiler_path}/arm-none-eabi-gdb`; as of 2018-10-26 `/usr/bin/arm-none-eabi-gdb`

- Debugger/OCD Command: `"${openstm32_openocd_path}/openocd"`

- Debugger/Port: `3333`

- Debugger/Configuration Script/Automated generation `check`

- Debugger/Script file: `${ProjDirPath}/galvanix Debug.cfg`

- Debugger/Interface: `SWD`

- Debugger/Frequency: `4 MHz`

- Debugger/Reset mode: `Software system reset`

- Debugger/Enable debug in low-power modes `check`

- Debugger/Stop watchdog counters when halt `check`

- Startup/Reset and delay `uncheck`

- Startup/Halt `uncheck`

#### Semihosting

[Eclipse configuration](http://alphaloewe.com/2017/01/24/enable-semi-hosting-with-openstm32-system-workbench/)

##### Eclipse Debug configuration (OpenOCD)

- Add filter: `Project properties > C/C++ General > Paths and Symbols > Source Locations: /myproject/Core` a filter: `Src/syscalls.c`

- Append to `Project properties > C/C++ Build > Settings > Tool Settings > MCU GCC Linker > Libraries: Libraries` the following: `rdimon`.

- Append to `Project properties > C/C++ Build > Settings > Tool Settings > MCU GCC Linker > Miscellaneous > Linker/Other flags` the following: ` -specs=rdimon.specs [-lc -lrdimon]` (many `-specs` options separated by space are OK).

- Add to `Debug Configurations > (New Configuration) > Startup > Run Commands` the following: `monitor arm semihosting enable`.

- Declare `extern void initialise_monitor_handles(void);` in the `main.c`.

- Call `initialise_monitor_handles();` after the `MX_GPIO_Init();` in the `int main(void)`.

- Use `printf()` for tracing; manually added `\n` is mandatory.

### TDD

#### CppUTest

[CppUTest](https://cpputest.github.io/), [CppUTest manual](https://cpputest.github.io/manual.html), [CppUTest mocking manual](https://cpputest.github.io/mocking_manual.html)

#### Unity

[Unity](http://www.throwtheswitch.org/white-papers/unity-intro.html), [Unity on GitHub](https://github.com/ThrowTheSwitch/Unity), [docs](https://github.com/ThrowTheSwitch/Unity/tree/master/docs)

#### [Ceedling](Ceedling.md)

#### Fake Function Framework (fff)

[Fake Function Framework, GitHub](https://github.com/meekrosoft/fff)

[CMock vs fff](http://www.electronvector.com/blog/cmock-vs-fff-a-comparison-of-c-mocking-frameworks), [fff plugin for Ceedling](http://www.electronvector.com/blog/more-flexible-mocks-for-ceedling-with-the-fake-function-framework-fff), [GitHub](https://github.com/ElectronVector/fake_function_framework)

### Bits and pieces

#### FreeRTOS

[FreeRTOS](http://blog.mbedded.ninja/programming/operating-systems/freertos), ([The embedded engineering website that’s got your back](http://blog.mbedded.ninja/)), [API Reference](https://www.freertos.org/a00106.html), [CMSIS-RTOS](https://stackoverflow.com/questions/41858814/difference-between-freertos-and-cmsis-rtx)
