#!/bin/bash
yc compute instance create \
--name reddit-app-bake2 \
--hostname reddit-app-bake2 \
--memory=2 \
--core-fraction=5 \
--create-boot-disk image-id=fd8i34tjvlcjl496tra5,size=10GB \
--network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
--metadata serial-port-enable=1 \
--ssh-key ~/Nextcloud/OTUS/DevOps/homework/ssh/appuser.pub 
