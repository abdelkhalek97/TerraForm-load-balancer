variable "name" {
  type        = string
  description = "Load balancer name"
}


variable "sg_id" {
  type        = string
  description = "Load balancer security group"
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