resource "kubernetes_namespace" "my-ns" {
  for_each = toset([var.environment])

  metadata {
    name = each.value
  }
}