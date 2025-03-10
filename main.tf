module "s3" {
  source = "./modules/s3"
  count = var.enable_s3 ? 1 : 0
}

module "cloudfront" {
  source = "./modules/cdn"
  count = var.enable_cf ? 1 : 0

  bucket_domain_name = module.s3[0].bucket_domain_name
  origin_id = module.s3[0].bucket_id
  bucket_arn = module.s3[0].bucket_arn
}

module "lambda" {
  source = "./modules/lambda"
  count = var.enable_lambda ? 1 : 0
}

module "api_gateway" {
  source = "./modules/api_gateway"
  count = var.enable_api_gw ? 1 : 0

  lambda_func_name = module.lambda[0].func_name
  target_uri = module.lambda[0].invoke_arn
}
