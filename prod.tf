provider "aws"{
  profile = "default"
  region  = "eu-west-2"
}

resource "aws_s3_bucket" "prod_tf_course" {
  bucket = "tf-materdolorosa-2021"
  acl    = "private"
}

resource "aws_default_vpc" "default"{}

resource "aws_security_group" "prod_web"{
 name        =  "prod_web"
 description =  "Allow standard http and https port inbound and everything outbound"

 ingress {
 from_port   = 80
 to_port     = 80
 protocol    = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
 from_port   = 443
 to_port     = 443
 protocol    = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
 }
 egress {
 from_port   = 0
 to_port     = 0
 protocol    = "-1"
 cidr_blocks = ["0.0.0.0/0"]
 }

tags = {
  "Terraform" : "true"
 }
}

resource "aws_instance" "prod_web" {
  ami           = "ami-0c52c335f3334c594"
  instance_type = "t2.nano"
  
  vpc_security_group_ids = [
    aws_security_group.prod_web.id
  ]

  tags = {
    "Terraform" : "true"
  }
}

resource "aws_eip" "prod_web" {
  instance = aws_instance.prod_web.id
  
  tags = {
    "Terraform" : "true"
  }
}
