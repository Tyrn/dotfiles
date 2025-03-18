## Samba
#### Client setup
##### Purpose: make a single r/w share of an entire user directory (alexey) available via samba password

SERVER:

- Create Samba user account and set password:
```
$ sudo pdbedit -a -u alexey   ;; note that alexey is an existing Linux user
```

- Change Samba user account password, if necessary:
```
$ sudo smbpasswd -a alexey
```

- Delete Samba user account (e.g. created by mistake):
```
$ sudo pdbedit -x samba_user
$ sudo userdel samba_user         ;; if not needed - no suicide!
```
- `/etc/samba/smb.conf`:
```
[global]
    workgroup = WORKGROUP
    server string = Samba Server
    netbios name = SERVER
    name resolve order = bcast host
    dns proxy = no

    log file = /var/log/samba/%m.log

    create mask = 0664
    directory mask = 0775

    force create mode = 0664
    force directory mode = 0775

    ; One may be interested in the following setting:
    ;force group = +nas

[alexey]
    path = /home/alexey
    read only = No
```

- Starting:
```
$ sudo systemctl start smbd nmbd
```

CLIENT:

- Check (stovepipebox is the server host name):
```
$ smbclient -L stovepipebox -U%
Domain=[WORKGROUP] OS=[Unix] Server=[Samba 4.1.16]

        Sharename       Type      Comment
        ---------       ----      -------
        alexey          Disk      
        IPC$            IPC       IPC Service (Samba Server)
Domain=[WORKGROUP] OS=[Unix] Server=[Samba 4.1.16]

        Server               Comment
        ---------            -------
        SERVER               Samba Server

        Workgroup            Master
        ---------            -------
        WORKGROUP
```
    
- Manual mount (`pwd` from `$ sudo pdbedit -a -u alexey`; server side):
```
$ sudo mount -t cifs //SERVER/alexey /mnt/stove -o user=alexey,password=pwd,workgroup=WORKGROUP,ip=192.168.1.33
```

- Routine mount, `.smbcredentials` (plain text, basic security):
```
username=alexey
password=pwd
```
```
$ sudo chown root:root /home/alexey/.smbcredentials
$ sudo chmod 660 /home/alexey/.smbcredentials
```

- `/etc/fstab`:
```
//192.168.1.33/alexey /mnt/stove cifs credentials=/home/alexey/.smbcredentials,comment=systemd.automount,uid=alexey 0 0
```
