resource "random_id" "this" {
  byte_length = 1

  keepers = {
    vpc_id = var.vpc_id
  }
}

resource "aws_security_group" "this" {
  for_each = { for rule in var.sg_rules : rule.name => rule }

  name        = "${each.key}-${random_id.this.hex}"
  description = "Security group for ${each.key}"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = each.value["ingress"]
    content {
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  dynamic "egress" {
    for_each = each.value["egress"]
    content {
      from_port   = egress.value["from_port"]
      to_port     = egress.value["to_port"]
      protocol    = egress.value["protocol"]
      cidr_blocks = egress.value["cidr_blocks"]
    }
  }

  tags = {
    Name = "${each.key}-${random_id.this.hex}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
