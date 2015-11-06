#!/bin/bash

terraform apply -input=true -refresh=true $*
