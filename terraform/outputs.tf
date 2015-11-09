#output "user" {
#    value = "${aws_iam_access_key.registry_user.user}"
#}

#output "key" {
#    value = "${aws_iam_access_key.registry_user.id}"
#}

#output "secret-key" {
#    value = "${aws_iam_access_key.registry_user.secret}"
#}

#output "key-status" {
#    value = "${aws_iam_access_key.registry_user.status}"
#}

output "elb-dns" {
    value = "${aws_elb.load-balancer.dns_name}"
}
