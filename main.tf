terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = ">= 2.1.0"
    }
  }
}

resource "local_file" "ip_address_list" {
  for_each = local.consul_services
  content  = join("\n", [for s in each.value : s.address])
  filename = "service_files/${each.key}.txt"
}

locals {
  consul_services = {
    for id, s in var.services : s.name => s...
  }
}
