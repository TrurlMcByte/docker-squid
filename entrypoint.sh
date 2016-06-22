#!/bin/sh
set -ex
CACHE_DIR="`sed -n 's/^cache_dir\s\+[[:alnum:]]\+\s\+\([[:graph:]\/]\+\)\s.*/\1/p' /etc/squid/squid.conf | sed '1 q'`"
chown squid.squid $CACHE_DIR
test -d "${CACHE_DIR}/00" || /usr/sbin/squid -z -F -N -S -f /etc/squid/squid.conf

if [ $# -eq 0 ]; then
    /usr/sbin/squid -F -S -N -f /etc/squid/squid.conf
fi

exec "$@"
