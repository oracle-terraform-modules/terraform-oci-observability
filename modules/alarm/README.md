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
| [oci_monitoring_alarm.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/monitoring_alarm) | resource |
| [oci_ons_notification_topic.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/ons_notification_topic) | resource |
| [oci_ons_subscription.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/ons_subscription) | resource |
| [oci_ons_notification_topics.existing_topic](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/ons_notification_topics) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_def"></a> [alarm\_def](#input\_alarm\_def) | OCI Alarm definition | <pre>map(object({<br>    destination                  = string<br>    display_name                 = string<br>    severity                     = optional(string, "CRITICAL")<br>    query                        = string<br>    is_enabled                   = optional(bool, true)<br>    namespace                    = string<br>    metric_compartment_id        = optional(string)<br>    repeat_notification_duration = optional(string, "PT5M")<br>    trigger                      = optional(string, "PT5M")<br>    suppression_from_time        = optional(string)<br>    suppression_till_time        = optional(string)<br>    message_format               = optional(string, "RAW")<br>    body                         = optional(string, null)<br>    freeform_tags                = optional(map(string))<br>    defined_tags                 = optional(map(string))<br>  }))</pre> | n/a | yes |
| <a name="input_compartment_ocid"></a> [compartment\_ocid](#input\_compartment\_ocid) | Compartment OCID | `string` | n/a | yes |
| <a name="input_label_prefix"></a> [label\_prefix](#input\_label\_prefix) | Prefix to be added to the resources | `string` | `"none"` | no |
| <a name="input_notification"></a> [notification](#input\_notification) | Notification Topic and Subscription | <pre>map(object({<br>    description   = optional(string)<br>    create_topic  = optional(bool, true)<br>    defined_tags  = optional(map(string))<br>    freeform_tags = optional(map(string))<br>    subscription = optional(map(object({<br>      endpoint = string<br>      protocol = string<br>    })))<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_topic_ids"></a> [topic\_ids](#output\_topic\_ids) | Notification Topic OCID |
<!-- END_TF_DOCS -->