provider "aws"{
  profile = "default"
  region  = "eu-west-2"
}

resource "aws_s3_bucket" "prod_tf_course" {
  bucket = "tf-materdolorosa-2021"
  acl    = "private"
}

resource "aws_default_vpc" "default"{} 
