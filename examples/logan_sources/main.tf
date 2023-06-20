module "logan_sources" {
  source = "../../modules/logan_sources"
  schema_names = var.schema_names
  for_each = toset(split(",", var.products))
      path = format("%s/%s", "./contents/sources", each.value)
}
