# make sure to export AWS_ACCESS_KEY_ID in the environment
# make sure to export AWS_SECRET_ACCESS_KEY in the environment

# The entire plan is spread across the various *.tf files.  One file was getting too unweildy.

provider "aws" {
    region = "${var.aws_region}"
    max_retries = 10
}

