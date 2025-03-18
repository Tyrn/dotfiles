## Debian
### Miscellaneous

- Apt:
```
# vi /etc/apt/sources.list
```
- `sudo`:
```
# apt-get install sudo
# /sbin/adduser username sudo
```
- VBox:
```
$ sudo sh /mnt/VBoxLinuxAdditions.run
$ sudo adduser $USER vboxsf
```
- Time and Date:
```
$ timedatectl set-timezone Europe/Moscow
```
- `autojump`:
```
To `~/.bashrc`:    . /usr/share/autojump/autojump.sh
...
$ sudo apt install autojump
```
- Rustup:
```
$ sudo apt install snapd
$ sudo snap install core
$ sudo snap install rustup --classic
$ rustup toolchain install nightly
$ rustup default nightly
```
- [Python](https://computingforgeeks.com/how-to-install-python-on-debian-linux/)
```
$ sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
$ wget https://www.python.org/ftp/python/3.10.1/Python-3.10.1.tgz
$ tar -xf Python-3.10.*.tgz
$ cd Python-3.10.*/
$ ./configure --enable-optimizations
$ nproc
$ make [-j 4]
$ sudo make altinstall
```