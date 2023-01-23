output "Load_Balancer_DNS" {

  value = aws_lb.app_lb.dns_name

}