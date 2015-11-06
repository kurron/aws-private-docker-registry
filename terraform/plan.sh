#!/bin/bash

terraform plan -input=true -refresh=true $*
