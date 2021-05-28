#!/bin/sh
rm -f  Dockerfile  .dockerignore  root.sh

while [ 1 ]  
do
 [ -e "/app.war" ] && mv /app.war /mnt/app.war && break
echo '没有发现镜像包app.war,请核实!!!!!!'
sleep 3
done
