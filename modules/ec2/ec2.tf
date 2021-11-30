data "aws_vpc" "vpc" {
  filter {
    name = "tag:Name"
    values = ["main-vpc"]
  }
}
resource "aws_instance" "ec2" {
        ami = data.aws_ami.ami.id
        instance_type = var.instance_type
        associate_public_ip_address = true
        availability_zone = var.instance_availability_zone
        disable_api_termination = true
        key_name = 
        subnet_id = data.aws_subnet.subnet_ew2a.id
        vpc_security_group_ids = [
                                    data.aws_security_group.home_ssh.id,
                                    data.aws_security_group.sql.id
                                  ]
        tags = {
                Name = "${lower(var.instance_name)}"
        }
}

resource "aws_eip" "eip" {
  vpc = true
  instance = aws_instance.ec2.id
  tags = {
                Name = "${upper(var.instance_name)}"
        }
}
resource "aws_route53_record" "ec2_privateip" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.example.com"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.eip.public_ip]
}
