# AWS CloudFront Terraform module

Terraform is an open-source tool for building, changing, and versioning infrastructure. It allows you to define your infrastructure as code, which means you can use a simple, declarative language to describe the resources you want to create, modify, or destroy in your cloud environment. Terraform supports a wide range of cloud providers, including Amazon Web Services (AWS), Microsoft Azure, Google Cloud Platform (GCP), and many more.

Amazon CloudFront is a content delivery network (CDN) service provided by Amazon Web Services (AWS). CloudFront is designed to deliver content, such as static and dynamic web pages, video streams, and APIs, to users around the world with low latency and high transfer speeds.

CloudFront works by caching content at edge locations, which are geographically distributed data centers around the world. When a user requests content, CloudFront routes the request to the nearest edge location, which then serves the content to the user. This helps to reduce the latency and improve the transfer speed of the content delivery.

Terraform module which creates AWS CloudFront resources and can be integrated with API Gateway REST API.

## Supported Features

- Conditional creation for many types of resources
- access logging
- origins and origin groups
- caching behaviours
- Origin Access Identities (with S3 bucket policy)
- Lambda@Edge
- ACM certificate
- Route53 record
- API Gateway@Edge

## Usage

### CloudFront distribution with versioning enabled

```hcl
module "cdn" {
  source = "terraform-aws-modules/cloudfront/aws"

  aliases = ["cdn.example.com"]

  comment             = "My awesome CloudFront"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  wait_for_deployment = false

  create_origin_access_identity = true
  origin_access_identities = {
    s3_bucket_one = "My awesome CloudFront can access"
  }

  logging_config = {
    bucket = "logs-my-cdn.s3.amazonaws.com"
  }

  origin = {
    something = {
      domain_name = "something.example.com"
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "match-viewer"
        origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
      }
    }

    s3_one = {
      domain_name = "my-s3-bycket.s3.amazonaws.com"
      s3_origin_config = {
        origin_access_identity = "s3_bucket_one"
      }
    }
  }

  default_cache_behavior = {
    target_origin_id           = "something"
    viewer_protocol_policy     = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }

  ordered_cache_behavior = [
    {
      path_pattern           = "/static/*"
      target_origin_id       = "s3_one"
      viewer_protocol_policy = "redirect-to-https"

      allowed_methods = ["GET", "HEAD", "OPTIONS"]
      cached_methods  = ["GET", "HEAD"]
      compress        = true
      query_string    = true
    }
  ]

  viewer_certificate = {
    acm_certificate_arn = "arn:aws:acm:us-east-1:135367859851:certificate/1032b155-22da-4ae0-9f69-e206f825458b"
    ssl_support_method  = "sni-only"
  }
}
```

## Examples:

- Complete - Complete example which creates AWS CloudFront distribution and integrates it with other terraform-aws-modules to create additional resources: S3 buckets, Lambda Functions, CloudFront Functions, ACM Certificate, Route53 Records.

## Requirements

