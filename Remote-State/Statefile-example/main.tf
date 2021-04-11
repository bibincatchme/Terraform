provider "aws" {
    region =   "eu-west-1"
}


## 1st create only s3 bucket 
resource "aws_s3_bucket" "my-s3" {
  bucket = "statefiletest-bibincatchme"
  acl    = "private"

  tags = {
    Name        = "Mybucket"
    Environment = "Dev"
  }
}
