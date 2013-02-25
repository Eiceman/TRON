#!/bin/bash
#This file makes a tar archive of the full system and saves the systems permissions.

tar -zcvpf /backups/fullsys`date +%m%d%H%M`.tar --directory=/ --exclude=proc --exclude=sys --exclude=dev/pts --exclude=backups . 
