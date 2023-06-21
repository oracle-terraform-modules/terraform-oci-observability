# Copyright (c) 2022, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

variable "config_file_profile" {
  default = "DEFAULT"
}

variable "auth_type" {
    default = "user"
}

variable "products" {
  type = string
}

variable "schema_names" {
  type = map
  default = {
    "abc" = "xyz"
  }
}
