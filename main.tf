provider "aws" {
  region = var.aws_region
}

provider "random" {}

resource "random_pet" "name" {}


resource "aws_instance" "web" {
  ami = "ami-02f26adf094f51167"
  instance_type = "t2.micro"
 # user_data = file("init-script.sh")


  tags = {
    Name = random_pet.name.id
  }
}



