# Network settings

## ByeDPI

- `/etc/byedpi.conf`:

```
# More options and their descriptions can be found here:
# https://github.com/hufrea/byedpi/blob/main/README.md
#
# By default, ciadpi listens on all interfaces,
# a specific one can be specified via "--ip 127.0.0.1".

# Put your options here
#BYEDPI_OPTIONS="--port 12000 --ip 127.0.0.1 --split 1 --disorder 3+s --mod-http=h,d --auto=torst --tlsrec 1+s"
#BYEDPI_OPTIONS="--port 12000 --ip 127.0.0.1 -s1 -q1 -Y -Ar -s5 -o1+s -At -f-1 -r1+s -As -s1 -o1 +s -s-1 -An"
BYEDPI_OPTIONS="--port 12000 --ip 127.0.0.1 -a1 -o1 -o23+s -T3 -At"
```
