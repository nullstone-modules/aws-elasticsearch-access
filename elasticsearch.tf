data "ns_connection" "elasticsearch" {
  name     = "elasticsearch"
  type     = "elasticsearch/aws"
  contract = "datastore/aws/elasticsearch:*"
}

locals {
  db_security_group_id = data.ns_connection.elasticsearch.outputs.db_security_group_id
  db_arn               = data.ns_connection.elasticsearch.outputs.db_arn
  db_protocol          = data.ns_connection.elasticsearch.outputs.db_protocol
  db_hostname          = data.ns_connection.elasticsearch.outputs.db_hostname
  db_port              = data.ns_connection.elasticsearch.outputs.db_port
  db_url               = "${local.db_protocol}://${local.db_hostname}:${local.db_port}"
}
