resource "aws_vpc" "main" {
    cidr_block = "${var.vpc_network}"
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags {
        Name = "Docker Registry"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.created_by}"
    }
}

resource "aws_subnet" "subnet" {
    count = "${var.subnet_instance_count}"

    availability_zone = "${lookup(var.availability_zone, count.index)}"
    cidr_block = "${lookup(var.public_cidr, count.index)}" 
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "${lookup(var.subnet_name, count.index)}"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.created_by}"
    }
}

resource "aws_internet_gateway" "main" {
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "Docker Registry"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.created_by}"
    }
}

resource "aws_route_table" "main" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.main.id}"
    }

    tags {
        Name = "Docker Registry"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.created_by}"
    }
}

resource "aws_main_route_table_association" "main" {
    vpc_id = "${aws_vpc.main.id}"
    route_table_id = "${aws_route_table.main.id}"
}

resource "aws_security_group" "docker_traffic" {
    name = "docker-traffic"
    description = "Allow inbound and outbound access on ALL ports."
    vpc_id = "${aws_vpc.main.id}"
    tags {
        Name = "Docker Traffic"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.created_by}"
    }

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
