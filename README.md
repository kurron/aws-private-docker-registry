#Overview
This project creates an [AWS](http://aws.amazon.com/) environment suitable for running a private
[Docker Registry](https://docs.docker.com/registry/) in the Amazon cloud. The configuration uses 
Elastic Load Balancer to manage network traffic and S3 for storage. 

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
* follow the instructions in the `terraform/README.md` file to create the necessary AWS infrastructure
* follow the instructions in the `ansible/README.md` file to install the necessary software into your instance
  
#Tips and Tricks
See the *Tips and Tricks* section of each sub-project. 

#Troubleshooting
See the *Troubleshooting* section of each sub-project. 

#License and Credits
This project operates under Apache open source license.

#List of Changes
