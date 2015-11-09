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
The easiest way to reboot is to run `bin/reboot-server.sh` from the command-line.

#Tips and Tricks

##Configure Your Docker Daemon
This registry does not use TLS to simplify the setup so you need to tell your Docker daemon that it is okay to use insecure communications.
Do this by editing your `/etc/default/docker` file so that it knows about your endpoint.

```bash
# Docker Upstart and SysVinit configuration file

# Customize location of Docker binary (especially for development testing).
#DOCKER="/usr/local/bin/docker"

# Use DOCKER_OPTS to modify the daemon startup options.
#DOCKER_OPTS="--dns 8.8.8.8 --dns 8.8.4.4"

# If you need Docker to use an HTTP proxy, it can also be specified here.
#export http_proxy="http://127.0.0.1:3128/"

# This is also a handy place to tweak where Docker's temporary files go.
#export TMPDIR="/mnt/bigdrive/docker-tmp"
DOCKER_OPTS="--insecure-registry load-balancer-291039105.us-west-2.elb.amazonaws.com"
```

Restart your daemon `sudo service docker restart`.

##Log Into The Registry

Before you can begin using your registry, you need to log into it:

`docker login load-balancer-291039105.us-west-2.elb.amazonaws.com`

The only credentials the registry knows about is `docker/docker` so use those when logging in.

##Tag An Image And Push It
Before you can push an image, you need to tag it so that it knows it is destined for your registry.  Pick an arbitrary image and use 
the `docker tag` command.

```bash
docker tag 9a7784b5279d load-balancer-291039105.us-west-2.elb.amazonaws.com/docker/kurron/rabbitmq:latest

docker push load-balancer-291039105.us-west-2.elb.amazonaws.com/docker/kurron/rabbitmq:latest
```

##Pull An Image
A good way to test pulling is to remove all containers and images followed by a pull.

```bash
docker rm --volumes --force $(docker ps --all --quiet)
docker rmi --force $(docker images --quiet)
docker pull load-balancer-291039105.us-west-2.elb.amazonaws.com/docker/kurron/rabbitmq:latest
```

#Troubleshooting

##Verifying Ansible Configuration
If you run the `bin/ping-server.sh`, it should contact all your instances via SSH, verifying that your configuration is correct.

```bash
bin/ping-server.sh

registry-blue | success >> {
    "changed": false, 
    "ping": "pong"
}
```

The script is running Ansible with the most verbose settings which may help troubleshoot any connection issues.

##Checking The Endpoint
To verify that your registry is available from the load balancer endpoint, use the `elb-dns` value output by the Terraform step and hit the endpoint.

```bash
curl load-balancer-291039105.us-west-2.elb.amazonaws.com/v2/ | python -m json.tool
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    87  100    87    0     0    331      0 --:--:-- --:--:-- --:--:--   330
{
    "errors": [
        {
            "code": "UNAUTHORIZED",
            "detail": null,
            "message": "authentication required"
        }
    ]
}
```

##Non-standard Docker Location
In order to accomodate high inodes, Docker has been configured to use `/opt/docker` as its root file system.  The
standard `/var/lib/docker` is not active.

##Only Works On Ubuntu
When Ansible runs, it gathers up information about the target machine and will refuse to provision machine if 
it isn't an Ubuntu box.

#License and Credits
This project uses the Apache license.

#List of Changes
