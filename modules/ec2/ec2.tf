resources "aws_instance" "instance" {
  instance_type = var.instance_type
  availability_zone = var.instance_az
  
