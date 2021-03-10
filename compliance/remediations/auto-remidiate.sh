#!/bin/bash

while read -r remediations ; do
        oc patch complianceremediation/$remediations --type=merge -p '{"spec":{"apply": false}}' -n openshift-compliance
done < <(oc get complianceremediations | awk '{print $1}' | grep -v NAME | grep -v https)
