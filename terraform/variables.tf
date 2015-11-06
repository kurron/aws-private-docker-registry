variable "aws_region" {
    description = "AWS region to build into."
    default = "us-west-2"
}

variable "vpc_network" {
    description = "Class B network of the VPC"
    default = "10.0.0.0/16"
}

variable "realm" {
    description = "The logical group that all of the infrastructure belongs to."
    default = "Docker Registry Testing" 
}

variable "purpose" {
    description = "A tag indicating why all the infrastructure exists, eg. load-testing."
    default = "experimentation" 
}

variable "created_by" {
    description = "A tag indicating how the infrastructure was provisioned, eg Terraform"
    default = "Managed by Terraform" 
}

variable "subnet_instance_count" {
    description = "How many subnets to create (should match the number of availability zones)."
    default = "3"
}

variable "subnet_name" {
  default = {
    "0" = "Blue"
    "1" = "Green"
    "2" = "Red"
    "3" = "White"
    "4" = "Orange"
    "5" = "Black"
  }
}

variable "public_cidr" {
    description = "The cidr value to use for the public subnet of the availability zone."
    default = {
        "0" = "10.0.0.0/24"
        "1" = "10.0.2.0/24"
        "2" = "10.0.4.0/24"
    }
}

variable "key_name" {
    description = "Name of the SSH keypair to use in AWS."
    default = {
        us-east-1      = ""
        us-west-1      = ""
        us-west-2      = "docker-registry-test"
        eu-west-1      = ""
        eu-central-1   = ""
        sa-east-1      = ""
        ap-southeast-1 = ""
        ap-southeast-2 = ""
        ap-northeast-1 = ""
    }
}

# Ubuntu Server 14.04 LTS (HVM), SSD Volume Type, 64-bit 
variable "aws_amis" {
    description = "AMI to build the instances from."
    default = {
        us-east-1      = "ami-81ea1aea"
        us-west-1      = "ami-df6a8b9b"
        us-west-2      = "ami-5189a661"
        eu-west-1      = "ami-47a23a30"
        eu-central-1   = "ami-accff2b1"
        sa-east-1      = "ami-4d883350"
        ap-southeast-1 = "ami-96f1c1c4"
        ap-southeast-2 = "ami-69631053"
        ap-northeast-1 = "ami-936d9d93"
    }

}

variable "availability_zone" {
  default = {
    "0" = "us-west-2a"
    "1" = "us-west-2b"
    "2" = "us-west-2c"
  }
}

variable "ebs_optimization" {
    description = "Whether or not the instance should optimize its EBS access."
    default = "false"
}

variable "registry_private_ip" {
  default = {
    "0" = "10.0.0.30"
    "1" = "10.0.2.30"
    "2" = "10.0.4.30"
  }
}


variable "registry_bucket_name" {
    description = "The bucket to use for Docker image storage."
    default = "org-kurron-docker-registry"
}
