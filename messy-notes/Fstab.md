## Partitioning

- [How to move "/opt" directory to new partition?](https://www.kubuntuforums.net/forum/newbie-support/help-the-new-guy/39439-) (`rsync -av`)
- [Moving /var, /home to separate partition](https://unix.stackexchange.com/questions/131311/moving-var-home-to-separate-partition)
- [/home /opt /tmp /usr /var on a single partition of another hard drive](https://serverfault.com/questions/737333/home-opt-tmp-usr-var-on-a-single-partition-of-another-hard-drive-debian-8)

### Mounting

- Move `/opt` and `/var` to `/mnt/out`
- Create empty directories `/opt` and `/var`
- Edit `/etc/fstab`

`/etc/fstab`:
```
$ cat /etc/fstab
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a device; this may
# be used with UUID= as a more robust way to name devices that works even if
# disks are added and removed. See fstab(5).
#
# <file system>             <mount point>  <type>  <options>  <dump>  <pass>
UUID=59458eb9-aaaa-4e9e-b57a-8a6882ffbb33   swap       swap   noatime   0 2
UUID=b1612ca4-bbbb-4c33-a997-49a8aa48dc57   /          ext4   noatime   0 1
UUID=36d38ac9-cccc-4a7d-a44f-45887ab0a74a   /home      ext4   noatime   0 2
UUID=c6704ec9-dddd-4d1a-beb5-a9d1571574b3   /mnt/out   ext4   noatime   0 2

# Binds
/mnt/out/opt                                /opt       none   bind      0 0
/mnt/out/var                                /var       none   bind      0 0
```