resource "aws_lb" "lb" {
  name               = upper(var.name)-upper(var.environment)-ALB"
  
  load_balancer_type = var.load_balancer_type
  internal           = var.internal
  security_groups    = var.security_groups
  subnets            = var.subnets
  enable_deletion_protection = true

  tags = {
    Environment = var.environment
    Customer = var.customer
  }
}
resource "aws_alb_target_group" "main" {
  name     = lower(var.name)-lower(var.environment)"
  port     = 443
  protocol = "HTTPS"
  vpc_id   = var.vpc_id
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
  load_balancer_arn = aws_lb.lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:eu-west-2:588809211975:certificate/853c7975-5d7c-48c7-8fba-40a03aade322"
  default_action {
    target_group_arn = aws_alb_target_group.main.arn
    type             = "forward"
  }
}
resource "aws_lb_target_group_attachment" "alb_target_group" {
  target_group_arn = aws_alb_target_group.main.arn
  target_id        = aws_instance.ec2.id
  port             = 443
}
resource "aws_route53_record" "alb_alias" {
  zone_id = "Z2DSKWPR5OL3DU"
  name    = lower(var.name).gen-prv.com
  type    = "A"
  alias {
    name = aws_lb.lb.dns_name
    zone_id = aws_lb.lb.zone_id
    evaluate_target_health = true
  }
}
