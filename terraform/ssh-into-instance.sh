#!/bin/bash

IP=$1
ssh -v -i docker-registry-test.pem ubuntu@${IP}
