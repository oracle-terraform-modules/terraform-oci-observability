#Copyright (c) 2023 Oracle Corporation and/or its affiliates.
#Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

locals {
  policy_compartment_id = var.policy_compartment_id == null ? var.tenancy_ocid : var.policy_compartment_id

  target_policies = {
    for k, v in var.service_connector_def : k => (v.create_policy && v.sch_target == "loggingAnalytics") ? "Allow dynamic-group ${v.dynamic_group_name} to use loganalytics-log-group in compartment id ${coalesce(v.target.compartment_id, v.compartment_id)} where target.loganalytics-log-group.id='${v.target.log_group_id}'" :
    (v.create_policy && v.sch_target == "notifications") ? "Allow dynamic-group ${v.dynamic_group_name} to use ons-topics in compartment id ${coalesce(v.target.compartment_id, v.compartment_id)}" :
    (v.create_policy && v.sch_target == "functions") ? "Allow dynamic-group ${v.dynamic_group_name} to use fn-invocation in compartment id ${coalesce(v.target.compartment_id, v.compartment_id)}" :
    (v.create_policy && v.sch_target == "objectstorage") ? "Allow dynamic-group ${v.dynamic_group_name} to manage objects in compartment id ${coalesce(v.target.compartment_id, v.compartment_id)} where target.bucket.name='${v.target.bucket}'" :
    (v.create_policy && v.sch_target == "streaming") ? "Allow dynamic-group ${v.dynamic_group_name} to use stream-push in compartment id ${coalesce(v.target.compartment_id, v.compartment_id)} where target.stream.id='${v.target.stream_id}'" : ""
  }
  source_policies = {
    for k, v in var.service_connector_def : k => (v.create_policy && v.sch_source == "streaming") ? "Allow dynamic-group ${v.dynamic_group_name} to {STREAM_READ, STREAM_CONSUME} in compartment id ${coalesce(v.target.compartment_id, v.compartment_id)} where target.stream.id='${v.stream_id}'" :
    (v.create_policy && v.sch_source == "monitoring") ? "Allow dynamic-group ${v.dynamic_group_name} to read metrics in compartment id ${coalesce(v.target.compartment_id, v.compartment_id)}" : ""
  }

  allpolicies = { for key in distinct(concat(keys(local.target_policies), keys(local.source_policies))) :
    key => compact(flatten([lookup(local.target_policies, key, []),
      lookup(local.source_policies, key, [])
    ]))
  }

  policies = { for k, v in local.allpolicies : k => v if length(v) > 0 }

}

#Create dynamic group
resource "oci_identity_dynamic_group" "serviceconnector_dynamic_group" {
  provider = oci.home

  for_each       = var.dynamic_group
  compartment_id = var.tenancy_ocid
  description    = "Dynamic group for service connector"
  matching_rule  = "All {resource.type = 'serviceconnector', resource.compartment.id = '${each.value.compartment_id}'}"
  name           = each.key

}

#Create policy for service connector
resource "oci_identity_policy" "serviceconnector_policy" {
  provider = oci.home

  for_each       = local.policies
  compartment_id = local.policy_compartment_id
  description    = format("%s%s", "Policies for service connector ", each.key)
  name           = format("%s_%s", "serviceconnector", each.key)
  statements     = each.value

}
