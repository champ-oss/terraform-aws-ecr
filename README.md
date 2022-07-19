# terraform-aws-ecr #

Summary: terraform module to manage Amazon Elastic Container Registry

![ci](https://github.com/conventional-changelog/standard-version/workflows/ci/badge.svg)
[![version](https://img.shields.io/badge/version-1.x-yellow.svg)](https://semver.org)

## Table of Contents
* [General Info](#general-information)
* [Technologies Used](#technologies-used)
* [Features](#Features)
* [Documentation](#Documentation)
* [Usage](#usage)
* [Project Status](#project-status)

## General Information
- automate setup of aws ecr

## Technologies Used
- terraform
- github actions

## Features

* create registory
* manage ecr policy for registry

## Documentation

terraform aws ecr resource documentation  [_here_](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository)

## Usage

* look at examples/complete/main.tf for usage 

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.74.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.74.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.ecr_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_iam_policy_document.resource_readonly_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_encryption_type"></a> [encryption\_type](#input\_encryption\_type) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository#argument-reference | `string` | `"AES256"` | no |
| <a name="input_force_delete"></a> [force\_delete](#input\_force\_delete) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository#force_delete | `bool` | `false` | no |
| <a name="input_git"></a> [git](#input\_git) | Name of the Git repo | `string` | `"terraform-aws-ecr"` | no |
| <a name="input_image_tag_mutability"></a> [image\_tag\_mutability](#input\_image\_tag\_mutability) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository#argument-reference | `string` | `"MUTABLE"` | no |
| <a name="input_name"></a> [name](#input\_name) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository#argument-reference | `string` | n/a | yes |
| <a name="input_scan_on_push"></a> [scan\_on\_push](#input\_scan\_on\_push) | https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository#argument-reference | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to assign to resources | `map(string)` | `{}` | no |
| <a name="input_trusted_accounts"></a> [trusted\_accounts](#input\_trusted\_accounts) | trusted accounts that are allowed to pull images | `list(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_registry_id"></a> [registry\_id](#output\_registry\_id) | repository id |
| <a name="output_repository_url"></a> [repository\_url](#output\_repository\_url) | URL of first repository created |
<!-- END_TF_DOCS -->

## Project Status
Project is: _complete_ 
