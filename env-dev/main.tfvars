env = "dev"

app_server = {
  frontend = {
    name          = "frontend"
    instance_type = "t3.small"
  }
  cart = {
    name          = "cart"
    instance_type = "t3.small"
  }
  catalogue = {
    name          = "catalogue"
    instance_type = "t3.small"
  }
  payment = {
    name          = "payment"
    instance_type = "t3.small"
    password = "roboshop123"
  }
  shipping = {
    name          = "shipping"
    instance_type = "t3.small"
    password = "RoboShop@1"
  }
  user = {
    name          = "user"
    instance_type = "t3.small"
  }
}

db_server = {
  mysql = {
    name = "mysql"
    instance_type = "t3.small"
    password = "RoboShop@1"
  }
  mongodb = {
    name          = "mongodb"
    instance_type = "t3.small"
  }
  rabbitmq = {
    name          = "rabbitmq"
    instance_type = "t3.small"
    password = "roboshop123"
  }
  redis = {
    name          = "redis"
    instance_type = "t3.small"
  }
}