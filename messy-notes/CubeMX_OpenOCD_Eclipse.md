## CubeMX OpenOCD Eclipse project

##### Abandoned; links, bits and pieces here.

---

_Arch Linux Take_

#### Assumed:

[Basic GNU MCU Eclipse Installation](https://github.com/Tyrn/dotfiles/blob/main/messy-notes/GNU_MCU_Eclipse.md)

- Eclipse and GNU MCU Plugins
- `gcc-arm-none-eabi` in `/opt/arm/bin`
- `st-util` and `st-flash` in `/usr/bin` (stlink package)
- `autoconf` in `/usr/bin`

### Further configuration

#### Install OpenOCD

`yaourt -S openocd --noconfirm`

#### Install CubeMX

`yaourt -S stm32cubemx`

#### Configure Eclipse External Tools

- Name: `st-flash Debug`
- Main/Location: `/usr/bin/st-flash`
- Main/Working Directory: `${project_loc}/Debug`
- Main/Arguments: `write ${project_name}.bin 0x8000000`

---

- Name: `st-flash Release`
- Main/Location: `/usr/bin/st-flash`
- Main/Working Directory: `${project_loc}/Release`
- Main/Arguments: `write ${project_name}.bin 0x8000000`

#### Eclipse Debug Configurations

##### GDB OpenOCD Debugging

- Main/Project: `${project_name}`
- Main/C/C++ Application: `${project_loc}/Debug/${project_name}.elf`
- Debugger/Executable: `${openocd_path}/${openocd_executable}`
- Debugger/Client/Executable: `${cross_prefix}gdb${cross_suffix}`
- Debugger/Client/Commands: `set mem inaccessible-by-default off`

---

- Main/Config options: `-f /usr/share/openocd/scripts/interface/stlink-v2.cfg`
- Debugger/Executable: `/usr/bin/openocd`
- Debugger/Client/Executable: `${cross_prefix}gdb${cross_suffix}`
- Debugger/Client/Commands: `set mem inaccessible-by-default off`

##### Troubleshooting

[OpenOCD and Eclipse](https://stackoverflow.com/questions/48853797/stm32f103-stlink-v2-openocd-open-failed/)
