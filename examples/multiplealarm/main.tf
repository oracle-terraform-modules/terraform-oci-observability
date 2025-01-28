#Copyright (c) 2023 Oracle Corporation and/or its affiliates.
#Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

module "multiplealarm" {
  source           = "../../modules/alarm"
  alarm_def        = local.alarm_def_map
  compartment_ocid = local.compartment_ocid
  notification     = local.notification

}

locals {
  compartment_ocid = "<compartment_id>"
  alarm_def        = csvdecode(file("./alarm.csv"))
  alarm_def_map    = { for alarm in local.alarm_def : alarm.key => alarm }
  topicmergelist   = distinct([for alarm in local.alarm_def_map : { create_topic = alarm.create_topic, destination = alarm.destination }])
  notification     = { for topic in local.topicmergelist : topic.destination => { create_topic = topic.create_topic } }
}
