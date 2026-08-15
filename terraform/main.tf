module "vpc" {
  source = "./modules/vpc"
}

module "eks" {
  source = "./modules/eks"

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets
}

module "iam" {
  source = "./modules/iam"

  cluster_name = module.eks.cluster_name
}

module "serverless" {
  source = "./modules/serverless"
}
