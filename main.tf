provider "aws" {
  region = var.aws_region
}

provider "random" {}

resource "random_pet" "name" {}

/*
--EC2 in default VPC
resource "aws_instance" "web" {
  #ami = "ami-02f26adf094f51167"
  ami = var.aws_ami
  #instance_type = "t2.micro"
  instance_type = var.instance_type
  user_data = file("post-installs.sh")
  key_name = var.key_name

  tags = {
    Name = random_pet.name.id
  }
}
*/

#POC Demo VPC Creation

resource "aws_vpc" "poc_demo" {
  cidr_block       = var.poc_vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "poc_demo"
  }
}



