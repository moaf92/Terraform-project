# Terraform-project
After installing terraform on our machine, we will store the state the information of our infra in s3 bucket, we will use terraform to access our aws cloud and create vpc which is distributed among multiple zones we will have public subnets connected to internet gateway with our route table that routes the traffic to IG , also private subnets which will be connected to nat gateway through route table, and start a bastion host to access  these privat subnets
- Setup terraform with backend
- Setup VPC 
- provision beanstalk env
- provision backend service 'RDS,Elastic cashe,Active MQ'
- security group, keypairs,bastion host
