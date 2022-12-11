tooday=`date +"%Y-%m-%d"`
#tooday=2020-10-13
pass=`cat /mnt/the-pool/rh/clusters/c1/$tooday/auth/kubeadmin-password`

oc login -u kubeadmin -p $pass https://api-int.c1.h00pz.co:6443
podman login -u kubeadmin -p $(oc whoami -t) default-route-openshift-image-registry.apps.c1.h00pz.co
podman build -t default-route-openshift-image-registry.apps.c1.h00pz.co/openshift-cnv/vddk .
podman push default-route-openshift-image-registry.apps.c1.h00pz.co/openshift-cnv/vddk

oc patch cm v2v-vmware -n openshift-cnv --type merge --patch '{"data":{"vddk-init-image":"image-registry.openshift-image-registry.svc:5000/openshift-cnv/vddk@sha256:9810d0631d68eabb2636dd21d4560c3caccb97721a73b63284f39b6a85934eaf"}}'
