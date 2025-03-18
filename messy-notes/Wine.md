## Wine Windows API Emulator
### Miscellany
#### Random House boldface problem

`LANG=ru_RU.UTF-8 wine /home/alexey/common/WinApps/random/rhudwcd.exe`

Do not forget sudo locale-gen (?)
```
$ locale -a
C
en_US.utf8
POSIX
ru_RU.utf8
```

#### Usage
```
$ winecfg
$ wine control     # Remove apps, etc.
```

#### KOMPAS-3D

- [WINE Setup for Ubuntu](https://habr.com/ru/companies/ascon/articles/715710/)

- WINE Setup for Arch Linux family

Remove WINE config whenever you want clean reinstall:
```
$ rm -rf ~/.wine
```
Install WINE, tools and dependencies:
```
$ yay -S wine-mono
$ yay -S winetricks
$ winetricks -q dotnet48
$ winetricks -q d3dcompiler_47
$ winetricks -q msxml3 msxml4 msxml6
$ winetricks -q corefonts
$ winetricks vcrun2019 riched20
```
`cd` to the downloaded distribution subdirectory (KOMPAS-3D v21 x64/KOMPAS-3D v21 x64):
```
$ wine msiexec /i KOMPAS-3D_v21_x64.msi
```
