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

#Public subnet in ap-southeast1 AZ (singapore)
resource "aws_subnet" "poc_subnet_public_ap-se1" {
    vpc_id = "${aws_vpc.poc_demo.id}"
    cidr_block = "172.16.0.0/26"
    
    availability_zone = "ap-southeast-1a"
    map_public_ip_on_launch = true

    tags = {
        Name = "poc_subnet_public_ap-se1"
    }
}

#Private subnet in ap-southeast1 AZ (singapore)
resource "aws_subnet" "poc_subnet_private_ap-se1" {
    vpc_id = "${aws_vpc.poc_demo.id}"
    cidr_block = "172.16.0.64/26"
    
    availability_zone = "ap-southeast-1a"
    tags = {
        Name = "poc_subnet_private_ap-se1"
    }
}

#Add reduntant subnet

#Adding Inetenet GW to public subnet

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.poc_demo.id

  tags = {
    Name = "POC_IGW"
  }
}


#Add Route table for Public subnet
resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.poc_demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

    tags = {
    Name = "POC_PUBLIC_RT"
  }


}

/*
#Add Route table for private subnet
resource "aws_route_table" "pri_rt" {
  vpc_id = aws_vpc.poc_demo.id

  route {
    cidr_block = "172.16.0.64/26"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "PRIVATE_RT_TABLE"
  }

}
*/
