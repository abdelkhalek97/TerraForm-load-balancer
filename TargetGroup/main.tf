resource "aws_lb_target_group" "NLB_tg" {
  name     = var.target_name
  port     = var.target_port
  protocol = var.target_protocol
  vpc_id   = var.vpcid

  health_check {
    enabled  = true
    protocol = var.health_protocol
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_alb_target_group_attachment" "tgattachment" {
  count            = length(var.ec2ids)
  target_group_arn = aws_lb_target_group.NLB_tg.arn
  target_id        = element(var.ec2ids, count.index)
  port             = var.attach_target_port

  depends_on = [
    aws_lb_target_group.NLB_tg
  ]

}













# {for idx, instances in keys(var.ec2ids): 
#                   idx => { 
#                       name = instances 
#                       ec2ip = var.ec2ids[instances]
#                   }
#              }
