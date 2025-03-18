## GNU MCU Eclipse project
##### Abandoned; links, bits, and pieces here.
---
_Arch Linux Take_

### Reference
[Blue Pill Review](https://blog.aignacio.com/2017/07/03/http-wiki-stm32duino-com-index-php-title-blue_pill/)

[Debugging](https://gnu-mcu-eclipse.github.io/debug/install/), official

### Installation
#### Install Eclipse
```
$ yaourt -S eclipse-cpp
```
Eclipse upgrade is destructive, so `/etc/pacman.conf`:
`IgnorePkg  = eclipse-cpp eclipse-common`

#### Install the GNU MCU Eclipse plugins
Install plugins using `sudo` (`kdesu` or `gksu`):
```
$ kdesu eclipse &
```
`Help > Install New Software... > Add...`
`https://dl.bintray.com/gnu-mcu-eclipse/updates-test/`

Install all GNU MCU Eclipse plugings.

[Install Emb Sys Registers plugin](https://mcuoneclipse.com/2017/07/26/embsysregview-0-2-6-for-eclipse-neon-and-oxygen/) (In `/usr/lib/eclipse/plugins`)

*NB* `eclipse-workspace` and `Packages` reside in the same directory.

#### Install GNU ARM Embedded Toolchain
From the [ARM developer website](https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads) download Linux 64-bit toolchain archive.
```
$ sudo mkdir /opt/arm
```
Unpack the archive and `cd` to its parent directory. Copy to `/opt/arm` the archive contents, bar the parent directory. Check:
```
gcc-arm-none-eabi-... $ sudo cp -rf * /opt/arm/
gcc-arm-none-eabi-... $ ls /opt/arm/
arm-none-eabi  bin  lib  share
```
Configuring an Eclipse project, make sure to set the Tools Paths:

`Project > Properties > C/C++ Build > Tools Paths`:

- `Build tools folder: /opt/arm/bin`
- `Toolchain folder: /opt/arm`

#### Install GNU ARM Eclipse QEMU

From [GNU MCU Eclipse](https://github.com/gnu-mcu-eclipse/qemu/releases) download the latest GNU ARM Eclipse QEMU release `debian64`; follow the [installation instructions](https://gnu-mcu-eclipse.github.io/qemu/install/):
```
$ mkdir -p ${HOME}/opt
$ cd ${HOME}/opt
$ tar xvf ~/Downloads/gnuarmeclipse-qemu-debian64-...tgz
$ chmod -R -w ${HOME}/opt/gnuarmeclipse/qemu
```
Check:
```
$ ${HOME}/opt/gnuarmeclipse/qemu/2. .../bin/qemu-system-gnuarmeclipse --version
GNU MCU Eclipse 64-bits QEMU emulator version 2. ...
Copyright (c) 2003-2008 Fabrice Bellard
```
Configuring Eclipse (QEMU plugin), make sure to set `qemu_executable` and `qemu_path`:

`Window > Preferences > Run/Debug > QEMU`:

- `Executable: qemu-system-gnuarmeclipse`
- `Folder: /home/user/opt/gnuarmeclipse/qemu/2. .../bin`

#### STM32CubeMX
[Eclipse and STLink configuration (Ru)](http://we.easyelectronics.ru/STM32/stm32cubemx-start-code-eclipse-bystryy-start-otladka-v-eclipse-cherez-st-link-discovery.html)

[Long video](https://www.youtube.com/watch?v=ttqRsBJQu4E)

[OpenOCD, reference](https://gnu-mcu-eclipse.github.io/debug/openocd/)

[Blinky](https://www.exclude.se/2017/06/02/stm32f103c8t6-st-link-v2-blinky-example/), using [CubeMXImporter for Eclipse](https://github.com/cnoviello/CubeMXImporter) and Ac6 plugin

#### Install firmware programmer for STM32 STLINK
```
$ yaourt -S stlink
```
Check:
```
$ whereis st-util
st-util: /usr/bin/st-util
```
- `Run > External Tools > External Tools Configurations... > Program > st-util`: Location: `/usr/bin/st-util`
- Create your configuration under `Run > Debug Configurations... > GDB Hardware Debugging`
[Fine Tuning and Debugging (Ru)](http://pavelruban.org/nastroyka-debaga-arm-cortex-m3-stm32f10x-v-eclipse-s-stlink-v2)

#### Eclipse preferences and Hello World
[Workspace preferences](https://gnu-mcu-eclipse.github.io/eclipse/workspace/preferences/)

[The blinky project](https://gnu-mcu-eclipse.github.io/tutorials/blinky-arm/)

_In case of compilation errors on first run, rebuild project index_:

- `Right Click > Index > Rebuild` on current project

[Packs manager](https://gnu-mcu-eclipse.github.io/plugins/packs-manager/)

_If the Packs perspective lacks the Packs tab and Refresh Packs button, try one of the following_:

- Reset: `Right Click > Reset` on the Packs perspective button
- Make default: `Window > Preferences > General > Perspectives > Packs (Make Default)`
- Add the necessary View: `Window > Show View > Other... (Packs)`

[The project and the device](https://gnu-mcu-eclipse.github.io/eclipse/project/assign-device/)

#### Real world examples

- [PASTILDA: open-source password manager](https://bitbucket.org/thirdpin_team/pastilda)
