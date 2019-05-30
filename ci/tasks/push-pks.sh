#!/bin/bash
set -ex
pks login -a ${PKS_ENDPOINT} -u ${PKS_USER} -p ${PKS_PASSWORD} -k
pks get-credentials ${PKS_CLUSTER}
#kubectl get pods


#template=`cat "spring-demo-pod.yml" | sed "s/{VERSION}/$VERSION/g"`
# apply the yml with the substituted value
#echo "$template" > ../pks-build/spring-demo-modified.yml

helm init --client-only
#helm repo add harbor  ${HELM_URL} --ca-file ${HELM_CA_PATH} --username ${HELM_USER} --password ${HELM_PASSWORD}
cd helm-chart
helm install --debug --value ../config/value.yml spring-demo
