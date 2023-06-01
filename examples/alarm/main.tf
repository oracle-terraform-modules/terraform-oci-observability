#Copyright (c) 2023 Oracle Corporation and/or its affiliates.
#Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

module "alarm" {
  source           = "../../modules/alarm"
  alarm_def        = local.alarm_def
  compartment_ocid = local.compartment_ocid
  notification     = local.notification

}

locals {
  compartment_ocid = "<compartment id where notification and alarm will be created>"
  notification = {
    demotopic = {
      subscription = {
        sub1 = {
          protocol = "EMAIL"
          endpoint = "<email address>"
        }
      }
      freeform_tags = {
        env = "test"
      }
    }
  }
  alarm_def = {
    demoalarm = {
      destination  = "demotopic"
      display_name = "demoalarm"
      namespace    = "oci_computeagent"
      query        = "CpuUtilization[1m].mean() > 70"
    }
  }
}
