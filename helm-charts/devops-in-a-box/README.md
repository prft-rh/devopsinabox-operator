Devops in-a-box helm chart to deploy a container-native stack

Some things should really be deployed in the single devopsinabox-system namespace:

pipeline resources
grafana instance

Generating the operator:

mkdir devopsinabox
cd mkdir devopsinabox
operator-sdk init --plugins=helm --domain=com.perficient --group=apimc --version=v1alpha1 --kind=DevSecOpsManager --helm-chart=/path-to-chart
make install
export IMG=quay.io/mrethers/devopsinabox-operator:v0.0.2
make docker-build docker-push IMG=$IMG
make deploy IMG=$IMG