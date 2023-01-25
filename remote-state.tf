module "backend_s3" {
  source                          = "./s3"
  bucket_name                     = "back-state-bucket"
  bucket_versioning_configuration = "Enabled"
}

module "backend_dynamodb" {
  source         = "./dynamoDB"
  table_name     = "DynamoDB-state"
  table_hash_key = "LockID"
  attribute_name = "LockID"
  attribute_type = "S"
}

# terraform {
#   backend "s3" {
#     bucket         = "back-state-bucket"
#     key            = "dev/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "DynamoDB-state"
#     encrypt        = true
#   }
# }