terraform {
  required_providers {
    ns = {
      source = "nullstone-io/ns"
    }
  }
}

data "ns_workspace" "this" {}

data "ns_connection" "opensearch" {
  name = "opensearch"
  type = "aws-opensearch"
}

locals {
  tags                     = data.ns_workspace.this.tags
  domain_security_group_id = data.ns_connection.opensearch.outputs.domain_security_group_id
  domain_arn               = data.ns_connection.opensearch.outputs.domain_arn
  domain_endpoint          = data.ns_connection.opensearch.outputs.domain_endpoint
  domain_port              = 443
}
