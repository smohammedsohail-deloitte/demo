# Shared Capabilities - Terraform Developer's Guide

In software development, "shared capabilities" refers to the functionalities or resources that are used by multiple software applications or components. These capabilities are typically designed to be reusable and shared across different parts of the software system.

For example, a software library that provides encryption or data compression functionality can be considered a shared capability that can be used by different applications. Similarly, a database management system that is used by multiple applications is also a shared capability.

In Terraform, "shared capabilities" refer to reusable modules or components that can be used across different infrastructure projects. Terraform is an open-source infrastructure as code tool that allows developers to define and manage infrastructure resources such as virtual machines, databases, and networks.

Shared capabilities in Terraform can take various forms, including modules, providers, and backends. These capabilities are designed to simplify the process of creating and managing infrastructure by providing reusable building blocks that can be shared across different projects and teams.

For example, a Terraform module can be used to define a common set of resources, such as a virtual network, load balancer, and set of virtual machines, that can be used across different projects. Similarly, a Terraform provider can be used to integrate with a cloud provider or service, such as AWS or Azure, and provide a consistent set of resources and functionality across different projects.

Using shared capabilities in Terraform offers several benefits, including:

- Reusability: Shared capabilities enable developers to reuse infrastructure code across different projects, saving time and effort in development.

- Consistency: Shared capabilities provide a consistent set of resources and functionality across different projects, which can simplify maintenance and improve the user experience.

- Scalability: Shared capabilities can be designed to scale horizontally and vertically, enabling them to handle increased usage or larger datasets.

- Collaboration: Shared capabilities can be shared across different teams and organizations, enabling better collaboration and knowledge sharing.

Table of Contents
=================

