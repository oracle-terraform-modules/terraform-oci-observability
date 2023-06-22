#Copyright (c) 2023 Oracle Corporation and/or its affiliates.
#Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

# Import custom content after property values are substituted
resource null_resource import_contents {
  triggers = {
    auth_type = "user"
    profile_name = "test"
    schema_names = format("%q", jsonencode(var.schema_names))
    path = format("%q", var.path)
    current_time = timestamp()
  }

  provisioner "local-exec" {
    command = "python3 ../../scripts/import_contents.py -a ${self.triggers.auth_type} -p ${self.triggers.profile_name} -e ${self.triggers.schema_names} -f ${self.triggers.path}"
  }
}
