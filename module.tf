module "db_servers" {
  for_each = var.db_server
  source = "./module"
  component_name = each.value["name"]
  instance_type = each.value["instance_type"]
  env = var.env
  password = lookup(each.value,"password","null")
  app_type = "db"
}
module "app_servers" {
  depends_on = [module.db_servers]
  for_each = var.app_server
  source = "./module"
  component_name = each.value["name"]
  instance_type = each.value["instance_type"]
  env = var.env
  password = lookup(each.value,"password","null")
  app_type = "app"
}