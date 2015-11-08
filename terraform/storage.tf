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
