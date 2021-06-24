# AWS - Base Infrastructure Module
Terraform module that creates base infrastructure in [AWS](https://aws.amazon.com/) for testing [Alkira Network Cloud](https://www.alkira.com/). This module is ideal for deploying a flexible network infrastructure with AWS's low-cost, general-purpose [t2.micro](https://aws.amazon.com/ec2/instance-types/t2/) instances in each subnet for testing. VPCs are provisioned without a [TGW](https://aws.amazon.com/transit-gateway/) or [IGW](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html) and instances without _public IP addresses_. This presents a simple and completely private environment, ideal for testing integration to Alkira's _Cloud Services Exchange (CSX)_.

## What It Does
- Create a [Virtual Private Cloud (VPC)](https://aws.amazon.com/vpc/)
- Build one or more [subnets](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html) (provided as a list)
- Build an [EC2 instance](https://aws.amazon.com/ec2/) running [Ubuntu](https://ubuntu.com/) per subnet
- Create an [AWS key pair](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) with the provided public key for access to instances
- Build and apply a [Security Group](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html) setup with **_any-to-any_** for both **_ingress_** and **_egress_** traffic
> The Security Group is set to _allow-all_ for inbound and outbound traffic because Alkira's policy manages this functionality across all clouds; This would normally be a bad practice and not recommended otherwise

## Usage
```hcl
provider "aws" {
  region     = "us-east-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

module "infra" {
  source  = "wcollins/infra/aws"
  
  vpc_name         = "vpc-aws-east-2"
  vpc_prefix       = "10.1.0.0/16"
  subnet_names     = ["subnet-01", "subnet-02", "subnet-03"]
  subnet_prefixes  = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  instance_names   = ["vm-east-01", "vm-east-02", "vm-east-03"]
  admin_ssh_key    = var.admin_ssh_key
}
```