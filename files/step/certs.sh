#!/bin/sh

set -x

while [ ! -f /run/config/step/node.crt ] ; do
    step ca certificate $(hostname) /run/config/step/node.crt /run/config/step/node.key \
         --force \
         --ca-url $(cat /run/config/step/ca-url) \
         --root /run/config/step/root_ca.crt \
         --provisioner $(cat /run/config/step/provisioner)
    sleep 15
done

while true ; do
    step ca renew /run/config/step/node.crt /run/config/step/node.key \
     --daemon \
     --ca-url $(cat /run/config/step/ca-url) \
     --root /run/config/step/root_ca.crt
done
