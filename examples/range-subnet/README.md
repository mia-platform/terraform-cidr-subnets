# Range subnet example 

This sample will calculate some /17 subnetwork in a given range: "10.0.0.0/16" -> "10.1.0.0/16"

```sh
$terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
 <= read (data resources)

Terraform will perform the following actions:

  # module.subnets.data.external.subnets will be read during apply
  # (config refers to values not yet known)
 <= data "external" "subnets"  {
      + id      = (known after apply)
      + program = [
          + "../../scripts/calc_subnetworks.py",
        ]
      + query   = {
          + "base_cidr_block"  = "10.0.0.0/16"
          + "final_cidr_block" = "10.1.0.0/16"
          + "networks"         = "17,17,17"
        }
      + result  = (known after apply)
    }

  # module.subnets.null_resource.precondition will be created
  + resource "null_resource" "precondition" {
      + id = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

```sh
$terraform apply
module.subnets.null_resource.precondition: Creating...
module.subnets.null_resource.precondition: Provisioning with 'local-exec'...
module.subnets.null_resource.precondition (local-exec): Executing: ["/bin/sh" "-c" "../../scripts/preconditions.sh"]
module.subnets.null_resource.precondition: Creation complete after 0s [id=3012884081376565976]
module.subnets.data.external.subnets: Refreshing state...

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

network_cidr_blocks = {
  "subnet1" = "10.0.0.0/17"
  "subnet2" = "10.0.128.0/17"
  "subnet3" = "10.1.0.0/17"
}
networks = [
  {
    "cidr_block" = "10.0.0.0/17"
    "name" = "subnet1"
    "new_bits" = 17
  },
  {
    "cidr_block" = "10.0.128.0/17"
    "name" = "subnet2"
    "new_bits" = 17
  },
  {
    "cidr_block" = "10.1.0.0/17"
    "name" = "subnet3"
    "new_bits" = 17
  },
]
```
