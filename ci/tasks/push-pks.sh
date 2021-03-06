#!/bin/bash
set -ex
ls
ls config
pks login -a ${PKS_ENDPOINT} -u ${PKS_USER} -p ${PKS_PASSWORD} -k
pks get-credentials ${PKS_CLUSTER}
#kubectl get pods
VERSION=$(cat config/.git/ref) 


#template=`cat "spring-demo-pod.yml" | sed "s/{VERSION}/$VERSION/g"`
# apply the yml with the substituted value
#echo "$template" > ../pks-build/spring-demo-modified.yml

helm init --client-only
cd helm-chart
helm --debug upgrade spring-demo --install spring-demo --values ../config/values.yml --set dbusername=${DB_USER} --set dbpassword=${DB_PASSWORD}
kubectl annotate deployment  spring-demo kubernetes.io/change-cause="Deployed by CI SHA: ${VERSION}"

