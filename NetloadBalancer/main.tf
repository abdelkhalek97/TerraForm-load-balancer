resource "aws_lb" "network_lb" {
  name               = var.name
  internal           = var.lb_internal
  load_balancer_type = "network"
  subnets            = var.subnets
}

# Listener
####################################################

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.network_lb.arn

  protocol = var.listener_protocol
  port     = var.listener_port

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}