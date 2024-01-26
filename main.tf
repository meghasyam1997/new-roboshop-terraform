module "vpc" {
  source = "git::https://github.com/meghasyam1997/new-vpc-terraform.git"

  for_each = var.vpc
  cidr_block = each.value["cidr_block"]
}