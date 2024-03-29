env          = "dev"
bastion_cidr = ["172.31.36.171/32"]

vpc = {
  main = {
    cidr_block = "10.0.0.0/16"
    subnets    = {
      public = {
        name        = "public"
        cidr_blocks = ["10.0.0.0/24", "10.0.1.0/24"]
        azs         = ["us-east-1a", "us-east-1b"]
      }
      web = {
        name        = "web"
        cidr_blocks = ["10.0.2.0/24", "10.0.3.0/24"]
        azs         = ["us-east-1a", "us-east-1b"]
      }
      app = {
        name        = "app"
        cidr_blocks = ["10.0.4.0/24", "10.0.5.0/24"]
        azs         = ["us-east-1a", "us-east-1b"]
      }
      db = {
        name        = "db"
        cidr_blocks = ["10.0.6.0/24", "10.0.7.0/24"]
        azs         = ["us-east-1a", "us-east-1b"]
      }
    }
  }
}

app = {
  frontend = {
    name             = "frontend"
    instance_type    = "t3.small"
    subnet_name      = "web"
    allow_app_cidr   = "public"
    desired_capacity = 2
    max_size         = 10
    min_size         = 2
  }
  catalogue = {
    name             = "catalogue"
    instance_type    = "t3.small"
    subnet_name      = "app"
    allow_app_cidr   = "web"
    desired_capacity = 2
    max_size         = 10
    min_size         = 2
  }
}