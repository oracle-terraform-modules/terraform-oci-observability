#Copyright (c) 2023 Oracle Corporation and/or its affiliates.
#Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

resource "oci_ons_notification_topic" "this" {
  for_each       = { for k, v in var.notification : k => v if v.create_topic == true }
  compartment_id = var.compartment_ocid
  name           = var.topic_name_prefix == "none" ? each.key : format("%s-%s", var.topic_name_prefix, each.key)
  
  description   = each.value.description == null ? format("%s%s", each.key, " topic created by Terraform") : each.value.description
  defined_tags  = each.value.defined_tags
  freeform_tags = each.value.freeform_tags
  lifecycle {
    ignore_changes = [
      defined_tags["Oracle-Tags.CreatedBy"],
      defined_tags["Oracle-Tags.CreatedOn"]
    ]
  }
}

data "oci_ons_notification_topics" "existing_topic" {
  for_each = { for k, v in var.notification : k => v if v.create_topic == false }

  compartment_id = var.compartment_ocid

  name  = each.key
  state = "ACTIVE"
}

resource "oci_ons_subscription" "this" {
  for_each       = { for v in local.notification_subscription : v.subscription => v }
  compartment_id = var.compartment_ocid
  endpoint       = each.value.endpoint
  protocol       = each.value.protocol
  topic_id       = each.value.topic_id


  defined_tags  = each.value.defined_tags
  freeform_tags = each.value.freeform_tags
  lifecycle {
    ignore_changes = [
      defined_tags["Oracle-Tags.CreatedBy"],
      defined_tags["Oracle-Tags.CreatedOn"]
    ]
  }
}

resource "oci_monitoring_alarm" "this" {
  for_each                                      = length(var.alarm_def) > 0 ? var.alarm_def : {}
  compartment_id                                = var.compartment_ocid
  destinations                                  = [try(oci_ons_notification_topic.this[each.value.destination].id, data.oci_ons_notification_topics.existing_topic[each.value.destination].notification_topics[0].topic_id, each.value.destination)]
  display_name                                  = var.alarm_name_prefix == "none" ? each.key : format("%s-%s", var.alarm_name_prefix, each.key)
  is_enabled                                    = each.value.is_enabled
  is_notifications_per_metric_dimension_enabled = each.value.split_notification
  metric_compartment_id                         = each.value.metric_compartment_id == null ? var.compartment_ocid : each.value.metric_compartment_id
  namespace                                     = each.value.namespace
  query                                         = each.value.query
  severity                                      = each.value.severity
  message_format                                = each.value.message_format
  repeat_notification_duration                  = each.value.repeat_notification_duration
  resource_group                                = each.value.resource_group
  resolution                                    = each.value.resolution
  rule_name                                     = each.value.rule_name
  pending_duration                              = each.value.trigger
  body                                          = each.value.body
  defined_tags                                  = each.value.defined_tags
  freeform_tags                                 = each.value.freeform_tags
  dynamic "overrides" {
    for_each = { for k ,v  in coalesce(each.value.overrides, {}) : k => v if each.value.has_overrides }

    content {
      body = overrides.value.body
      pending_duration = overrides.value.trigger
      query = overrides.value.query
      rule_name = overrides.value.rule_name
      severity = overrides.value.severity
    }
  }
  dynamic "suppression" {
    for_each = (each.value.suppression_from_time != null && each.value.suppression_till_time != null) ? [1] : []
    content {
      time_suppress_from  = each.value.suppression_from_time
      time_suppress_until = each.value.suppression_till_time
    }
  }
  lifecycle {
    ignore_changes = [
      defined_tags["Oracle-Tags.CreatedBy"],
      defined_tags["Oracle-Tags.CreatedOn"]
    ]
  }
}


locals {
  notification_subscription = flatten([
    for topic_key, topic_value in var.notification : [
      for subscription_key, subscription_value in topic_value.subscription : {
        topic_id      = topic_value.create_topic ? oci_ons_notification_topic.this[topic_key].id : data.oci_ons_notification_topics.existing_topic[topic_key].notification_topics[0].topic_id
        protocol      = subscription_value.protocol
        endpoint      = subscription_value.endpoint
        subscription  = format("%s-%s", topic_key, subscription_key)
        defined_tags  = topic_value.defined_tags
        freeform_tags = topic_value.freeform_tags
      }
    ] if topic_value.subscription != null
  ])
}
