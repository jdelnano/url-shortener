#!/bin/bash
set -eu

topleveldir=$(git rev-parse --show-toplevel)
cd ${topleveldir}

# enumerate all subdirs of the "lambdas" directory
array=(${topleveldir}/lambdas/*/)

# iterate over all the subdirs, re-building the lambda functions
for i in ${array[@]}
do
    # navigate to correct lambda-containing directory, build a new binary, and zip it
    pushd ${i}
    GOOS=linux go build -o main main.go
    zip -jrm main.zip main
    popd
done

# with all lambda functions rebuilt, prompt the user to optionally continue on with a `terraform apply` 
echo
read -p "Press ENTER to perform a 'terraform apply' and update your '${i}' lambda function." -n 1 -r
echo
# run a terraform apply to update the lambda function updated
terraform apply
