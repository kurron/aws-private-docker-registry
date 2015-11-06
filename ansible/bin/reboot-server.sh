#!/bin/bash

ansible all --become --module-name command --args "/sbin/reboot"
