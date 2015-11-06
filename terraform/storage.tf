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

resource "aws_iam_role_policy" "docker_registry_policy" {
    name = "docker-registry-policy"
    role = "${aws_iam_role.docker_registry_permissions.id}"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "arn:aws:s3:::*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation"
            ],
            "Resource": "arn:aws:s3:::${var.registry_bucket_name}"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject"
            ],
            "Resource": "arn:aws:s3:::${var.registry_bucket_name}/*"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "docker_registry_s3_access" {
    description = "Docker Registry S3 Access"
    name = "docker-registry-s3-access"
    path = "/"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::${var.registry_bucket_name}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:GetObject",
                "s3:DeleteObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.registry_bucket_name}/*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_user" "registry_user" {
    name = "registry"
    path = "/"
}

resource "aws_iam_access_key" "registry_user" {
    user = "${aws_iam_user.registry_user.name}"
}

resource "aws_iam_policy_attachment" "registry_attachment" {
    name = "registry-attachment"
    users = ["${aws_iam_user.registry_user.name}"]
    roles = []
    groups = []
    policy_arn = "${aws_iam_policy.docker_registry_s3_access.arn}"
}
