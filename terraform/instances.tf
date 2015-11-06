resource "aws_instance" "mongodb" {
    depends_on = ["aws_internet_gateway.main"]
    count = "${var.mongodb_instance_count}"

    ami = "${lookup(var.aws_amis, var.aws_region)}"
    availability_zone = "${lookup(var.availability_zone, count.index)}"
#   placement_group = "********************"
    ebs_optimized = "${var.ebs_optimization}"
    disable_api_termination = false
    instance_initiated_shutdown_behavior = "stop"

    instance_type = "${var.mongodb_instance_type}"
    key_name = "${lookup(var.key_name, var.aws_region)}"
    monitoring = true
    vpc_security_group_ids = ["${aws_security_group.mongodb_traffic.id}"]
    subnet_id = "${element(aws_subnet.subnet.*.id, count.index)}"
    associate_public_ip_address = true
    private_ip ="${lookup(var.mongodb_private_ip, count.index)}"
    source_dest_check = false
#   user_data = "****************"
#   iam_instance_profile = "*****************"

    root_block_device { 
        volume_type = "gp2"
        volume_size = 8
#       iops = "*****"
        delete_on_termination = true
    }

    tags {
        Name = "MongoDB ${lookup(var.subnet_name, count.index)}"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.created_by}"
    }
}

resource "aws_volume_attachment" "mongodb_data_attachment" {
    count = "${var.mongodb_instance_count}"

    device_name = "/dev/xvdf"
    instance_id = "${element(aws_instance.mongodb.*.id, count.index)}"
    volume_id = "${element(aws_ebs_volume.mongodb_data.*.id, count.index)}"
    force_detach = false  
}

resource "aws_instance" "docker" {
#   depends_on = ["aws_internet_gateway.main"]
    count = "${var.docker_instance_count}"

    ami = "${lookup(var.aws_amis, var.aws_region)}"
    availability_zone = "${lookup(var.availability_zone, count.index)}"
#   placement_group = "********************"
    ebs_optimized = "${var.ebs_optimization}"
    disable_api_termination = false
    instance_initiated_shutdown_behavior = "stop"

    instance_type = "${var.docker_instance_type}"
    key_name = "${lookup(var.key_name, var.aws_region)}"
    monitoring = true
    vpc_security_group_ids = ["${aws_security_group.docker_traffic.id}"]
    subnet_id = "${element(aws_subnet.subnet.*.id, count.index)}"
    associate_public_ip_address = true
    private_ip ="${lookup(var.docker_private_ip, count.index)}"
    source_dest_check = false
#   user_data = "****************"
#   iam_instance_profile = "*****************"

    root_block_device { 
        volume_type = "gp2"
        volume_size = 8
#       iops = "*****"
        delete_on_termination = true
    }

    tags {
        Name = "Docker ${lookup(var.subnet_name, count.index)}"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.created_by}"
    }
}

resource "aws_volume_attachment" "docker_data_attachment" {
    count = "${var.docker_instance_count}"

    device_name = "/dev/xvdf"
    instance_id = "${element(aws_instance.docker.*.id, count.index)}"
    volume_id = "${element(aws_ebs_volume.docker_data.*.id, count.index)}"
    force_detach = false
}

resource "aws_volume_attachment" "docker_image_attachment" {
    count = "${var.docker_instance_count}"

    device_name = "/dev/xvdg"
    instance_id = "${element(aws_instance.docker.*.id, count.index)}"
    volume_id = "${element(aws_ebs_volume.docker_images.*.id, count.index)}"
    force_detach = false
}

# a temporary instance just to run the Docker registry
resource "aws_instance" "registry" {
#   depends_on = ["aws_internet_gateway.main"]
    count = "1"

    ami = "${lookup(var.aws_amis, var.aws_region)}"
    availability_zone = "${lookup(var.availability_zone, count.index)}"
#   placement_group = "********************"
    ebs_optimized = "${var.ebs_optimization}"
    disable_api_termination = false
    instance_initiated_shutdown_behavior = "stop"

    instance_type = "t2.micro"
    key_name = "${lookup(var.key_name, var.aws_region)}"
    monitoring = true
    vpc_security_group_ids = ["${aws_security_group.docker_traffic.id}"]
    subnet_id = "${element(aws_subnet.subnet.*.id, count.index)}"
    associate_public_ip_address = true
    private_ip ="${lookup(var.registry_private_ip, count.index)}"
    source_dest_check = false
#   user_data = "****************"
#   iam_instance_profile = "*****************"

    root_block_device { 
        volume_type = "gp2"
        volume_size = 8
#       iops = "*****"
        delete_on_termination = true
    }

    tags {
        Name = "Registry ${lookup(var.subnet_name, count.index)}"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.created_by}"
    }
}

resource "aws_eip" "registry" {
    count = "1"
    instance = "${element(aws_instance.registry.*.id, count.index)}"
    vpc = true
}

