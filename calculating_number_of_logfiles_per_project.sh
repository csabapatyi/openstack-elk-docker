#!/bin/bash


for i in horizon keystone nova neutron glance cinder ceilometer aodh gnocchi heat swift ; do
    COUNT=`find /var/log/ | egrep $i | grep log$ | wc -l`
    echo "$i : $COUNT"
done;