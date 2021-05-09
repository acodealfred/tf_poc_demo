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

# Public subnet security group
resource "aws_security_group" "allow_ssh_tls" {
  name        = "allow_ssh_tls"
  description = "Allow SSH/TLS inbound traffic"
  vpc_id      = aws_vpc.poc_demo.id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  ingress {
    description      = "TLS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Allow SSH-LTS"
  }
}

#NACL should be desinged carefully.


#Allocating EIP in 

resource "aws_eip" "nat_gateway" {
  vpc = true
}

#NAT Gateway for private-subnet
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.poc_subnet_public_ap-se1.id

  tags = {
    Name = "POC_NATGW"
  }
}




#Lauch AWS-EC2 in VPC-public subnet
/*
resource "aws_instance" "web-service" {
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