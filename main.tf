module "iam" {
  source = "./modules/iam"
  count  = var.enable_iam ? 1 : 0

  bucket_arn = module.s3[0].bucket_arn
  cdn_arn    = module.cloudfront[0].cf_arn
}

module "lambda" {
  source = "./modules/lambda"
  count  = var.enable_lambda ? 1 : 0

  lambda_role = module.iam[0].role_arn
  exec_arn    = module.api_gateway[0].execution_arn
}

module "api_gateway" {
  source = "./modules/api_gateway"
  count  = var.enable_api_gw ? 1 : 0

  #allow_origins = module.cloudfront[0].cf_domain_name
  #lambda_func_name = module.lambda[0].func_name
  target_uri = module.lambda[0].invoke_arn
}

module "s3" {
  source = "./modules/s3"
  count  = var.enable_s3 ? 1 : 0

  s3_bucket_policy = module.iam[0].policy_doc_with_cond_json
  backend_endpoint = module.api_gateway[0].invoke_url
  #depends_on       = [module.api_gateway[0]]
}

module "cloudfront" {
  source = "./modules/cdn"
  count  = var.enable_cf ? 1 : 0

  bucket_domain_name = module.s3[0].bucket_domain_name
  origin_id          = module.s3[0].bucket_id
  bucket_arn         = module.s3[0].bucket_arn
}

