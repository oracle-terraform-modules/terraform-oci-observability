#Copyright (c) 2023 Oracle Corporation and/or its affiliates.
#Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

resource "oci_ons_notification_topic" "this" {
  for_each       = { for k, v in var.notification : k => v if v.create_topic == true }
  compartment_id = var.compartment_ocid
  name           = var.label_prefix == "none" ? each.key : format("%s_%s", var.label_prefix, each.key)

  description   = each.value.description == null ? format("%s%s", each.key, " topic created by Terraform") : each.value.description
  defined_tags  = each.value.defined_tags
  freeform_tags = each.value.freeform_tags

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
}

resource "oci_monitoring_alarm" "this" {
  for_each                     = length(var.alarm_def) > 0 ? var.alarm_def : {}
  compartment_id               = var.compartment_ocid
  destinations                 = [try(oci_ons_notification_topic.this_topic[each.value.destination].id, data.oci_ons_notification_topics.existing_topic[each.value.destination].notification_topics[0].topic_id, each.value.destination)]
  display_name                 = var.label_prefix == "none" ? each.key : format("%s_%s", var.label_prefix, each.key)
  is_enabled                   = each.value.is_enabled
  metric_compartment_id        = each.value.metric_compartment_id == null ? var.compartment_ocid : each.value.metric_compartment
  namespace                    = each.value.namespace
  query                        = each.value.query
  severity                     = each.value.severity
  message_format               = each.value.message_format
  repeat_notification_duration = each.value.repeat_notification_duration
  pending_duration             = each.value.trigger
  body                         = each.value.body
  defined_tags                 = each.value.defined_tags
  freeform_tags                = each.value.freeform_tags
  dynamic "suppression" {
    for_each = (each.value.suppression_from_time != null && each.value.suppression_till_time != null) ? [1] : []
    content {
      time_suppress_from  = each.value.suppression_from_time
      time_suppress_until = each.value.suppression_till_time
    }
  }

}


locals {
  notification_subscription = flatten([
    for topic_key, topic_value in var.notification : [
      for subscription_key, subscription_value in topic_value.subscription : {
        topic_id      = topic_value.create_topic ? oci_ons_notification_topic.this_topic[topic_key].id : data.oci_ons_notification_topics.existing_topic[topic_key].notification_topics[0].topic_id
        protocol      = subscription_value.protocol
        endpoint      = subscription_value.endpoint
        subscription  = format("%s_%s", topic_key, subscription_key)
        defined_tags  = topic_value.defined_tags
        freeform_tags = topic_value.freeform_tags
      }
    ]
  ])
}
