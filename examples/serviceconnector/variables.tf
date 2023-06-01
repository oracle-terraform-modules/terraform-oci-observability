#Copyright (c) 2023 Oracle Corporation and/or its affiliates.
#Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

variable "tenancy_ocid" {
  description = "Tenancy OCID"
  type        = string
}

variable "policy_compartment_id" {
  type        = string
  description = "Compartment where policy will be created"

}

variable "dynamic_group" {
  type        = map(any)
  description = "Dynamic group definition for service connector"
  default     = {}

}

variable "service_connector_def" {
  type = map(object({
    defined_tags       = optional(map(string))
    freeform_tags      = optional(map(string))
    display_name       = string
    description        = optional(string)
    state              = optional(string, "ACTIVE")
    sch_source         = string
    sch_target         = string
    compartment_id     = string
    create_policy      = optional(bool, false)
    dynamic_group_name = optional(string)

    #For Streaming source
    stream_id     = optional(string)
    stream_cursor = optional(string, "LATEST")
    #For logging source
    log_source = optional(list(object({
      compartment_id = optional(string)
      log_group_id   = optional(string, "_Audit")
      log_id         = optional(string)
    })))
    #For monitoring source
    monitoring_source = optional(list(object({
      compartment_id   = optional(string)
      metric_namespace = list(string)
    })))

    target = object({
      #For Objectstorage target
      bucket                     = optional(string)
      batch_rollover_size_in_mbs = optional(number, 100)
      batch_rollover_time_in_ms  = optional(number, 420000)
      object_name_prefix         = optional(string)
      #For Streaming target
      stream_id = optional(string)
      #For Notification target
      topic_id = optional(string)
      #For Function target
      function_id = optional(string)
      #For LoggingAnalytics Target
      log_group_id   = optional(string)
      log_source     = optional(string)
      compartment_id = optional(string)
    })
    tasks = optional(object({
      log_condition     = optional(string)
      function_id       = optional(string)
      batch_size_in_kbs = optional(string, 5120)
      batch_time_in_sec = optional(string, 600)

    }))
  }))
  validation {
    condition = alltrue([
    for i in var.service_connector_def : contains(["logging", "monitoring", "streaming"], i.sch_source)])
    error_message = "Allowed value for sch_source is logging,monitoring and streaming."
  }
  validation {
    condition = alltrue([
    for i in var.service_connector_def : contains(["loggingAnalytics", "objectstorage", "streaming", "notifications", "functions"], i.sch_target)])
    error_message = "Allowed value for sch_target is functions,loggingAnalytics,notifications,objectstorage and streaming."
  }

}
