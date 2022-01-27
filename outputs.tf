output "env" {
  value = [
    {
      name  = "OPENSEARCH_ENDPOINT"
      value = local.domain_endpoint
    }
  ]
}
