# AWS Security Groups

This module provides AWS Security groups resources:
- AWS Security Groups

## Input variables
- `vpc_id` - The identifier of the VPC in which to create the security group
- `sg_rules` - List of security groups rules. Example:
```hcl-terraform
  sg_rules = [{
    name = "terraform-aws-sg"
    ingress = [{
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }]
    egress = [{
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }]
  }]
```

## Output variables
- `security_groups`
    - `%SG_RULE_NAME%`
        - `id` - The ID of the security group
        - `arn` - The ARN of the security group
        - `vpc_id` - The VPC ID
        - `owner_id` - The owner ID
        - `name` - The name of the security group
        - `description` - The description of the security group
        - `ingress` - The ingress rules
        - `egress` - The egress rules
