resource "aws_security_group" "rds_security_group" {
  name        = "${var.vpc_id}_rds"
  description = "Allow traffic to RDS instances over port 1433."
  vpc_id      = "${var.vpc_id}"

  ingress = [
    {
      description      = "[SQL] VPC traffic"
      from_port        = "${var.port}"
      to_port          = "${var.port}"
      protocol         = "tcp"
      cidr_blocks      = ["${var.vpc_address}"]
      ipv6_cidr_blocks = ["::/0"]
        "ipv6_cidr_blocks": null
        "prefix_list_ids": null
        "security_groups": null
        "self": null
    }
  ]


  egress = [
    {
        description = null
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
        "ipv6_cidr_blocks": null
        "prefix_list_ids": null
        "security_groups": null
        "self": null
    }
  ]

  tags ={
    Name = "${var.vpc_id}_rds"
    Env  = "${var.environment}"
  }
}
