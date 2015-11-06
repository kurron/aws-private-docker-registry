#!/bin/bash

IP=$1
ssh -v -i asgard-lite-test.pem ubuntu@${IP}
