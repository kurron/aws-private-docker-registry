resource "aws_s3_bucket" "registry" {
    bucket = "${var.registry_bucket_name}"
#   acl = "private"
#   policy = 
    force_destroy = true
#   website = 
    versioning = []
    tags {
        Name = "Docker Registry"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.created_by}"
    }
}

resource "aws_iam_role" "docker_registry_permissions" {
    name = "docker-registry-permissions"
#   path = 
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
