# TerraForm-load-balancer
creating two load balancers(application and netowrk) , one private and the other public , each sending traffic to their instances. 
Sending terraform state file to s3 bucket

## Installation

in order to make the project work you will need to:

1-edit these things:

  a-provider.tf to match your aws credintails files location
  
  b-add .pem file to the main directory
  
  c-on main.tf line 60 , 63 , 100 
    edit the key_name and connection_private_key to match yours


3- before terraform initailizing you will need to hash the terraform backend block on remote-state.tf
    
4- run this commands

    -terraform init
    
    -terraform apply


5- when the apply command finish unhash the terraform block on remote-state.tf and run this command
    
    -terraform init



