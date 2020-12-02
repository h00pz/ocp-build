tooday=`date +"%Y-%m-%d"`
#tooday=2020-10-13
pass=`cat /mnt/the-pool/rh/clusters/c1/$tooday/auth/kubeadmin-password`

oc login -u kubeadmin -p $pass https://api-int.c1.h00pz.co:6443
podman login -u kubeadmin -p $(oc whoami -t) default-route-openshift-image-registry.apps.c1.h00pz.co
podman build -t default-route-openshift-image-registry.apps.c1.h00pz.co/openshift-cnv/vddk .
podman push default-route-openshift-image-registry.apps.c1.h00pz.co/openshift-cnv/vddk

oc patch cm v2v-vmware -n openshift-cnv --type merge --patch '{"data":{"vddk-init-image":"image-registry.openshift-image-registry.svc:5000/openshift-cnv/vddk@sha256:a0a87f6ceb7e62c1c23f760c53e82cf1ec3fef4a40bb8cf453400c9265e40bfe"}}'
