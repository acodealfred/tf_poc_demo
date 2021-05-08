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