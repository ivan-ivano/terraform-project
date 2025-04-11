
# module "label_courses" {
#   source   = "cloudposse/label/null"
#   # Cloud Posse recommends pinning every module to a specific version
#   version = "0.25.0"
#   context = module.label.context
#   name = "courses"
# }

# module "label_authors" {
#   source   = "cloudposse/label/null"
#   # Cloud Posse recommends pinning every module to a specific version
#   version = "0.25.0"

#   context = module.label.context
#   name = "authors"
# }

# resource "aws_dynamodb_table" "courses" {
#   name           = module.label_courses.id
#   hash_key       = "TestTableHashKey"  
#   billing_mode   = "PAY_PER_REQUEST"  
#   attribute {
#     name = "TestTableHashKey"
#     type = "S"  
#   }

# }

# resource "aws_dynamodb_table" "authors" {
#   name           = module.label_authors.id
#   hash_key       = "TestTableHashKey" 
#   billing_mode   = "PAY_PER_REQUEST"  

#   attribute {
#     name = "TestTableHashKey"
#     type = "S"  
#   }

# }

module "table_courses" {
  source  = "./modules/dynamodb"
  context = module.label.context
  name    = "courses"
}

module "table_authors" {
  source  = "./modules/dynamodb"
  context = module.label.context
  name    = "authors"
}

module "lambda_functions" {
  source            = "./modules/lambda"
  context           = module.label.context
  courses_table     = module.table_courses.table_name
  authors_table     = module.table_authors.table_name
  courses_table_arn = module.table_courses.table_arn
  authors_table_arn = module.table_authors.table_arn
}
