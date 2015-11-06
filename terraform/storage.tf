resource "aws_s3_bucket" "registry" {
    bucket = "org-kurron-docker-registry"
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
