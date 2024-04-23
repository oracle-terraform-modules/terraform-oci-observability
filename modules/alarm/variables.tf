#Copyright (c) 2023 Oracle Corporation and/or its affiliates.
#Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

variable "compartment_ocid" {
  description = "Compartment OCID"
  type        = string
}


variable "alarm_def" {
  description = "OCI Alarm definition"
  type = map(object({
    destination                  = string
    display_name                 = optional(string)
    severity                     = optional(string)
    query                        = string
    is_enabled                   = optional(bool)
    rule_name                    = optional(string)
    namespace                    = string
    metric_compartment_id        = optional(string)
    repeat_notification_duration = optional(string)
    trigger                      = optional(string)
    suppression_from_time        = optional(string)
    suppression_till_time        = optional(string)
    message_format               = optional(string)
    body                         = optional(string)
    freeform_tags                = optional(map(string))
    defined_tags                 = optional(map(string))
    resolution                   = optional(string)
    resource_group               = optional(string)
    split_notification           = optional(bool)
    has_overrides                = optional(bool)
    overrides                    = optional(map(object({
      body      = optional(string)
      trigger   = optional(string)
      query     = optional(string)
      rule_name = optional(string)
      severity  = optional(string)
    })))
  }))
}

variable "notification" {
  description = "Notification Topic and Subscription"
  type = map(object({
    description   = optional(string)
    create_topic  = optional(bool)
    defined_tags  = optional(map(string))
    freeform_tags = optional(map(string))
    subscription = optional(map(object({
      endpoint = string
      protocol = string
    })))
  }))
}

variable "alarm_name_prefix" {
  default     = "none"
  description = "Prefix to be added to alarm resources"
  type        = string
}

variable "topic_name_prefix" {
  default     = "none"
  description = "Prefix to be added to topic resources"
  type        = string
}