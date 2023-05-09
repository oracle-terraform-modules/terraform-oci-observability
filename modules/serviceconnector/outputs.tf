#Copyright (c) 2023 Oracle Corporation and/or its affiliates.
#Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

output "service_connectors" {
  description = "Service Connector"
  value       = { for k in oci_sch_service_connector.this : k.display_name => k.id }
}
