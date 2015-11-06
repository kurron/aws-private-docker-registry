#!/bin/bash

ADDRESS=$1
CMD="ssh -i ../docker-registry-test.pem ubuntu@$ADDRESS"
echo $CMD
$CMD
