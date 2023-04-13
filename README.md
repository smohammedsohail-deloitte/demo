
# AWS S3 bucket Terraform module

Terraform is an infrastructure as code (IaC) tool that allows you to manage and provision your infrastructure across multiple cloud providers or on-premise environments. It uses a declarative language to describe the desired state of your infrastructure and automates the creation and modification of resources.

Amazon S3 (Simple Storage Service) is a highly scalable and secure object storage service provided by Amazon Web Services (AWS). It is designed to store and retrieve any amount of data from anywhere on the web.

S3 provides developers and businesses with a highly durable, available, and secure storage infrastructure at a low cost. It allows users to store and retrieve data of any size, including documents, images, videos, and application backups. S3 also provides features such as versioning, lifecycle policies, access control, and encryption to help users manage their data efficiently and securely.

S3 is commonly used to store and serve static files for web applications, host data backups, and store media files for content delivery networks (CDNs). It can also be integrated with other AWS services such as Amazon CloudFront, Amazon EC2, and Amazon RDS to create powerful and scalable web applications.

## Supported Features

- static web-site hosting
- access logging
- versioning
- CORS
- lifecycle rules
- server-side encryption
- object locking
- Cross-Region Replication (CRR)
- ELB log delivery bucket policy
- ALB/NLB log delivery bucket policy

## Usage

### Private bucket with versioning enabled

```hcl
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "my-s3-bucket"
  acl    = "private"

  versioning = {
    enabled = true
  }

}
```
### Bucket with ELB access log delivery policy attached

```hcl
module "s3_bucket_for_logs" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "my-s3-bucket-for-logs"
  acl    = "log-delivery-write"

  # Allow deletion of non-empty bucket
  force_destroy = true

  attach_elb_log_delivery_policy = true
}
```

### Bucket with ALB/NLB access log delivery policy attached

```hcl
module "s3_bucket_for_logs" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "my-s3-bucket-for-logs"
  acl    = "log-delivery-write"

  # Allow deletion of non-empty bucket
  force_destroy = true

  attach_elb_log_delivery_policy = true  # Required for ALB logs
  attach_lb_log_delivery_policy  = true  # Required for ALB/NLB logs
}
```

### Static Web hosting

```hcl

module "s3_web_hosting" {
  website = {
    # conflicts with "error_document"
    #        redirect_all_requests_to = {
    #          host_name = "https://modules.tf"
    #        }

    index_document = "index.html"
    error_document = "error.html"
    routing_rules = [{
      condition = {
        key_prefix_equals = "docs/"
      },
      redirect = {
        replace_key_prefix_with = "documents/"
      }
      }, {
      condition = {
        http_error_code_returned_equals = 404
        key_prefix_equals               = "archive/"
      },
      redirect = {
        host_name          = "archive.myhost.com"
        http_redirect_code = 301
        protocol           = "https"
        replace_key_with   = "not_found.html"
      }
    }]
  }
}

```

## Conditional creation

Sometimes you need to have a way to create S3 resources conditionally but Terraform does not allow to use `count` inside `module` block, so the solution is to specify argument `create_bucket`.

```hcl
# This S3 bucket will not be created
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  create_bucket = false
  # ... omitted
}
```

## Examples:

- Complete - Complete S3 bucket with most of supported features enabled
- Cross-Region Replication - S3 bucket with Cross-Region Replication (CRR) enabled
- S3 Bucket Notifications - S3 bucket notifications to Lambda functions, SQS queues, and SNS topics.
- S3 Bucket Object - Manage S3 bucket objects.

## Requirements

