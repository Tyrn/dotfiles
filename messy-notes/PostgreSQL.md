## PostgreSQL
#### Tips

- Install:
```
$ yaourt -S postgresql pgadmin4
```
- Logging in as `postgres` user:
```
$ sudo -u postgres -i
```
Error like the following is not fatal:
```
mkdir: cannot create directory ‘/var/lib/postgres/.local’: Permission denied
[postgres@box ~]$
```
- Database cluster: 
```
[postgres]$ initdb --locale $LANG -E UTF8 -D '/var/lib/postgres/data'
```
- Service:
```
$ sudo systemctl enable postgresql
```
- User; the same name as Linux user is convenient :
```
[postgres]$ createuser --interactive
```
 - User's database:
```
$ createdb myDatabaseName
```

#### Troubleshooting

- Log in as `postgres` user:
```
$ su
# su - postgres
```
- `initdb: could not create directory "/var/lib/postgres/data": Permission denied` error.
```
# chown -R postgres:postgres /var/lib/postgres/
# su - postgres -c "initdb --locale en_US.UTF-8 -D '/var/lib/postgres/data'"
```
*NB* Try [ArchWiki](https://wiki.archlinux.org/index.php/PostgreSQL) solutions first.