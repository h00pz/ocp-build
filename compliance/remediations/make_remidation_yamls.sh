#!/bin/bash

while read -r remediations ; do
	oc get complianceremediation/$remediations -n openshift-compliance -o yaml > yamls/$remediations.yaml
done < <(oc get complianceremediations | awk '{print $1}' | grep -v NAME | grep -v https)