| Name | Version |
|------|---------|
|  [terraform](#requirement\_terraform) | >= 0.13.1 |
|  [aws](#requirement\_aws) | >= 4.9 |

## Providers

| Name | Version |
|------|---------|
|  [aws](#provider\_aws) | >= 4.9 |


## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_accelerate_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_accelerate_configuration) | resource |
| [aws_s3_bucket_acl.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_analytics_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_analytics_configuration) | resource |
| [aws_s3_bucket_cors_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_cors_configuration) | resource |
| [aws_s3_bucket_intelligent_tiering_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_intelligent_tiering_configuration) | resource |
| [aws_s3_bucket_inventory.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_inventory) | resource |
| [aws_s3_bucket_lifecycle_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_logging.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_metric.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_metric) | resource |
| [aws_s3_bucket_object_lock_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object_lock_configuration) | resource |
| [aws_s3_bucket_ownership_controls.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_replication_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_replication_configuration) | resource |
| [aws_s3_bucket_request_payment_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_request_payment_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_website_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_canonical_user_id.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/canonical_user_id) | data source |
| [aws_iam_policy_document.combined](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.deny_insecure_transport](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.elb_log_delivery](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.inventory_and_analytics_destination_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lb_log_delivery](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.require_latest_tls](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
|  [acceleration\_status](#input\_acceleration\_status) | (Optional) Sets the accelerate configuration of an existing bucket. Can be Enabled or Suspended. | `string` | `null` | no |
|  [acl](#input\_acl) | (Optional) The canned ACL to apply. Conflicts with `grant` | `string` | `null` | no |
|  [analytics\_configuration](#input\_analytics\_configuration) | Map containing bucket analytics configuration. | `any` | `{}` | no |
|  [analytics\_self\_source\_destination](#input\_analytics\_self\_source\_destination) | Whether or not the analytics source bucket is also the destination bucket. | `bool` | `false` | no |
|  [analytics\_source\_account\_id](#input\_analytics\_source\_account\_id) | The analytics source account id. | `string` | `null` | no |
|  [analytics\_source\_bucket\_arn](#input\_analytics\_source\_bucket\_arn) | The analytics source bucket ARN. | `string` | `null` | no |
|  [attach\_analytics\_destination\_policy](#input\_attach\_analytics\_destination\_policy) | Controls if S3 bucket should have bucket analytics destination policy attached. | `bool` | `false` | no |
| [attach\_deny\_insecure\_transport\_policy](#input\_attach\_deny\_insecure\_transport\_policy) | Controls if S3 bucket should have deny non-SSL transport policy attached | `bool` | `false` | no |
|  [attach\_elb\_log\_delivery\_policy](#input\_attach\_elb\_log\_delivery\_policy) | Controls if S3 bucket should have ELB log delivery policy attached | `bool` | `false` | no |
|  [attach\_inventory\_destination\_policy](#input\_attach\_inventory\_destination\_policy) | Controls if S3 bucket should have bucket inventory destination policy attached. | `bool` | `false` | no |
| [attach\_lb\_log\_delivery\_policy](#input\_attach\_lb\_log\_delivery\_policy) | Controls if S3 bucket should have ALB/NLB log delivery policy attached | `bool` | `false` | no |
|  [attach\_policy](#input\_attach\_policy) | Controls if S3 bucket should have bucket policy attached (set to `true` to use value of `policy` as bucket policy) | `bool` | `false` | no |
|  [attach\_public\_policy](#input\_attach\_public\_policy) | Controls if a user defined public bucket policy will be attached (set to `false` to allow upstream to apply defaults to the bucket) | `bool` | `true` | no |
|  [attach\_require\_latest\_tls\_policy](#input\_attach\_require\_latest\_tls\_policy) | Controls if S3 bucket should require the latest version of TLS | `bool` | `false` | no |
|  [block\_public\_acls](#input\_block\_public\_acls) | Whether Amazon S3 should block public ACLs for this bucket. | `bool` | `false` | no |
|  [block\_public\_policy](#input\_block\_public\_policy) | Whether Amazon S3 should block public bucket policies for this bucket. | `bool` | `false` | no |
|  [bucket](#input\_bucket) | (Optional, Forces new resource) The name of the bucket. If omitted, Terraform will assign a random, unique name. | `string` | `null` | no |
|  [bucket\_prefix](#input\_bucket\_prefix) | (Optional, Forces new resource) Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket. | `string` | `null` | no |
|  [control\_object\_ownership](#input\_control\_object\_ownership) | Whether to manage S3 Bucket Ownership Controls on this bucket. | `bool` | `false` | no |
|  [cors\_rule](#input\_cors\_rule) | List of maps containing rules for Cross-Origin Resource Sharing. | `any` | `[]` | no |
|  [create\_bucket](#input\_create\_bucket) | Controls if S3 bucket should be created | `bool` | `true` | no |
|  [expected\_bucket\_owner](#input\_expected\_bucket\_owner) | The account ID of the expected bucket owner | `string` | `null` | no |
|  [force\_destroy](#input\_force\_destroy) | (Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `false` | no |
|  [grant](#input\_grant) | An ACL policy grant. Conflicts with `acl` | `any` | `[]` | no |
|  [ignore\_public\_acls](#input\_ignore\_public\_acls) | Whether Amazon S3 should ignore public ACLs for this bucket. | `bool` | `false` | no |
|  [intelligent\_tiering](#input\_intelligent\_tiering) | Map containing intelligent tiering configuration. | `any` | `{}` | no |
|  [inventory\_configuration](#input\_inventory\_configuration) | Map containing S3 inventory configuration. | `any` | `{}` | no |
|  [inventory\_self\_source\_destination](#input\_inventory\_self\_source\_destination) | Whether or not the inventory source bucket is also the destination bucket. | `bool` | `false` | no |
|  [inventory\_source\_account\_id](#input\_inventory\_source\_account\_id) | The inventory source account id. | `string` | `null` | no |
|  [inventory\_source\_bucket\_arn](#input\_inventory\_source\_bucket\_arn) | The inventory source bucket ARN. | `string` | `null` | no |
|  [lifecycle\_rule](#input\_lifecycle\_rule) | List of maps containing configuration of object lifecycle management. | `any` | `[]` | no |
|  [logging](#input\_logging) | Map containing access bucket logging configuration. | `map(string)` | `{}` | no |
|  [metric\_configuration](#input\_metric\_configuration) | Map containing bucket metric configuration. | `any` | `[]` | no |
|  [object\_lock\_configuration](#input\_object\_lock\_configuration) | Map containing S3 object locking configuration. | `any` | `{}` | no |
|  [object\_lock\_enabled](#input\_object\_lock\_enabled) | Whether S3 bucket should have an Object Lock configuration enabled. | `bool` | `false` | no |
|  [object\_ownership](#input\_object\_ownership) | Object ownership. Valid values: BucketOwnerEnforced, BucketOwnerPreferred or ObjectWriter. 'BucketOwnerEnforced': ACLs are disabled, and the bucket owner automatically owns and has full control over every object in the bucket. 'BucketOwnerPreferred': Objects uploaded to the bucket change ownership to the bucket owner if the objects are uploaded with the bucket-owner-full-control canned ACL. 'ObjectWriter': The uploading account will own the object if the object is uploaded with the bucket-owner-full-control canned ACL. | `string` | `"ObjectWriter"` | no |
|  [owner](#input\_owner) | Bucket owner's display name and ID. Conflicts with `acl` | `map(string)` | `{}` | no |
|  [policy](#input\_policy) | (Optional) A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide. | `string` | `null` | no |
|  [replication\_configuration](#input\_replication\_configuration) | Map containing cross-region replication configuration. | `any` | `{}` | no |
|  [request\_payer](#input\_request\_payer) | (Optional) Specifies who should bear the cost of Amazon S3 data transfer. Can be either BucketOwner or Requester. By default, the owner of the S3 bucket would incur the costs of any data transfer. See Requester Pays Buckets developer guide for more information. | `string` | `null` | no |
|  [restrict\_public\_buckets](#input\_restrict\_public\_buckets) | Whether Amazon S3 should restrict public bucket policies for this bucket. | `bool` | `false` | no |
|  [server\_side\_encryption\_configuration](#input\_server\_side\_encryption\_configuration) | Map containing server-side encryption configuration. | `any` | `{}` | no |
|  [tags](#input\_tags) | (Optional) A mapping of tags to assign to the bucket. | `map(string)` | `{}` | no |
|  [versioning](#input\_versioning) | Map containing versioning configuration. | `map(string)` | `{}` | no |
|  [website](#input\_website) | Map containing static web-site hosting or redirect configuration. | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | The ARN of the bucket. Will be of format arn:aws:s3:::bucketname. |
|  [s3\_bucket\_bucket\_domain\_name](#output\_s3\_bucket\_bucket\_domain\_name) | The bucket domain name. Will be of format bucketname.s3.amazonaws.com. |
|  [s3\_bucket\_bucket\_regional\_domain\_name](#output\_s3\_bucket\_bucket\_regional\_domain\_name) | The bucket region-specific domain name. The bucket domain name including the region name, please refer here for format. Note: The AWS CloudFront allows specifying S3 region-specific endpoint when creating S3 origin, it will prevent redirect issues from CloudFront to S3 Origin URL. |
|  [s3\_bucket\_hosted\_zone\_id](#output\_s3\_bucket\_hosted\_zone\_id) | The Route 53 Hosted Zone ID for this bucket's region. |
|  [s3\_bucket\_id](#output\_s3\_bucket\_id) | The name of the bucket. |
| [s3\_bucket\_region](#output\_s3\_bucket\_region) | The AWS region this bucket resides in. |
|  [s3\_bucket\_website\_domain](#output\_s3\_bucket\_website\_domain) | The domain of the website endpoint, if the bucket is configured with a website. If not, this will be an empty string. This is used to create Route 53 alias records. |
|  [s3\_bucket\_website\_endpoint](#output\_s3\_bucket\_website\_endpoint) | The website endpoint, if the bucket is configured with a website. If not, this will be an empty string. |




