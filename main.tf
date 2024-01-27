module "vpc" {
  source = "git::https://github.com/meghasyam1997/new-vpc-terraform.git"

  for_each   = var.vpc
  cidr_block = each.value["cidr_block"]
  subnets    = each.value["subnets"]

  tags = local.tags
  env  = var.env
}

module "web" {
  source = "git::https://github.com/meghasyam1997/new-tf-module-app.git"

  for_each = var.app
  instance_type = each.value["instance_type"]
  name = each.value["name"]
  subnet_ids = element(lookup(lookup(lookup(lookup(module.vpc, "main" , null), "subnets" , null), each.value["subnet_name"],null), "subnet_ids", null), 0)

  env = var.env

}