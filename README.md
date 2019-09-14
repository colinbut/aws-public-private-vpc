# AWS Public-Private - VPC

This repo contains an example of a Cloudformation template to build a VPC with 2x Public Subnets & 2x Private Subnets

An Internet Gateway is launched and is attached to the VPC so that outbound & inbound internet traffic permits

Resources launched inside the private Subnets (e.g. EC2 instances) would not be able to talk to the internet by default but can do so by way of contacting a NAT Gateway which is resided in the corresponding Public Subnet.

## Cloudformation

via the AWS CLI:

```bash
aws cloudformation create-stack --stack-name [your-stack-name] --template-body public-private-vpc.yml
```

where `[your-stack-name]` is your chosen name for your Cloudformation stack

## Terraform

```bash
terraform init
```

```bash
terraform plan
```

```bash
terraform apply
```