variable "instType" {
  description = "this variable will tell instance type"
  type        = string

}

variable "ami_id" {
  type = string
}

variable "name" {
  type = string
}


variable "subnet_ids" {
  type = list(string)
}

variable "secg_id" {
  type = string
}


variable "key_name" {
}

variable "connection_type" {
}

variable "connection_user" {
}

variable "connection_private_key" {
}

variable "file_source" {
}

variable "file_destination" {
}


variable "inline" {
}