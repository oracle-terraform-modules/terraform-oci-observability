# Copyright (c) 2022, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

variable "config_file_profile" {
  default = "DEFAULT"
}

variable "auth_type" {
    default = "instance"
}

variable "tenancy_ocid" {
  type        = string
  description = "The OCID of the tenancy."
}

variable "compartment_ocid" {
  type        = string
  description = "The compartment OCID where all new resources will be created"
}

variable "products" {
  type = string
}

variable "region" {
  type        = string
  description = "OCI region"
}

variable "schema_names" {
  type = map
  default = {
    "abc" = "xyz"
  }
}
