#!/bin/bash
set -eu

# check that user provided a command line argument that is a directory housing a lambda function
if [ -z "${1}" ]
  then
    echo -e "\nNo argument supplied:  Please specify either 'shorten' or 'redirect'.\n"
    exit 1
fi

topleveldir=$(git rev-parse --show-toplevel)
cd ${topleveldir}

if ! [[ -d "${topleveldir}/${1}" ]]; then
    # navigate to correct lambda-containing directory, build a new binary, and zip it
    pushd lambdas/${1}
    GOOS=linux go build -o main main.go
    zip -jrm main.zip main
    popd

    read -p "Press ENTER to perform a 'terraform apply' and update your '${1}' lambda function." -n 1 -r
    echo

    # run a terraform apply to update the lambda function updated
    terraform apply
else
    echo -e "\nThe lambda function directory you provided does not exist:  try again.\n"
    exit 1
fi
