#!/bin/bash

ADDRESS=$1
CMD="ssh -i ../terraform-asgard-lite/asgard-lite-test.pem ubuntu@$ADDRESS"
echo $CMD
$CMD
