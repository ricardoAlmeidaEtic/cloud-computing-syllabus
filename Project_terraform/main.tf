terraform {
  required_providers {
    minikube = {
      source = "scott-the-programmer/minikube"
      version = "0.4.4"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.35.1"
    }
  }
}

provider "minikube" {
  # Configuration options
}

provider "kubernetes" {
  # Configuration options
  host = minikube_cluster.cluster.host
  cluster_ca_certificate = minikube_cluster.cluster.cluster_ca_certificate
  client_certificate = minikube_cluster.cluster.client_certificate
  client_key = minikube_cluster.cluster.client_key
}

variable "namespace" {
  type = list(string)
  description = "K8s namespaces"
}

variable "app" {
  description = "App definition"
  type = object({
    name = string
    replicas = map(number)
    image = string
    containerName = string
    port = number
  })
  nullable = false
}

resource "minikube_cluster" "cluster" {
  cluster_name = ex-tf
  nodes = 2
}

resource "kubernetes" "environment" {
  for_each = toset(var.namespace)
  metadata {
    name = each.key
  }
}

resource "kubernetes_deployment_v1" "app" {
  for_each = toset(var.namespace)
 metadata {
    name      = "${var.appy.name}-${each.key}"
    namespace = each.key
    labels = {
      app = "${var.appy.name}-${each.key}"
    }
  }

  spec {
    replicas = var.app.replicas

    selector {
      match_labels = {
        app = "${var.appy.name}-${each.key}"
      }
    }

    template {
      metadata {
        labels = {
          app = var.app.name
        }
      }

      spec {
        container {
          name  = var.appy.containerName
          image = var.app.image
          port {
            container_port = var.app.port
          }
        }
      }
    }
  }
}