NAMESPACE=hello-world
for i in $(tkn pr ls -n ${NAMESPACE} | grep -v NAME | awk '{ print $1 }') ; do oc delete pr $i -n ${NAMESPACE} ; done
