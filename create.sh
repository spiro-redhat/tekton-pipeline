# https://artifacthub.io/packages/tekton-task/tekton-catalog-tasks/maven
# https://catalog.redhat.com/software/containers/jboss-eap-7/eap74-openjdk11-runtime-openshift-rhel8/6054cfd24b028f6e10ce2e32?container-tabs=gti
# oc import-image jboss-eap-7/eap74-openjdk11-runtime-openshift-rhel8:7.4.6-5.1661796233 --from=registry.redhat.io/jboss-eap-7/eap74-openjdk11-runtime-openshift-rhel8:7.4.6-5.1661796233 --confirm
 
oc create -f namespace.yaml
oc create -f pvc.yaml
oc create configmap hello-world-settings-xml --from-file=settings.xml
oc create -f pipeline-resources.yaml
oc create -f pipeline.yaml
tkn hub install task git-clone                         
tkn hub install task maven
oc create -f pipelinerun.yaml

tkn t ls 
tkn pr ls 


#S2I builds an image and pushes it to the destination registry which is defined as a parameter. In order to properly authenticate to the remote container registry, it needs to have the proper credentials. The credentials can be provided through a dockerconfig workspace or service account. See Authentication for further details.

#tkn hub install task s2i

#If you are running on OpenShift, you also need to allow the service account to run privileged containers because OpenShift does not allow containers run as privileged containers by default unless explicitly configured, due to security considerations.

#Run the following in order to create a service account named pipeline on OpenShift and allow it to run privileged containers:

#oc create serviceaccount pipeline
#oc adm policy add-scc-to-user privileged -z pipeline
#oc adm policy add-role-to-user edit -z pipeline



