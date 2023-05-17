module "alarm" {
  source           = "./modules/alarm"
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
    "testdelete" = {
      destination = "demotopic"
      namespace   = "oci_computeagent"
      query       = "CpuUtilization[1m].mean() > 70"
    }
  }
}
