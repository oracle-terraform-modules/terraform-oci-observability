#Copyright (c) 2023 Oracle Corporation and/or its affiliates.
#Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

resource "oci_sch_service_connector" "this" {
  for_each       = var.service_connector_def
  compartment_id = each.value.compartment_id
  display_name   = each.value.display_name
  state          = each.value.state
  source {
    kind = each.value.sch_source
    dynamic "cursor" {
      for_each = each.value.sch_source == "streaming" ? [1] : []
      content {
        #https://docs.oracle.com/en-us/iaas/Content/Streaming/Tasks/using_a_single_consumer.htm#usingcursors
        kind = each.value.stream_cursor
      }
    }

    dynamic "log_sources" {
      for_each = each.value.sch_source == "logging" ? each.value.log_source : []
      content {
        compartment_id = coalesce(log_sources.value.compartment_id, each.value.compartment_id)
        log_group_id   = log_sources.value.log_group_id
        log_id         = log_sources.value.log_id

      }
    }
    dynamic "monitoring_sources" {
      for_each = each.value.sch_source == "monitoring" ? each.value.monitoring_source : []
      content {

        compartment_id = coalesce(monitoring_sources.value.compartment_id, each.value.compartment_id)
        namespace_details {
          kind = "selected"
          dynamic "namespaces" {
            for_each = monitoring_sources.value.metric_namespace
            content {
              metrics {
                kind = "all"
              }
              namespace = namespaces.value
            }
          }
        }
      }
    }
    stream_id = each.value.sch_source == "streaming" ? each.value.stream_id : null
  }
  target {
    kind                       = each.value.sch_target
    log_group_id               = each.value.sch_target == "loggingAnalytics" ? each.value.target.log_group_id : null
    log_source_identifier      = (each.value.sch_source == "streaming" && each.value.sch_target == "loggingAnalytics") ? each.value.target.la_log_source : null
    compartment_id             = each.value.sch_target == "monitoring" ? coalesce(each.value.target.compartment_id, each.value.compartment_id) : null
    stream_id                  = each.value.sch_target == "streaming" ? each.value.target.stream_id : null
    bucket                     = each.value.sch_target == "objectstorage" ? each.value.target.bucket : null
    object_name_prefix         = each.value.sch_target == "objectstorage" ? each.value.target.object_name_prefix : null
    batch_rollover_size_in_mbs = each.value.sch_target == "objectstorage" ? each.value.target.batch_rollover_size_in_mbs : null
    batch_rollover_time_in_ms  = each.value.sch_target == "objectstorage" ? each.value.target.batch_rollover_time_in_ms : null
    topic_id                   = each.value.sch_target == "notifications" ? each.value.target.topic_id : null
    enable_formatted_messaging = each.value.sch_target == "notifications" ? each.value.target.enable_formatted_messaging : null
    function_id                = each.value.sch_target == "functions" ? each.value.target.function_id : null

  }
  defined_tags  = each.value.defined_tags
  description   = "Service connector for ${each.value.sch_source} to ${each.value.sch_target}"
  freeform_tags = each.value.freeform_tags
  dynamic "tasks" {
    for_each = each.value.tasks != null ? [1] : []
    content {
      kind      = "logRule"
      condition = each.value.tasks.log_condition
    }
  }
  dynamic "tasks" {
    for_each = each.value.tasks != null ? [1] : []
    content {

      kind = "function"

      batch_size_in_kbs = each.value.tasks.batch_size_in_kbs
      batch_time_in_sec = each.value.tasks.batch_time_in_sec
      function_id       = each.value.tasks.function_id
    }
  }

}
