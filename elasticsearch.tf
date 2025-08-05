data "ns_connection" "elasticsearch" {
  name     = "elasticsearch"
  contract = "datastore/aws/elasticsearch:*"
}

locals {
  serverless = try(data.ns_connection.elasticsearch.outputs.serverless, false)

  db_security_group_id = try(data.ns_connection.elasticsearch.outputs.db_security_group_id, "")
  db_arn               = data.ns_connection.elasticsearch.outputs.db_arn
  db_protocol          = data.ns_connection.elasticsearch.outputs.db_protocol
  db_hostname          = data.ns_connection.elasticsearch.outputs.db_hostname
  db_port              = data.ns_connection.elasticsearch.outputs.db_port
  db_url               = "${local.db_protocol}://${local.db_hostname}:${local.db_port}"

  collection_name = try(data.ns_connection.elasticsearch.outputs.collection_name, "")
}
