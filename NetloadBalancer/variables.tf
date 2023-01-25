variable "name" {
  type        = string
  description = "Load balancer name"
}
variable "subnets" {
  type = list(string)
}
variable "lb_internal" {
}
variable "listener_port" {
}
variable "listener_protocol" {
}


variable "vpcid" {
  description = "this variable will include the vpc id"
  type        = string

}


variable "ec2ids" {
  description = "this variable will include the vpc id"
  type        = list(string)

}

variable "attach_target_port" {
}
variable "target_name" {
}
variable "target_port" {
}
variable "health_protocol" {
}

variable "target_protocol" {
}