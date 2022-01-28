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
  tags                 = data.ns_workspace.this.tags
  db_security_group_id = data.ns_connection.opensearch.outputs.db_security_group_id
  db_arn               = data.ns_connection.opensearch.outputs.db_arn
  db_protocol          = data.ns_connection.opensearch.outputs.db_protocol
  db_hostname          = data.ns_connection.opensearch.outputs.db_hostname
  db_port              = data.ns_connection.opensearch.outputs.db_port
  db_url               = "${local.db_protocol}://${local.db_hostname}:${local.db_port}"
}
