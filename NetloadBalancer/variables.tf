variable "name" {
  type        = string
  description = "Load balancer name"
}
variable "subnets" {
  type = list(string)
}

variable "target_group_arn" {
  type        = string
  description = "target group arn"
}
variable "lb_internal" {
}
variable "listener_port" {
}
variable "listener_protocol" {
}