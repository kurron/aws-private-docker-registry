resource "aws_ebs_volume" "mongodb_data" {
    count = "${var.mongodb_instance_count}"

    availability_zone = "${lookup(var.availability_zone, count.index)}"
    encrypted = false
#   iops = "********"
    size = "${var.mongodb_storage_size}"
#   snapshot_id = "***********"
    type = "gp2"
#   kms_key_id = "**********"

    tags {
        Name = "MongoDB ${lookup(var.subnet_name, count.index)}"
        Storage-Purpose = "Database Storage"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.created_by}"
    }
}

resource "aws_ebs_volume" "docker_data" {
    count = "${var.docker_instance_count}"

    availability_zone = "${lookup(var.availability_zone, count.index)}"
    encrypted = false
#   iops = "********"
    size = "${var.docker_storage_size}"
#   snapshot_id = "***********"
    type = "gp2"
#   kms_key_id = "**********"

    tags {
        Name = "Docker ${lookup(var.subnet_name, count.index)} (resources)"
        Storage-Purpose = "Resource File Storage"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.created_by}"
    }
}

resource "aws_ebs_volume" "docker_images" {
    count = "${var.docker_instance_count}"

    availability_zone = "${lookup(var.availability_zone, count.index)}"
    encrypted = false
#   iops = "********"
    size = "${var.docker_image_storage_size}"
#   snapshot_id = "***********"
    type = "gp2"
#   kms_key_id = "**********"

    tags {
        Name = "Docker ${lookup(var.subnet_name, count.index)} (images)"
        Storage-Purpose = "Imange and Container Storage"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.created_by}"
    }
}

