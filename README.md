# HA Drupal Site on AWS


## Prereqs
* You have a hosted zone in Route 53, e.g. your-domain.com

* You have an issued certificate for your-domain.com in AWS Certificate Manager
## AWS

Before starting with Terraform you should have configured your credentials in the AWS folder in your system as shown below.

```aws
[default]
aws_access_key_id =
aws_secret_access_key =
[prod]
aws_access_key_id =
aws_secret_access_key =
```
### Initializing Terraform

```sh
terraform init
```
### Running Terraform

Run the following to ensure ***terraform*** will only perform the expected
actions:

```sh
terraform plan
```
Run the following to ensure ***terraform*** will only perform the expected actions with the  variables from a specific environment file

```sh
terraform plan --var-file="target-file"
```

Run the following to apply the configuration to the target aws Cloud
environment:

```sh
terraform apply
```
Run the following to apply the configuration and read variables from a specific environment file

```sh
terraform apply --var-file="target-file"
```

### SSH Into EC2 Instnces
Ec2 instances can only   be  accessed by a bastion host.
connect to a bastion host by 
```sh
    ssh-add ./myKeyPair
    ssh -A ubuntu@your-bastion-public-ipv4-dns
```
Connect to a ec2 from inside a bastion  host by 
```sh
    ssh   bitnami@your-ec2-public-ipv4-dns
```

you can remove previously added keypairs from ssh-agent using
```sh
ssh-add -D
```
### Access Drupal Site

Your drupal website can be  accessed from  your-domain.com

### Destroy Environment

```sh
terraform destroy
```

 