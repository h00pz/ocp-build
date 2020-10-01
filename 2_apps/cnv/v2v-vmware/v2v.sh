tooday=`date +"%Y-%m-%d"`
pass=`cat /mnt/the-pool/rh/clusters/c1/$tooday/auth/kubeadmin-password`

oc login -u kubeadmin -p $pass https://api-int.c1.h00pz.co:6443
podman login -u kubeadmin -p $(oc whoami -t) image-registry.apps.c1.h00pz.co
podman build -t  openshift-image-registry.apps.c1.h00pz.co/openshift-cnv/vddk .
podman push image-registry.apps.c1.h00pz.co/openshift-cnv/vddk
