output "env" {
  value = [
    {
      name  = "OPENSEARCH_URL"
      value = local.db_url
    }
  ]
}