| Name | Version |
|------|---------|
| [terraform](#requirement\_terraform) | >= 0.13.1 |
|  [aws](#requirement\_aws) | >= 4.29 |

## Providers

| Name | Version |
|------|---------|
|  [aws](#provider\_aws) | >= 4.29 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_monitoring_subscription.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_monitoring_subscription) | resource |
| [aws_cloudfront_origin_access_control.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control) | resource |
| [aws_cloudfront_origin_access_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
|  [aliases](#input\_aliases) | Extra CNAMEs (alternate domain names), if any, for this distribution. | `list(string)` | `null` | no |
|  [comment](#input\_comment) | Any comments you want to include about the distribution. | `string` | `null` | no |
| [create\_distribution](#input\_create\_distribution) | Controls if CloudFront distribution should be created | `bool` | `true` | no |
|  [create\_monitoring\_subscription](#input\_create\_monitoring\_subscription) | If enabled, the resource for monitoring subscription will created. | `bool` | `false` | no |
|  [create\_origin\_access\_control](#input\_create\_origin\_access\_control) | Controls if CloudFront origin access control should be created | `bool` | `false` | no |
| [create\_origin\_access\_identity](#input\_create\_origin\_access\_identity) | Controls if CloudFront origin access identity should be created | `bool` | `false` | no |
|  [custom\_error\_response](#input\_custom\_error\_response) | One or more custom error response elements | `any` | `{}` | no |
|  [default\_cache\_behavior](#input\_default\_cache\_behavior) | The default cache behavior for this distribution | `any` | `null` | no |
|  [default\_root\_object](#input\_default\_root\_object) | The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL. | `string` | `null` | no |
|  [enabled](#input\_enabled) | Whether the distribution is enabled to accept end user requests for content. | `bool` | `true` | no |
|  [geo\_restriction](#input\_geo\_restriction) | The restriction configuration for this distribution (geo\_restrictions) | `any` | `{}` | no |
|  [http\_version](#input\_http\_version) | The maximum HTTP version to support on the distribution. Allowed values are http1.1, http2, http2and3, and http3. The default is http2. | `string` | `"http2"` | no |
|  [is\_ipv6\_enabled](#input\_is\_ipv6\_enabled) | Whether the IPv6 is enabled for the distribution. | `bool` | `null` | no |
|  [logging\_config](#input\_logging\_config) | The logging configuration that controls how logs are written to your distribution (maximum one). | `any` | `{}` | no |
|  [ordered\_cache\_behavior](#input\_ordered\_cache\_behavior) | An ordered list of cache behaviors resource for this distribution. List from top to bottom in order of precedence. The topmost cache behavior will have precedence 0. | `any` | `[]` | no |
|  [origin](#input\_origin) | One or more origins for this distribution (multiples allowed). | `any` | `null` | no |
|  [origin\_access\_control](#input\_origin\_access\_control) | Map of CloudFront origin access control | <pre>map(object({<br>    description      = string<br>    origin_type      = string<br>    signing_behavior = string<br>    signing_protocol = string<br>  }))</pre> | <pre>{<br>  "s3": {<br>    "description": "",<br>    "origin_type": "s3",<br>    "signing_behavior": "always",<br>    "signing_protocol": "sigv4"<br>  }<br>}</pre> | no |
|  [origin\_access\_identities](#input\_origin\_access\_identities) | Map of CloudFront origin access identities (value as a comment) | `map(string)` | `{}` | no |
|  [origin\_group](#input\_origin\_group) | One or more origin\_group for this distribution (multiples allowed). | `any` | `{}` | no |
|  [price\_class](#input\_price\_class) | The price class for this distribution. One of PriceClass\_All, PriceClass\_200, PriceClass\_100 | `string` | `null` | no |
|  [realtime\_metrics\_subscription\_status](#input\_realtime\_metrics\_subscription\_status) | A flag that indicates whether additional CloudWatch metrics are enabled for a given CloudFront distribution. Valid values are `Enabled` and `Disabled`. | `string` | `"Enabled"` | no |
|  [retain\_on\_delete](#input\_retain\_on\_delete) | Disables the distribution instead of deleting it when destroying the resource through Terraform. If this is set, the distribution needs to be deleted manually afterwards. | `bool` | `false` | no |
|  [tags](#input\_tags) | A map of tags to assign to the resource. | `map(string)` | `null` | no |
|  [viewer\_certificate](#input\_viewer\_certificate) | The SSL configuration for this distribution | `any` | <pre>{<br>  "cloudfront_default_certificate": true,<br>  "minimum_protocol_version": "TLSv1"<br>}</pre> | no |
|  [wait\_for\_deployment](#input\_wait\_for\_deployment) | If enabled, the resource will wait for the distribution status to change from InProgress to Deployed. Setting this to false will skip the process. | `bool` | `true` | no |
|  [web\_acl\_id](#input\_web\_acl\_id) | If you're using AWS WAF to filter CloudFront requests, the Id of the AWS WAF web ACL that is associated with the distribution. The WAF Web ACL must exist in the WAF Global (CloudFront) region and the credentials configuring this argument must have waf:GetWebACL permissions assigned. If using WAFv2, provide the ARN of the web ACL. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
|  [cloudfront\_distribution\_arn](#output\_cloudfront\_distribution\_arn) | The ARN (Amazon Resource Name) for the distribution. |
| [cloudfront\_distribution\_caller\_reference](#output\_cloudfront\_distribution\_caller\_reference) | Internal value used by CloudFront to allow future updates to the distribution configuration. |
|  [cloudfront\_distribution\_domain\_name](#output\_cloudfront\_distribution\_domain\_name) | The domain name corresponding to the distribution. |
|  [cloudfront\_distribution\_etag](#output\_cloudfront\_distribution\_etag) | The current version of the distribution's information. |
|  [cloudfront\_distribution\_hosted\_zone\_id](#output\_cloudfront\_distribution\_hosted\_zone\_id) | The CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to. |
|  [cloudfront\_distribution\_id](#output\_cloudfront\_distribution\_id) | The identifier for the distribution. |
|  [cloudfront\_distribution\_in\_progress\_validation\_batches](#output\_cloudfront\_distribution\_in\_progress\_validation\_batches) | The number of invalidation batches currently in progress. |
| [cloudfront\_distribution\_last\_modified\_time](#output\_cloudfront\_distribution\_last\_modified\_time) | The date and time the distribution was last modified. |
|  [cloudfront\_distribution\_status](#output\_cloudfront\_distribution\_status) | The current status of the distribution. Deployed if the distribution's information is fully propagated throughout the Amazon CloudFront system. |
|  [cloudfront\_distribution\_tags](#output\_cloudfront\_distribution\_tags) | Tags of the distribution's |
|  [cloudfront\_distribution\_trusted\_signers](#output\_cloudfront\_distribution\_trusted\_signers) | List of nested attributes for active trusted signers, if the distribution is set up to serve private content with signed URLs |
|  [cloudfront\_monitoring\_subscription\_id](#output\_cloudfront\_monitoring\_subscription\_id) | The ID of the CloudFront monitoring subscription, which corresponds to the `distribution_id`. |
|  [cloudfront\_origin\_access\_controls](#output\_cloudfront\_origin\_access\_controls) | The origin access controls created |
|  [cloudfront\_origin\_access\_controls\_ids](#output\_cloudfront\_origin\_access\_controls\_ids) | The IDS of the origin access identities created |
|  [cloudfront\_origin\_access\_identities](#output\_cloudfront\_origin\_access\_identities) | The origin access identities created |
|  [cloudfront\_origin\_access\_identity\_iam\_arns](#output\_cloudfront\_origin\_access\_identity\_iam\_arns) | The IAM arns of the origin access identities created |
| [cloudfront\_origin\_access\_identity\_ids](#output\_cloudfront\_origin\_access\_identity\_ids) | The IDS of the origin access identities created |
