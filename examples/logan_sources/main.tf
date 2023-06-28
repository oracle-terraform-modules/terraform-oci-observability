#Copyright (c) 2023 Oracle Corporation and/or its affiliates.
#Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

module "logan_sources" {
  source = "../../modules/logan_sources"
  schema_names = var.schema_names
  for_each = toset(split(",", var.products))
      path = format("%s/%s", "./contents/sources", each.value)
}
