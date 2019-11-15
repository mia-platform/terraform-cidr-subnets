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

output "network_cidr_blocks" {
  value       = tomap(local.addresses_by_name)
  description = "A map from network names to allocated address prefixes in CIDR notation."
}

output "networks" {
  value       = tolist(local.network_objs)
  description = "A list of objects corresponding to each of the objects in the input variable ‘networks’, each extended with a new attribute ‘cidr_block’ giving the network’s allocated address prefix."
}

output "base_cidr_block" {
  value       = var.base_cidr_block
  description = "Echoes back the base_cidr_block input variable value, for convenience if passing the result of this module elsewhere as an object."
}
