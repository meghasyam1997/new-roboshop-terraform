env = "dev"

vpc = {
  main = {
    cidr_block = "10.0.0.0/16"
    subnets    = {
      public = {
        name        = "public"
        cidr_blocks = ["10.0.0.0/24", "10.0.1.0/24"]
        azs         = ["us-east-1", "us-east-2"]
      }
    }
  }
}