## Service Connector creation

This example is to create a service connector with source as streaming and target as object storage.    
Rename the provider.tf.example to provider.tf and provide the required values   
  
Local values are defined to test it quickly.   
If you like to create multiple service connectors then rename the terraform.tfvars.example to terraform.tfvars and provide the required values   

Supported values for sch_source in variable service_connector_def is     
- streaming     
- logging      
- monitoring    

Supported values for sch_target in variable service_connector_def is     
- loggingAnalytics      
- objectstorage
- functions
- streaming
- notifications

If the dynamic group is created manually then the variable *dynamic_group* can be empty map `{}` which is the default value 

Run the terraform commands to execute 
```console
terraform init
terraform plan
terraform apply
```