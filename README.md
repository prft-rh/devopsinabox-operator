# devopsinabox-operator

# pre-requisites

Install the operator framework

# making changes

To make a change, clone the relevant helm chart first:

git clone git@github.com:prft-rh/spring-boot-app-helm-chart.git

- or -

git clone git@github.com:prft-rh/devopsinabox-helm-chart.git

- or -

git clone git@github.com:prft-rh/devopsinabox-namespace-helm-chart.git

Switch to the correct branch for the cloud vendor (aws, azure, etc)

Update the relevant helm chart files, commit and push to git

In this repository, open the ci/pipeline.txt file

Find the line with the VERSION environment variable and bump the version number for the operator.

Example for current version 0.0.25 and new version 0.0.26:

export VERSION=0.0.26-aws
export REPLACES=0.0.25-aws

Then find the line for the CATALOG_VERSION variable and bump that version. Ex:

CATALOG_VERSION=v1.0.95 => CATALOG_VERSION=v1.0.96

Then in an *empty* directory, run the commands in the pipeline.txt file.