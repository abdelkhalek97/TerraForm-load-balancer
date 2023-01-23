module "backend_s3" {
  source                          = "./s3"
  bucket_name                     = "up-and-running-stat"
  bucket_versioning_configuration = "Enabled"
}

module "backend_dynamodb" {
  source         = "./dynamoDB"
  table_name     = "locks-dynamodb-table"
  table_hash_key = "LockID"
  attribute_name = "LockID"
  attribute_type = "S"
}

terraform {
  backend "s3" {
    bucket         = "up-and-running-stat"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "locks-dynamodb-table"
    encrypt        = true
  }
}