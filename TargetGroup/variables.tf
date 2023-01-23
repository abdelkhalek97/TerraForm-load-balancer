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