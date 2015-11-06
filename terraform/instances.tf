resource "aws_instance" "registry" {
    count = "1"

    ami = "${lookup(var.aws_amis, var.aws_region)}"
    availability_zone = "${lookup(var.availability_zone, count.index)}"
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

    root_block_device { 
        volume_type = "gp2"
        volume_size = 8
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

