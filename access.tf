resource "aws_security_group_rule" "app-to-datastore" {
  count = local.serverless ? 0 : 1

  security_group_id        = local.security_group_id
  type                     = "egress"
  from_port                = local.db_port
  to_port                  = local.db_port
  protocol                 = "tcp"
  source_security_group_id = local.db_security_group_id
}

resource "aws_security_group_rule" "datastore-from-app" {
  count = local.serverless ? 0 : 1

  security_group_id        = local.db_security_group_id
  type                     = "ingress"
  from_port                = local.db_port
  to_port                  = local.db_port
  protocol                 = "tcp"
  source_security_group_id = local.security_group_id
}

locals {
  serverless_access_policy = {
    Rules = [
      {
        ResourceType = "collection"
        Resource     = ["collection/${local.collection_name}"]
        Permission = [
          "aoss:CreateCollection",
          "aoss:DeleteCollection",
          "aoss:DescribeCollection",
          "aoss:UpdateCollection"
        ]
      },
      {
        ResourceType = "index"
        Resource     = ["collection/${local.collection_name}/index/*"]
        Permission = [
          "aoss:CreateIndex",
          "aoss:UpdateIndex",
          "aoss:DeleteIndex",
          "aoss:DescribeIndex",
          "aoss:WriteDocument",
          "aoss:ReadDocument"
        ]
      }
    ],
    Principal = [local.role_arn]
  }
}

resource "aws_opensearchserverless_access_policy" "serverless_access" {
  count = local.serverless ? 1 : 0

  name        = "${local.collection_name}-${random_string.resource_suffix.result}-full-access"
  type        = "data"
  description = "Grants full access to collection ${local.collection_name}"
  policy      = jsonencode(local.serverless_access_policy)
}
