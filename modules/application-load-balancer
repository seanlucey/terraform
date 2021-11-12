resource "aws_lb" "alb" {
  name               = "${upper(var.instance_name)}-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.https.id]
  subnets            = [
                        data.aws_subnet.subnet_ew2a.id,
                        data.aws_subnet.subnet_ew2b.id
                        ]
  enable_deletion_protection = true

  tags = {
    Name = "${var.instance_name}"
  }
}
resource "aws_alb_target_group" "group" {
  name     = "${lower(var.instance_name)}"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = data.aws_vpc.main.id
  stickiness {
    type = "lb_cookie"
  }
  health_check {
        protocol = "HTTPS"
        path = "/"
        port = 443
        }
}
resource "aws_alb_listener" "listener_https" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:eu-west-2:123456789:certificate/fsgfgsdfg-5d7c-48c7-8fba-sdfg45345"
  default_action {
    target_group_arn = "${aws_alb_target_group.group.arn}"
    type             = "forward"
  }
}
resource "aws_lb_target_group_attachment" "alb_target_group" {
  target_group_arn = aws_alb_target_group.group.arn
  target_id        = aws_instance.ec2.id
  port             = 443
}
resource "aws_route53_record" "alb_alias" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.example.com"
  type    = "A"
  alias {
    name = "${aws_lb.alb.dns_name}"
    zone_id = "${aws_lb.alb.zone_id}"
    evaluate_target_health = true
  }
}
