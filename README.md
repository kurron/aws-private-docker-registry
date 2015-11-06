#Overview
This project creates an [AWS](http://aws.amazon.com/) environment suitable for running a private
[Docker Registry](https://docs.docker.com/registry/) in the Amazon cloud. The configuration uses CloudFront 
to manage network traffic and S3 for storage. 

#Prerequisites

* [Terraform](https://terraform.io/) installed and working
* [Ansible](http://www.ansible.com/) installed and working
* Development and testing was done on [Ubuntu Linux](http://www.ubuntu.com/)
* [SSH](http://www.openssh.com/) installed and working
* The environment variable `AWS_ACCESS_KEY_ID` set to your AWS Access Key ID 
* The environment variable `AWS_SECRET_ACCESS_KEY` set to your AWS Secret Access Key
* An existing [AWS SSH Key Pair](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)

#Building
This project is a collection of data files consumed by Terraform and Ansible so there is nothing to build. 

#Installation
**TODO** 

#Tips and Tricks
**TODO** 

#Troubleshooting
**TODO** 

#License and Credits
This project operates under Apache open source license.

#List of Changes
