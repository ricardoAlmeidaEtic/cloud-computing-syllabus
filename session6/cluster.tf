resource "minikube_cluster" "my-cluesterte" {
    cluster_name="etic-cluster"
    driver="docker"
    nodes=2
    addons=[
        "ingress"
    ]
}