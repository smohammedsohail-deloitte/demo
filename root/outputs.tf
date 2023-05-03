output "id" {
  description = "The id of the user pool"
  value       = var.enabled ? module.cognito.id.pool[0].id : null
}

output "arn" {
  description = "The ARN of the user pool"
  value       = var.enabled ? module.cognito.arn.pool[0].arn : null
}

output "endpoint" {
  description = "The endpoint name of the user pool. Example format: cognito-idp.REGION.amazonaws.com/xxxx_yyyyy"
  value       = var.enabled ? module.cognito.endpoint.pool[0].endpoint : null
}

output "creation_date" {
  description = "The date the user pool was created"
  value       = var.enabled ? module.cognito.creation_date.pool[0].creation_date : null
}

output "last_modified_date" {
  description = "The date the user pool was last modified"
  value       = var.enabled ? module.cognito.last_modified_date.pool[0].last_modified_date : null
}

#
# aws_cognito_user_pool_domain
#
output "domain_aws_account_id" {
  description = "The AWS account ID for the user pool owner"
  value       = var.enabled ? join("", module.cognito.domain_aws_account_id.domain.*.aws_account_id) : null
}

output "domain_cloudfront_distribution_arn" {
  description = "The ARN of the CloudFront distribution"
  value       = var.enabled ? join("", module.cognito.domain_cloudfront_distribution_arn.domain.*.cloudfront_distribution_arn) : null
}

output "domain_s3_bucket" {
  description = "The S3 bucket where the static files for this domain are stored"
  value       = var.enabled ? join("", module.cognito.domain_s3_bucket.domain.*.s3_bucket) : null
}

output "domain_app_version" {
  description = "The app version"
  value       = var.enabled ? join("", module.cognito.domain_app_version.domain.*.version) : null
}

#
# aws_cognito_user_pool_client
#
output "client_ids" {
  description = "The ids of the user pool clients"
  value       = var.enabled ? module.cognito.client_ids.client.*.id : null
}

output "client_secrets" {
  description = " The client secrets of the user pool clients"
  value       = var.enabled ? module.cognito.client_secrets.client.*.client_secret : null
  sensitive   = true
}

output "client_ids_map" {
  description = "The ids map of the user pool clients"
  value       = var.enabled ? { for k, v in module.cognito.client_ids_map.client : v.name => v.id } : null
}

output "client_secrets_map" {
  description = "The client secrets map of the user pool clients"
  value       = var.enabled ? { for k, v in module.cognito.client_secrets_map.client : v.name => v.client_secret } : null
  sensitive   = true
}

#
# aws_cognito_resource_servers
#
output "resource_servers_scope_identifiers" {
  description = " A list of all scopes configured in the format identifier/scope_name"
  value       = var.enabled ? module.cognito.resource_servers_scope_identifiers.resource.*.scope_identifiers : null
}
