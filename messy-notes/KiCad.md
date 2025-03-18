## KiCad
### Install

- Advanced/nightly version
```
$ yay -S kicad-git
```
- Symbols and footprints (version directory is subject to change)
```
$ cd ~/.local/share/kicad/7.99/symbols
$ git clone https://gitlab.com/kicad/libraries/kicad-symbols.git
$ cd ~/.local/share/kicad/7.99/footprints
$ git clone https://gitlab.com/kicad/libraries/kicad-footprints.git
```
Accept them via *Preferences > Manage Symbol/Footprint Libraries...*

### Files

- `*.dcm` descriptions, aliases and keywords for library symbols

- `*.bck` backup for `*.dcm`

- `*.pro` project

- `*.sch` schematic

- `*.bak` backup for `*.sch`

- `*.lib` schematic symbols library

- `*.dsn` Specctra Design

- `*.ses` Specctra Session

- `*.net` netlist
