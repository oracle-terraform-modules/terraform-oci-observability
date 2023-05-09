<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | >= 4.67.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | >= 4.67.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_identity_dynamic_group.serviceconnector_dynamic_group](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_dynamic_group) | resource |
| [oci_identity_policy.serviceconnector_policy](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_policy) | resource |
| [oci_sch_service_connector.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/sch_service_connector) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_ocid"></a> [compartment\_ocid](#input\_compartment\_ocid) | Compartment OCID | `string` | n/a | yes |
| <a name="input_create_dg"></a> [create\_dg](#input\_create\_dg) | Whether to create dynamic group or not | `bool` | n/a | yes |
| <a name="input_dynamic_group_name"></a> [dynamic\_group\_name](#input\_dynamic\_group\_name) | Dynamic group display name | `string` | n/a | yes |
| <a name="input_policy_compartment_id"></a> [policy\_compartment\_id](#input\_policy\_compartment\_id) | Compartment where policy will be created | `string` | n/a | yes |
| <a name="input_service_connector_def"></a> [service\_connector\_def](#input\_service\_connector\_def) | n/a | <pre>map(object({<br>    defined_tags  = optional(map(string))<br>    freeform_tags = optional(map(string))<br>    display_name  = string<br>    description   = optional(string)<br>    state         = optional(string, "ACTIVE")<br>    sch_source    = string<br>    sch_target    = string<br><br>    #For Streaming source<br>    stream_id     = optional(string)<br>    stream_cursor = optional(string)<br>    #For logging source<br>    log_source = optional(list(object({<br>      compartment_id = optional(string)<br>      log_group_id   = optional(string, "_Audit")<br>      log_id         = optional(string)<br>    })))<br>    #For monitoring source<br>    monitoring_source = optional(list(object({<br>      compartment_id   = optional(string)<br>      metric_namespace = list(string)<br>    })))<br><br>    target = object({<br>      #For Objectstorage target<br>      bucket_name                = optional(string)<br>      batch_rollover_size_in_mbs = optional(number, 100)<br>      batch_rollover_time_in_ms  = optional(number, 420000)<br>      object_name_prefix         = optional(string)<br>      #For Streaming target<br>      stream_id = optional(string)<br>      #For Notification target<br>      topic_id = optional(string)<br>      #For Function target<br>      function_id = optional(string)<br>      #For LoggingAnalytics Target<br>      log_group_id   = optional(string)<br>      log_source     = optional(string)<br>      compartment_id = optional(string)<br>    })<br>    tasks = optional(object({<br>      log_condition     = optional(string)<br>      function_id       = optional(string)<br>      batch_size_in_kbs = optional(string, 5120)<br>      batch_time_in_sec = optional(string, 600)<br><br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_tenancy_ocid"></a> [tenancy\_ocid](#input\_tenancy\_ocid) | Tenancy OCID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_service_connectors"></a> [service\_connectors](#output\_service\_connectors) | Service Connector |
<!-- END_TF_DOCS -->