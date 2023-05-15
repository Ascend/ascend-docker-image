#!/bin/bash
nohup /var/dmp_daemon -I -M -U 8087 >&/dev/null &
/var/slogd -d