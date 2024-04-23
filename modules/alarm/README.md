## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
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
| <a name="input_alarm_def"></a> [alarm\_def](#input\_alarm\_def) | OCI Alarm definition | <pre>map(object({<br>    destination                  = string<br>    display_name                 = optional(string)<br>    severity                     = optional(string)<br>    query                        = string<br>    is_enabled                   = optional(bool)<br>    rule_name                    = optional(string)<br>    namespace                    = string<br>    metric_compartment_id        = optional(string)<br>    repeat_notification_duration = optional(string)<br>    trigger                      = optional(string)<br>    suppression_from_time        = optional(string)<br>    suppression_till_time        = optional(string)<br>    message_format               = optional(string)<br>    body                         = optional(string)<br>    freeform_tags                = optional(map(string))<br>    defined_tags                 = optional(map(string))<br>    resolution                   = optional(string)<br>    resource_group               = optional(string)<br>    split_notification           = optional(bool)<br>    has_overrides                = optional(bool)<br>    overrides                    = optional(map(object({<br>      body      = optional(string)<br>      trigger   = optional(string)<br>      query     = optional(string)<br>      rule_name = optional(string)<br>      severity  = optional(string)<br>    })))<br>  }))</pre> | n/a | yes |
| <a name="input_alarm_name_prefix"></a> [alarm\_name\_prefix](#input\_alarm\_name\_prefix) | Prefix to be added to alarm resources | `string` | `"none"` | no |
| <a name="input_compartment_ocid"></a> [compartment\_ocid](#input\_compartment\_ocid) | Compartment OCID | `string` | n/a | yes |
| <a name="input_notification"></a> [notification](#input\_notification) | Notification Topic and Subscription | <pre>map(object({<br>    description   = optional(string)<br>    create_topic  = optional(bool)<br>    defined_tags  = optional(map(string))<br>    freeform_tags = optional(map(string))<br>    subscription = optional(map(object({<br>      endpoint = string<br>      protocol = string<br>    })))<br>  }))</pre> | n/a | yes |
| <a name="input_topic_name_prefix"></a> [topic\_name\_prefix](#input\_topic\_name\_prefix) | Prefix to be added to topic resources | `string` | `"none"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_topic_ids"></a> [topic\_ids](#output\_topic\_ids) | Notification Topic OCID |
