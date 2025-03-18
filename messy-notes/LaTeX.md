## LaTeX

#### Tex Live, manual installation:

- Remove `texlive-bin`:
```
$ yay -R texlive-bin
```
- Trim whatever remains:
```
$ fmtutil-sys --all
```
- Satisfy Arch package management:
```
$ yay -S texlive-dummy
```
- Download and install texlive: [current options](https://www.tug.org/texlive/acquire.html);
[current ISO](https://www.tug.org/texlive/acquire-iso.html);
[2021 ISO](http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2021/)
```
$ md5sum -c texlive2021-20210325.iso.md5
$ sudo mkdir /mnt/iso
$ sudo mount -o loop texlive2021-20210325.iso /mnt/iso
$ sudo ./install-tl
...
$ sudo umount /mnt/iso
```
- Add your texlive path to `~/.[x]profile`(do not use `~/.bashrc`!):
```
export PATH=/usr/local/texlive/2021/bin/x86_64-linux:$PATH
```

#### TeXstudio:
To restore a saved profile:

- Delete `~/.config/texstudio/texstudio.ini`
- Copy your `*.txsprofile` to `texstudio.ini`

#### Cheat sheet example:
```
https://github.com/pmiossec/tig-cheat-sheet
```

#### Format

- `latexindent`:
```
$ latexindent -w -s <target>
```

#### PDF

- LaTeX, pdfpages; extracting pages 167..173 from ScalaReference.pdf
```
$ pdfjam -o scala_syntax_167_173.pdf ScalaReference.pdf 167,168,169,170,171,172,173

$ pdfjam -o scala_syntax_167_173.pdf ScalaReference.pdf 167-173
```
