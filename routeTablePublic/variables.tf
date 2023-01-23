variable "pup-cidr" {
  type        = string
  description = "pub cidr"
  default     = "0.0.0.0/0"

}


variable "vpcid" {
  type        = string
  description = "vpc id"

}

variable "internetGatewayName" {
  type        = string
  description = "ig id"

}

variable "tableName" {
  type        = string
  description = "Route Table Name"

}

variable "subnet_ids" {
  type = list(string)
}