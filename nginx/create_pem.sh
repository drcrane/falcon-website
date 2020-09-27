#!/bin/sh
cd /home/app
((((./getpfxfile; echo $? >&3) |base64 -d > bengreen.eu.pfx) 3>&1) | (read xs; exit $xs))
if [ "$?" == "0" ] ; then
openssl pkcs12 -passin pass: -in bengreen.eu.pfx -nocerts -out bengreen.eu.key -nodes
openssl pkcs12 -passin pass: -in bengreen.eu.pfx -nokeys -out bengreen.eu.cert
mv bengreen.eu.key /etc/nginx
mv bengreen.eu.cert /etc/nginx
else
echo no keys found
fi

