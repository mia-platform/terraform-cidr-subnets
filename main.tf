/*
  Copyright 2019 Mia srl

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/

terraform {
  required_version = ">= 0.12"
  required_providers {
    external = "~> 1"
  }
}

locals {
  addresses_by_idx  = split(",", data.external.subnets.result["subnetworks"])
  addresses_by_name = { for idx, network in var.networks :
    network.name => local.addresses_by_idx[idx] if network.name != null
  }
  network_objs = [for idx, network in var.networks : {
    name       = network.name
    new_bits   = network.new_bits
    cidr_block = network.name != null ? local.addresses_by_idx[idx] : tostring(null)
  }]
}

data "external" "subnets" {
  program = ["${path.module}/scripts/calc_subnetworks.py"]

  query = {
    base_cidr_block  = var.base_cidr_block
    final_cidr_block = var.final_cidr_block
    networks         = join(",", var.networks[*].new_bits)
  }
}
