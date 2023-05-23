## Multiple Alarm creation

This example is to create multiple alarm with notification topic based on csv file.   
Rename the provider.tf.example to provider.tf  and provide the required values   
  
This example does not create any subscription for the topic.

In the csv for the column named create_topic specify *true* if the topic has to be created and *false* if you want to use existing topic.
  
Run the terraform commands to execute 
```console
terraform init
terraform plan
terraform apply
```