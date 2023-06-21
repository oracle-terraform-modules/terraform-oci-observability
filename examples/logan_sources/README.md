## Import custom content after substituting property values

This example is to import custom contents from the content path provided as input. It iterates over each content xml listed in the content path and substitute the property name with value from schema_names map and then imports the custom contents.

Rename the provider.tf.example to provider.tf  and provide the required values   

Also rename the terraform.tfvars.example to terraform.tfvars and provide products value as a comma separated product names string. And property name value map in schema_names as shown in the example.  

Make sure that the configuration file is placed at default location(~/.oci/) by populating the user and tenancy details as follows
```console
[DEFAULT]
user=<user OCID>
fingerprint=<user_fingerprint>
key_file=<pem file location>
tenancy=<tenancy OCID>
region=<oci region>
```

Run the terraform commands to execute 
```console
terraform init
terraform plan
terraform apply
```
