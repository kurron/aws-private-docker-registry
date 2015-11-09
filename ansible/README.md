#Overview
This is an [Ansible](http://www.ansible.com/) playbook designed to greatly simplify the installation 
of a [Docker Registry](https://docs.docker.com/registry/) into an AWS [Ubuntu 14.04](http://www.ubuntu.com/) instance.  The 
configuration uses [Elastic Load Balancing](https://aws.amazon.com/elasticloadbalancing/) to manage the traffic and 
[S3](https://aws.amazon.com/s3/) for storage.

#Prerequisites

* a single AWS Ubuntu 14.04 Server instance with [SSH](http://www.openssh.com/) enabled and working
* the instance must have a user that has `sudo` privledges
* a box with the most current Ansible installed -- all testing was done using Ansible 1.9.3 on an Ubuntu 14.04 desktop talking to an Ubuntu 14.04 server
 
#Building
Since this project is just a collection of configuration and data files for Ansible to consume, no building is necessary.

#Installation
The first step is to get the files onto your Ansible box.  A great way is to use [Git](https://git-scm.com/) and
simply clone this project.

Once you have the files available to you, you are going to have to edit the `hosts` file with a text editor.  The 
file is documented and should be easily understood. Ansible will use the key file located at the root of the project so you will need to verify that the 
path specified in `ansible.cfg` file matches what you have locally on your disk.

To install the environment all you have to do is issue `./playbook.yml` from the command line and specify any values it may prompt you for.  
Remember, **you must have the key values from the Terraform step** or this step will not be able to properly configure the S3 access.
In a few moments your instance should be provisioned and ready to go.  **Please note that you must reboot the instance in order for some of the optimizations to take affect.** 

#Tips and Tricks

##TBD

#Troubleshooting

##Verifying Ansible Configuration
If you run the `bin/ping-server.sh`, it should contact all your instances via SSH, verifying that your configuration is correct.

```bash
bin/ping-server.sh

TODO: fill in
```

The script is running Ansible with the most verbose settings which may help troubleshoot any connection issues.

##Non-standard Docker Location
In order to accomodate high inodes, Docker has been configured to use `/opt/docker` as its root file system.  The
standard `/var/lib/docker` is not active.

##Only Works On Ubuntu
When Ansible runs, it gathers up information about the target machine and will refuse to provision machine if 
it isn't an Ubuntu box.

#License and Credits
This project uses the Apache license.

#List of Changes
