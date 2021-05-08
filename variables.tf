variable "aws_region" {
  type    = string
  default = "ap-southeast-1"
}

variable "db_table_name" {
  type    = string
  default = "terraform-learn"
}

variable "db_read_capacity" {
  type    = number
  default = 1
}

variable "db_write_capacity" {
  type    = number
  default = 1
}

variable "aws_ami" {
	type = string
	default = "ami-02f26adf094f51167"
}

variable "instance_type" {
	type = string
	default = "t2.nano"
}

variable "key_name" {
	type = string
	default = "poc_admin_key"
}

variable "poc_vpc_cidr"{
	type = string
	default = "172.16.0.0/24"
}

variable "poc_sub_net_1" {
	type = string
	default = "172.16.0.0/26"
}

variable "poc_sub_net_2" {
	type = string
	default = "172.16.0.64/26"
}

variable "poc_sub_net_3" {
	type = string
	default = "172.16.0.128/26"
}

variable "poc_sub_net_4" {
	type = string
	default = "172.16.0.192/26"
}