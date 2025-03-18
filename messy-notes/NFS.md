## NFS
####SERVER

- `/etc/hosts`:
```
#
# /etc/hosts: static lookup table for host names
#

#<ip-address>	<hostname.domain.org>	<hostname>
127.0.0.1	stovepipebox	localhost.localdomain	localhost
::1	stovepipebox	localhost6.localdomain6	localhost6
192.168.1.33               stovepipebox.localdomain stovepipebox
192.168.1.34               rimfirebox.localdomain rimfirebox
```
- `/etc/fstab`:
```
# 
# /etc/fstab: static file system information
#
# <file system>        <dir>         <type>    <options>          <dump> <pass>

devpts                 /dev/pts      devpts    defaults            0      0
shm                    /dev/shm      tmpfs     nodev,nosuid        0      0

none                   /proc/bus/usb usbfs     auto,busgid=108,busmode=0775,devgid=108,devmode=0664 0 0

/dev/disk/by-label/SwapS swap swap defaults 0 0
/dev/disk/by-label/RootS / ext4 defaults 0 1
/dev/disk/by-label/HomeS /home ext4 defaults 0 1

/home/alexey /export/alexey none bind 0 0
```
- `/etc/exports`:
```
# /etc/exports
#
# See exports(5) for a description.

# use exportfs -arv to reread
#/export    192.168.1.10(rw,no_root_squash)
/export       192.168.1.34(rw,fsid=0,insecure,no_subtree_check,async)
/export/alexey 192.168.1.34(rw,nohide,insecure,no_subtree_check,async)

/etc/conf.d/nfs-common.conf:

# Do you want to start the statd daemon? It is not needed for NFSv4.
NEED_STATD="no"

# Do you want to start the idmapd daemon? It is only needed for NFSv4.
NEED_IDMAPD="yes"

# Do you want to start the gssd daemon? It is required for Kerberos mounts.
NEED_GSSD="no"
```
- `/etc/conf.d/nfs-server.conf`:
```
# Do you want to start the svcgssd daemon? It is only required for Kerberos
# exports. Valid alternatives are "yes" and "no"; the default is "no".
NEED_SVCGSSD="no"

TROUBLESHOOTING (110520):

MOUNTD_OPTS="--no-nfs-version 2"
```

#### CLIENT

- `/etc/hosts`:
```
#
# /etc/hosts: static lookup table for host names
#

#<ip-address>	<hostname.domain.org>	<hostname>
127.0.0.1	rimfirebox	localhost.localdomain	localhost
::1	rimfirebox	localhost6.localdomain6	localhost6
192.168.1.34             rimfirebox.localdomain  rimfirebox
192.168.1.33             stovepipebox.localdomain stovepipebox
# End of file
```
- `/etc/fstab`:
```
# 
# /etc/fstab: static file system information
#
# <file system>        <dir>         <type>    <options>          <dump> <pass>
devpts                 /dev/pts      devpts    defaults            0      0
shm                    /dev/shm      tmpfs     nodev,nosuid        0      0
none /proc/bus/usb usbfs auto,busgid=108,busmode=0775,devgid=108,devmode=0664 0 0

/dev/disk/by-label/SwapX swap swap defaults 0 0
/dev/disk/by-label/RootX / ext4 defaults 0 1
/dev/disk/by-label/HomeX /home ext4 defaults 0 1

stovepipebox:/ /mnt/stovepipe nfs4 _netdev,auto 0 0
```
- `/etc/conf.d/nfs-common.conf`:
```
# Do you want to start the statd daemon? It is not needed for NFSv4.
NEED_STATD="no"

# Do you want to start the idmapd daemon? It is only needed for NFSv4.
NEED_IDMAPD="yes"
```
- Checking
```
$ showmount -e stovepipebox
```
- Manual mounting
```
$ sudo mount -t nfs4 stovepipebox:/ /mnt/stovepipe
```

### 2015-02-15

#### SERVER

- Mostly by default; `/etc/exports` as above
```
$ sudo mkdir -p /export/alexey
```
- `/etc/fstab`:
```
# 
# /etc/fstab: static file system information
#
# <file system>	<dir>	<type>	<options>	<dump>	<pass>
# /dev/sda2 LABEL=RootS
UUID=699027fe-9b9f-42f5-9194-803c5d845184	/         	ext4      	rw,relatime,data=ordered	0 1

# /dev/sda3 LABEL=HomeS
UUID=36d38ac9-c79a-4a7d-a44f-45887ab0a74a	/home     	ext4      	rw,relatime,data=ordered	0 2

/dev/sda1 none swap defaults 0 0

/home/alexey /export/alexey none bind 0 0
```
- Enable NFS:
```
$ sudo systemctl enable rpcbind
$ sudo systemctl enable nfs-server
```

#### CLIENT
```
$ showmount -e stovepipebox
```
- Export list for stovepipebox:
```
/export/alexey 192.168.1.34
/export        192.168.1.34
```
```
$ sudo systemctl enable rpcbind
$ sudo systemctl enable nfs-client.target
$ sudo mkdir -p /mnt/stovepipe
```
- `/etc/fstab`:
```
# 
# /etc/fstab: static file system information
#
# <file system>	<dir>	<type>	<options>	<dump>	<pass>
# /dev/sda2 LABEL=RootX
UUID=815b1d26-3836-4098-8e0a-44986125244c	/         	ext4      	rw,relatime,data=ordered	0 1

# /dev/sda3 LABEL=HomeX
UUID=0b9d9b07-c275-4d80-b154-1c6fc4b241dd	/home     	ext4      	rw,relatime,data=ordered	0 2

/dev/sda1 none swap defaults 0 0

#stovepipebox:/ /mnt/stovepipe nfs4 _netdev,auto 0 0
stovepipebox:/export/alexey /mnt/stovepipe nfs users,noauto,x-systemd.automount,x-systemd.device-timeout=10,timeo=14,noatime 0 0
```

- Suppress *Dependency failed for pNFS block layout mapping daemon*
warning, if necessary:
```
$ sudo systemctl mask nfs-blkmap
```
