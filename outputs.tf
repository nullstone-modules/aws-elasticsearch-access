output "env" {
  value = [
    {
      name  = "ELASTICSEARCH_URL"
      value = local.db_url
    }
  ]
}
