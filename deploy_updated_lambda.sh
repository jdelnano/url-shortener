#!/bin/bash

pushd lambdas/${1} && GOOS=linux go build -o main main.go && zip -jrm main.zip main && popd
