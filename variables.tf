variable "app_metadata" {
  description = <<EOF
Nullstone automatically injects metadata from the app module into this module through this variable.
This variable is a reserved variable for capabilities.
EOF

  type    = map(string)
  default = {}
}

locals {
  role_name         = var.app_metadata["role_name"]
  role_arn          = try(var.app_metadata["role_arn"], "arn:aws:iam::${data.aws_caller_identity.this.account_id}:role/${local.role_name}")
  security_group_id = var.app_metadata["security_group_id"]
}
