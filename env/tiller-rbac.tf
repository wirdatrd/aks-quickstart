resource "kubernetes_service_account" "tiller" {
  metadata {
    name = "tiller"
    namespace = "dev"
  }
}

resource "kubernetes_cluster_role" "tiller" {
    metadata {
        name = "tiller-manager"
    }

    rule {
        api_groups = ["", "batch", "extensions", "apps"]
        resources  = ["*"]
        verbs      = ["*"]
    }
}

resource "kubernetes_cluster_role_binding" "tiller" {
    metadata {
        name = "tiller-binding"
    }
    role_ref {
        api_group = "rbac.authorization.k8s.io"
        kind = "ClusterRole"
        name = "tiller-manager"
    }
    subject {
        kind = "ServiceAccount"
        name = "tiller"
        namespace = "dev"
        api_group = ""
    }
}
