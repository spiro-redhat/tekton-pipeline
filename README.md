Run the scripts in create.sh to build up pipeline (do it in the order they appear). 
The last script installs and initates a pipeline it is called: pipelinerun.yaml

To re-rerun pipelines re-create the pipelinerun script with: 

oc create -f pipelinerun.yaml

This will create a new pipeline run which can be viewed via the developer console (pipelines)

From: 
https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.4/pdf/getting_started_with_jboss_eap_for_openshift_container_platform/red_hat_jboss_enterprise_application_platform-7.4-getting_started_with_jboss_eap_for_openshift_container_platform-en-us.pdf

oc new-project eap-demo
# create a key store 
keytool -genkey -keyalg RSA -alias eapdemo-selfsigned -keystore keystore.jks -validity
360 -keysize 2048

# create a secret from the keystore 
oc create secret generic eap7-app-secret --from-file=keystore.jks

# create service account to download images  from redhat private repos 
# https://access.redhat.com/RegistryAuthentication#registry-service-accounts-for-shared-environments-4
oc create -f 1234567_myserviceaccount-secret.yaml

# configure the secrets 
oc secrets link default 1234567-myserviceaccount-pull-secret --for=pull
oc secrets link builder 1234567-myserviceaccount-pull-secret --for=pull

# import the latest image streams from openshift for jdk8
oc replace -f \
https://raw.githubusercontent.com/jboss-container-images/jboss-eap-openshifttemplates/eap74/eap74-openjdk8-image-stream.json

# check template params with: 
# oc describe template TEMPLATE_NAME 

oc new-app --template=eap74-basic-s2i \ 1
-p IMAGE_STREAM_NAMESPACE=eap-demo \ 2
-p EAP_IMAGE_NAME=jboss-eap74-openjdk8-openshift:7.4.0 \ 3
-p EAP_RUNTIME_IMAGE_NAME=jboss-eap74-openjdk8-runtime-openshift:7.4.0 \ 4
-p SOURCE_REPOSITORY_URL=https://github.com/jboss-developer/jboss-eap-quickstarts
\ 5
-p SOURCE_REPOSITORY_REF=7.4.x \ 6
-p CONTEXT_DIR=kitchensink
