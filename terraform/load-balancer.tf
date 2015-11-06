resource "aws_security_group" "web_traffic" {
    name = "web-traffic"
    description = "Allow inbound and outbound access on http(s) ports."
    vpc_id = "${aws_vpc.main.id}"
    tags {
        Name = "Web Traffic"
        Realm = "${var.realm}"
        Purpose = "${var.purpose}"
        Managed-By = "${var.created_by}"
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
