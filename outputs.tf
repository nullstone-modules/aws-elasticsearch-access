output "domain_arn" {
  value       = local.domain_arn
  description = "string ||| ARN of the OpenSearch domain"
}

output "domain_endpoint" {
  value       = local.domain_endpoint
  description = "string ||| The endpoint URL to submit index, search, and data upload requests"
}
