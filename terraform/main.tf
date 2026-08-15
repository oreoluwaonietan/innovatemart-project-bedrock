module "github_oidc" {
  source      = "./modules/github-oidc"
  github_repo = "oreoluwaonietan/innovatemart-project-bedrock"
}

module "vpc" {
  source = "./modules/vpc"
}

module "eks" {
  source = "./modules/eks"

  vpc_id                   = module.vpc.vpc_id
  private_subnet_ids       = module.vpc.private_subnets
  github_actions_role_arn  = module.github_oidc.github_actions_role_arn
}

module "serverless" {
  source = "./modules/serverless"
}

module "iam" {
  source = "./modules/iam"

  cluster_name      = module.eks.cluster_name
  assets_bucket_arn = module.serverless.assets_bucket_arn
}

module "data" {
  source = "./modules/data"

  vpc_id                  = module.vpc.vpc_id
  private_subnet_ids      = module.vpc.private_subnets
  node_security_group_id  = module.eks.node_security_group_id
  oidc_provider_arn       = module.eks.oidc_provider_arn
  oidc_provider_url       = module.eks.cluster_oidc_issuer_url
}

module "alb_controller" {
  source = "./modules/alb-controller"

  cluster_name       = module.eks.cluster_name
  oidc_provider_arn  = module.eks.oidc_provider_arn
  oidc_provider_url  = module.eks.cluster_oidc_issuer_url
}
