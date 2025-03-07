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
