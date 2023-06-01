#Copyright (c) 2023 Oracle Corporation and/or its affiliates.
#Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

module "svc" {
  source                = "../../modules/serviceconnector"
  service_connector_def = local.service_connector_def
  policy_compartment_id = local.policy_compartment_id
  dynamic_group         = local.dynamic_group

  tenancy_ocid = local.tenancy_ocid
  providers = {
    oci.home = oci.home
  }

}

locals {
  tenancy_ocid = "<tenancy_ocid>"
  dynamic_group = {
    dg1 = { compartment_id = "<service connector compartment id>" }
  }
  policy_compartment_id = "<policy compartment>" #if not set policy will be created default in root compartment
  service_connector_def = { sch2 = {
    compartment_id = "<service connector compartment id>"
    #If policy needs to be created set the below two values. By default its set to false to not create policy
    #Set create_policy to true 
    #set dynamic group name with respect to service connector compartment
    create_policy      = true
    dynamic_group_name = "<dynamicgroupname>"

    sch_source   = "streaming"
    sch_target   = "objectstorage"
    display_name = "sch2"

    stream_id = "existing stream ocid"
    target = {
      bucket = "<bucket name>"
    }
    }
  }
}