* [What is Terraform?](#What-is-Terraform)
* [Why Terraform?](#Why-Terraform)
* [How Does Terraform Work?](#How-Does-Terraform-Work)
* [Objectives of this Capability](#Objectives-of-this-Capability)
* [Features of this Capability](#Features-of-this-capability)
* [Getting Started](#Getting-Started)
  * [AWS Provider](#AWS-Provider)
    * [AWS RDS Module](#AWS-RDS-Module)
    * [AWS CloudFront Module](#AWS-CloudFront-Module)
    * [AWS API Gateway Module](#AWS-API-Gateway-Module)
    * [AWS S3 Module](#AWS-S3-Module)
  * [GCP Provider](#GCP-Provider)
  * [Azure Provider](#Azure-Provider)
* [Terraform Best Practices](#Terraform-Best-Practices)

## What is Terraform

HashiCorp Terraform is an infrastructure as code tool that lets you define both cloud and on-prem resources in human-readable configuration files that you can version, reuse, and share. You can then use a consistent workflow to provision and manage all of your infrastructure throughout its lifecycle. Terraform can manage low-level components like compute, storage, and networking resources, as well as high-level components like DNS entries and SaaS features.

## Why Terraform

#### Manage any infrastructure
Find providers for many of the platforms and services you already use in the Terraform Registry. You can also write your own. Terraform takes an immutable approach to infrastructure, reducing the complexity of upgrading or modifying your services and infrastructure.

#### Track your infrastructure
Terraform generates a plan and prompts you for your approval before modifying your infrastructure. It also keeps track of your real infrastructure in a state file, which acts as a source of truth for your environment. Terraform uses the state file to determine the changes to make to your infrastructure so that it will match your configuration.

#### Automate changes
Terraform configuration files are declarative, meaning that they describe the end state of your infrastructure. You do not need to write step-by-step instructions to create resources because Terraform handles the underlying logic. Terraform builds a resource graph to determine resource dependencies and creates or modifies non-dependent resources in parallel. This allows Terraform to provision resources efficiently.

#### Standardize configurations
Terraform supports reusable configuration components called modules that define configurable collections of infrastructure, saving time and encouraging best practices. You can use publicly available modules from the Terraform Registry, or write your own.

#### Collaborate
Since your configuration is written in a file, you can commit it to a Version Control System (VCS) and use Terraform Cloud to efficiently manage Terraform workflows across teams. Terraform Cloud runs Terraform in a consistent, reliable environment and provides secure access to shared state and secret data, role-based access controls, a private registry for sharing both modules and providers, and more.

## How Does Terraform Work

Terraform creates and manages resources on cloud platforms and other services through their application programming interfaces (APIs). Providers enable Terraform to work with virtually any platform or service with an accessible API.

![working-of-terraform-image](https://developer.hashicorp.com/_next/image?url=https%3A%2F%2Fcontent.hashicorp.com%2Fapi%2Fassets%3Fproduct%3Dterraform%26version%3Dv1.4.5%26asset%3Dwebsite%252Fimg%252Fdocs%252Fintro-terraform-apis.png%26width%3D2048%26height%3D644&w=2048&q=75)

The core Terraform workflow consists of three stages:

- Write: You define resources, which may be across multiple cloud providers and services. For example, you might create a configuration to deploy an application on virtual machines in a Virtual Private Cloud (VPC) network with security groups and a load balancer.
- Plan: Terraform creates an execution plan describing the infrastructure it will create, update, or destroy based on the existing infrastructure and your configuration.
- Apply: On approval, Terraform performs the proposed operations in the correct order, respecting any resource dependencies. For example, if you update the properties of a VPC and change the number of virtual machines in that VPC, Terraform will recreate the VPC before scaling the virtual machines.

![core-stages-in-terraform-image](https://developer.hashicorp.com/_next/image?url=https%3A%2F%2Fcontent.hashicorp.com%2Fapi%2Fassets%3Fproduct%3Dterraform%26version%3Dv1.4.5%26asset%3Dwebsite%252Fimg%252Fdocs%252Fintro-terraform-workflow.png%26width%3D2038%26height%3D1773&w=2048&q=75)

## Objectives of this capability

- To provide terraform templates so that developers can accelerate their development process
- To provide terraform templates in a single source 
- To provide Terraform best practices
- To provide reusable modules 
- To provide dependency management so that code cannot break


## Features of this capability

- Control over infrastructure using variables
- supports almost every feature associated with services
- Documentation for every module provided
- Examples for almost every modules provided 
- Follows modular architecture
- Follows Extraction and Abstraction

## Getting Started

### Prerequisites

- Terraform CLI should be installed in terminal 
- Respective cloud provider should be setup in terminal
- Cloud provider should enable permissions so that Terraform invokes respective API's 

### AWS Provider

Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS. You must configure the provider with the proper credentials before you can use it.

```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
```

#### AWS RDS Module

This modules creates AWS RDS and associated resources based on input provided by the user. To use this module, follow the steps:

Step-1: Clone the repo

```
git clone https://github.com/Deloitte/digiprint_fabric_solutions/tree/develop
```

Step-2: Go to RDS root directory

```
cd shared_capabilities/templates/rds/root
```

Step-3: Provision infrastructure using terraform commands

```
terraform init    //initializes terraform modules 
terraform validate   // validates terraform configurations
terraform plan    // plans the infrastructure but does not provision
terraform apply    // provisions infrastructure
```

The resources and associated services will be provisioned based on the user input, since this module provides wide latitude of control over infrastructure. For more details and usage, refer the [RDS Documentation](#https://github.com/Deloitte/digiprint_fabric_solutions/tree/develop/shared_capabilities/templates/rds)


#### AWS CloudFront Module

This modules creates AWS CloudFront and associated resources based on input provided by the user. To use this module, follow the steps:

Step-1: Clone the repo

```
git clone https://github.com/Deloitte/digiprint_fabric_solutions/tree/develop
```

Step-2: Go to CloudFront root directory

```
cd shared_capabilities/templates/cloud_front/root
```

Step-3: Provision infrastructure using terraform commands

```
terraform init    //initializes terraform modules 
terraform validate   // validates terraform configurations
terraform plan    // plans the infrastructure but does not provision
terraform apply    // provisions infrastructure
```

The resources and associated services will be provisioned based on the user input, since this module provides wide latitude of control over infrastructure. For more details and usage, refer the [CloudFront Documentation](#https://github.com/Deloitte/digiprint_fabric_solutions/tree/develop/shared_capabilities/templates/cloud_front)

#### AWS API Gateway Module

This modules creates AWS API Gateway and associated resources based on input provided by the user. To use this module, follow the steps:

Step-1: Clone the repo

```
git clone https://github.com/Deloitte/digiprint_fabric_solutions/tree/develop
```

Step-2: Go to API Gateway root directory

```
cd shared_capabilities/templates/api-gateway/root/basic_api
```

Step-3: Provision infrastructure using terraform commands

```
terraform init    //initializes terraform modules 
terraform validate   // validates terraform configurations
terraform plan    // plans the infrastructure but does not provision
terraform apply    // provisions infrastructure
```

The resources and associated services will be provisioned based on the user input, since this module provides wide latitude of control over infrastructure. For more details and usage, refer the [API Gateway Documentation](#https://github.com/Deloitte/digiprint_fabric_solutions/tree/develop/shared_capabilities/templates/api-gateway)

#### AWS S3 Module

This modules creates AWS S3 and associated resources based on input provided by the user. To use this module, follow the steps:

Step-1: Clone the repo

```
git clone https://github.com/Deloitte/digiprint_fabric_solutions/tree/develop
```

Step-2: Go to S3 root directory

```
cd shared_capabilities/templates/s3/root
```

Step-3: Provision infrastructure using terraform commands

```
terraform init    //initializes terraform modules 
terraform validate   // validates terraform configurations
terraform plan    // plans the infrastructure but does not provision
terraform apply    // provisions infrastructure
```

The resources and associated services will be provisioned based on the user input, since this module provides wide latitude of control over infrastructure. For more details and usage, refer the [S3 Documentation](#https://github.com/Deloitte/digiprint_fabric_solutions/tree/develop/shared_capabilities/templates/s3)


## Terraform Best Practices

- Use version control: Store your Terraform code in a version control system (VCS) such as Git to track changes and collaborate with your team.

- Use modules: Organize your infrastructure code into reusable modules to simplify management and promote code reuse.

- Use variables: Use variables to parameterize your code and make it easier to customize and reuse.

- Use outputs: Use outputs to expose useful information about the resources you’ve created in your code.

- Use remote state: Store your Terraform state file in a remote backend (such as S3) to ensure consistency and enable collaboration.

- Use state locking: Enable state locking to prevent simultaneous updates and ensure consistency of your infrastructure.

- Use a service account: Create a dedicated service account with the appropriate permissions to run your Terraform code.

- Use a naming convention: Establish a consistent naming convention for your resources to improve readability and organization.

- Use tags: Use tags to label your resources with useful metadata, such as owner or environment.

- Use separate environments: Create separate environments (e.g. dev, staging, production) to isolate changes and prevent accidental updates to production.

- Use a pre-commit hook: Use a pre-commit hook to validate your Terraform code and catch errors before you commit your changes.

- Use a continuous integration (CI) pipeline: Use a CI pipeline to test and deploy your Terraform code automatically.

- Use conditional logic: Use conditional logic to enable or disable resources based on conditions, such as environment or region.

- Use Terraform modules from the community: Use modules from the Terraform registry or other community sources to speed up development and improve quality.

- Use Terraform best practices: Follow best practices recommended by the Terraform community to ensure your code is scalable, maintainable, and secure.

- Use a state backend with versioning: Use a state backend that supports versioning to enable easy rollback and recovery of your infrastructure.

- Use Terraform providers for consistent resource creation: Use Terraform providers to create resources in a consistent way across multiple cloud platforms.

- Use Terraform workspaces: Use Terraform workspaces to manage multiple instances of the same infrastructure code in a single configuration.

- Use Terraform graph to visualize infrastructure: Use the Terraform graph command to generate a visual representation of your infrastructure.

- Use Terraform testing tools: Use Terraform testing tools such as Terratest to automate infrastructure testing and ensure consistent, high-quality code.

- Use Terraform linting tools: Use Terraform linting tools like tflint to catch issues in your code before running it.

- Use Terraform plan to preview changes: Use Terraform plan to preview changes to your infrastructure before applying them to prevent unexpected consequences.

- Use Terraform apply with care: Use Terraform apply with care and always review the changes before applying them to ensure that the changes are intended.

- Use Terraform destroy to clean up resources: Use Terraform destroy to clean up resources when they are no longer needed to prevent unnecessary costs.

- Use Terraform backend encryption: Use encryption to protect sensitive data in the state file.

- Use Terraform timeouts: Use timeouts to prevent Terraform from hanging indefinitely.

- Use Terraform providers with caution: Use Terraform providers from trusted sources and review the code before using them.

- Use Terraform Workspaces securely: Ensure that your workspaces are properly secured to prevent unauthorized access.

- Use Terraform with Configuration Management tools: Integrate Terraform with configuration management tools like Ansible or Chef to enable comprehensive infrastructure automation.

- Use immutable infrastructure: Create immutable infrastructure using Terraform to ensure consistency and prevent configuration drift.

- Use Terraform data sources: Use Terraform data sources to query existing resources and use their properties in your code.

- Use Terraform State Pull Requests: Use pull requests to manage changes to the Terraform state file and ensure changes are reviewed before they are applied.

- Use Terraform Cloud for collaboration: Use Terraform Cloud for collaboration with your team and to store your state file securely.

- Use Infrastructure as Code testing: Test your Terraform code regularly using Infrastructure as Code testing tools like Terratest.

- Use Terraform backup and restore: Implement a backup and restore plan for your state file to ensure that you can recover from data loss.

