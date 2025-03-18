## XAMPP
####2016-05-27

PHP 7.0.7 (cli) (built: May 25 2016 18:40:26) ( NTS )
Copyright (c) 1997-2016 The PHP Group
Zend Engine v3.0.0, Copyright (c) 1998-2016 Zend Technologies
    with Xdebug v2.4.0, Copyright (c) 2002-2016, by Derick Rethans
    
XAMPP 7.0.6, downloaded from https://www.apachefriends.org/index.html
and installed manually

- `/etc/php/conf.d/xdebug.ini`, the same appended to `/opt/lampp/etc/php.ini`:
```
[xdebug]

xdebug.default_enable=1

xdebug.remote_enable=1
xdebug.remote_handler=dbgp
xdebug.remote_host=localhost
xdebug.remote_port=9000
xdebug.remote_autostart=1

zend_extension="/usr/lib/php/modules/xdebug.so"
```

- to `.bashrc`:
```
# Sublime Text IDE & PHP
export XDEBUG_CONFIG="idekey=sublime.xdebug"
```

- Aliasing: `/opt/lampp/etc/httpd.conf`, after `DocumentRoot ... </Directory>`:
```
<Directory "/home/alexey/spaces/php/">
    Options Indexes FollowSymLinks ExecCGI Includes
    AllowOverride All
    Require all granted
</Directory>
```
- Inside alias_module, before `</IfModule>`:
```
    Alias /spacephp /home/alexey/spaces/php/
```

- MariaDB, password not yet set:
```
$ mysql -u root
```
- Setting password:
```
$ mysqladmin -u root password
```

- You may want to use the right socket: `/etc/mysql/my.cnf, /opt/lampp/etc/my.cnf`:
```
[client]
socket		= /opt/lampp/var/mysql/mysql.sock
[mysqld]
socket		= /opt/lampp/var/mysql/mysql.sock
```

- Open console:
```
$ mysql -u root -p
```

##### Adminer

- Append to `/opt/lampp/apache2/conf/httpd.conf`:
```
Include "/etc/httpd/conf/extra/httpd-adminer.conf"
```

#### 2016-05-30
```
$ /opt/lampp/bin/mysql_secure_installation
```

#### 2016-06-04

*Community Drupal is not really working on top of apachefriends' XAMPP. A pity*

- Drupal 8.1.2 from https://bitnami.com/stack/xampp
!!! *module*.{bin,run} !!!

Runs basically without configuration; just watch and wait.


#### 2016-06-05
```
$ sudo ln -s /opt/lampp/apps/drupal/drush/drush /usr/local/bin/drush
```
