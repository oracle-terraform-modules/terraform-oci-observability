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
  default     = "ocid1.tenancy.oc1..aaaaaaaa2biiw2clmshec34nq7rcdn2ga6q34rwq3erddvdht5qd4xbaex2a"
  description = "The OCID of the tenancy."
}

variable "compartment_ocid" {
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaa2biiw2clmshec34nq7rcdn2ga6q34rwq3erddvdht5qd4xbaex2a"
  description = "The compartment OCID where all new resources will be created"
}

variable "products" {
  type = string
}

variable "region" {
  type        = string
  default     = "us-phoenix-1"
  description = "OCI region"
}

variable "schema_names" {
  type = map
  default = {
    "abc" = "xyz"
  }
}
