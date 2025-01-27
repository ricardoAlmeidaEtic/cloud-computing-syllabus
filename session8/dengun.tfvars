environment = [ "dev", "prod" ]

cluster = {
  name = "dengun"
  nodes = 3
}

deploy = {
  name = "app"
  containerName = "nginx"
  replicas = 1
  image = "nginx:alpine"
  port = 80
}