#Copyright (c) 2023 Oracle Corporation and/or its affiliates.
#Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

output "topic_ids" {
  description = "Notification Topic OCID"
  value       = { for k in oci_ons_notification_topic.this_topic : k.name => k.topic_id }
}
