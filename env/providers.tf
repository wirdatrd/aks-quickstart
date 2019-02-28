provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  version         = "~> 1.11"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

provider "azuread" {
  subscription_id = "${var.subscription_id}"
  version = "~>0.1.0"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

provider "random" {
  version = "~> 1.3"
}

provider "kubernetes" {
  version                = "~> 1.1"
  host                   = "${azurerm_kubernetes_cluster.demo.kube_config.0.host}"
  client_certificate     = "${base64decode(azurerm_kubernetes_cluster.demo.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(azurerm_kubernetes_cluster.demo.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(azurerm_kubernetes_cluster.demo.kube_config.0.cluster_ca_certificate)}"
}

provider "tls" {
  version = "~> 1.2"
}

provider "helm" {
  service_account = "clustertiller"
    kubernetes {
      host                   = "${azurerm_kubernetes_cluster.demo.kube_config.0.host}"
      client_certificate     = "${base64decode(azurerm_kubernetes_cluster.demo.kube_config.0.client_certificate)}"
      client_key             = "${base64decode(azurerm_kubernetes_cluster.demo.kube_config.0.client_key)}"
      cluster_ca_certificate = "${base64decode(azurerm_kubernetes_cluster.demo.kube_config.0.cluster_ca_certificate)}"
    }
}
