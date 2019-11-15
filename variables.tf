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

variable "base_cidr_block" {
  type        = string
  description = "A network address prefix in CIDR notation that all of the requested subnetwork prefixes will be allocated within."
}

variable "final_cidr_block" {
  type        = string
  description = "The last network address prefix in CIDR notation that can be used to allocate the subnets"
  default     = ""
}

variable "networks" {
  type = list(object({
    name     = string
    new_bits = number
  }))
  description = "A list of objects describing requested subnetwork prefixes. new_bits is the number of additional network prefix bits to add, in addition to the existing prefix on base_cidr_block."
}
